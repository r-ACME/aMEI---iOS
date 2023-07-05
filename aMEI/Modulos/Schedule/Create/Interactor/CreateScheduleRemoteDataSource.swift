//
//  CreateScheduleDataSource.swift
//  aMEI
//
//  Created by coltec on 20/06/23.
//

import Foundation
import Foundation
import Combine
import SQLite3

class CreateScheduleRemoteDataSource{
    
    static var shared: CreateScheduleRemoteDataSource = CreateScheduleRemoteDataSource()
    
    private init(){
        
    }
 
    func saveSchedule(query: [String], db: OpaquePointer?) -> Future <Bool, AppError>{//Generico apenas para verificar o padrão ///NAO UTILIZAR
        return Future{ promise in
            var statement: OpaquePointer? = nil
            
            for query in query{
                if query != ""{
                    if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                        if sqlite3_step(statement) == SQLITE_DONE{
                            print("Insert statment success.")
                            promise(.success(true))
                        } else {
                            print("Insert statment failure. \(query)")
                            promise(.failure(AppError.response(message: CNPJErrorResponse(status: 403, titulo: "Agendamento já cadastrado", detalhes: "", validacao: ""))))
                        }
                    }
                    else{
                        promise(.failure(AppError.response(message: CNPJErrorResponse(status: 403, titulo: "Erro na Query", detalhes: "", validacao: ""))))
                    }
                    sqlite3_finalize(statement)
                }
            }
        }
    }
    
    
}
