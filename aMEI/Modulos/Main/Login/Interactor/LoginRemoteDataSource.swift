//
//  LoginRemoteDataSource.swift
//  aMEI
//
//  Created by coltec on 13/06/23.
//

import Foundation
import Combine
import SQLite3

class LoginRemoteDataSource{
    
    static var shared: LoginRemoteDataSource = LoginRemoteDataSource()
    
    private init(){
        
    }
    
    func login(request: UserAuth, db: OpaquePointer?) -> Future<Bool, AppError>{
        
        return Future<Bool, AppError>{ promise in
            
            var statement: OpaquePointer?
            var result: [User] = []
            var query = "SELECT * FROM users"
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                
                while sqlite3_step(statement) == SQLITE_ROW {
                    var user : User
                    //Atribuiçao item a item das variaveis para criar o objeto
                    
                    let id = Int(sqlite3_column_int(statement, 0))
                    let companyId = Int(sqlite3_column_int(statement, 1))
                    let cnpj = String(cString: sqlite3_column_text(statement, 2))
                    let password = String(cString: sqlite3_column_text(statement, 3))
                           
                    user = User(id: id, companyId: companyId, cnpj: cnpj, password: password)
                    
                    result.append(user)
                }
            }
            sqlite3_finalize(statement) // Release the statement when done
            
            for user in result{
                if (user.cnpj == request.cnpj){
                    if (user.password == request.password){
                        promise(.success(true))
                        return
                    }
                    else{
                        break
                    }
                }
            }
            
            promise(.failure(AppError.response(message: CNPJErrorResponse(status: 401, titulo: "Usuário não encontrado", detalhes: "Usuário ou senha invalidos", validacao: ""))))
        }
    }
}
