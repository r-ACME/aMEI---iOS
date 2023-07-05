//
//  CreateScheduleDataSource.swift
//  aMEI
//
//  Created by coltec on 20/06/23.
//

import Foundation
import Combine
import SQLite3

class CreateClientRemoteDataSource{
    
    static var shared: CreateClientRemoteDataSource = CreateClientRemoteDataSource()
    
    private init(){
        
    }
    
    func saveClient(query: [String], db: OpaquePointer?) -> Future <Bool, AppError>{//Generico apenas para verificar o padrão ///NAO UTILIZAR
        return Future{ promise in
            var statement: OpaquePointer? = nil
            
            for query in query{
                if query != ""{
                    if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                        if sqlite3_step(statement) == SQLITE_DONE{
                            print("Insert statment success.")
                            
                        } else {
                            print("Insert statment failure. \(query)")
                            promise(.failure(AppError.response(message: CNPJErrorResponse(status: 403, titulo: "Cliente já cadastrado", detalhes: "", validacao: ""))))
                        }
                    }
                    else{
                        promise(.failure(AppError.response(message: CNPJErrorResponse(status: 403, titulo: "Erro na Query", detalhes: "", validacao: ""))))
                    }
                    sqlite3_finalize(statement)
                }
            }
            promise(.success(true))
        }
    }
    
    func buscaCEP(request: String) -> Future<CEP, CEPErrorResponse>{
        
        return Future<CEP, CEPErrorResponse>{ promise in
            
            WebService.call(cep: request){ result in
                switch result{
                case .failure(let error, let data):
                    if let data = data{
                        if error == .unauthorized{
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(CEPErrorResponse.self, from: data)
                            promise(.failure(CEPErrorResponse(name: response?.name ?? "", message: response?.message ?? "", type: response?.type ?? "", errors: response?.errors ?? [GenericErrorCEP(name: "", message: "", service: "")])))
                        }
                    }
                    break
                case .success(let data):
                    if let data = data{
                        let decoder = JSONDecoder()//Erro
                        let response = try? decoder.decode(CEP.self, from: data)
                        guard let response = response else{
                            print("Log: Error parser \(String(data:data, encoding: .utf8)!)")
                            return
                        }
                        
                        promise(.success(response))
                    }
                    break
                }
            }
        }
    }
    
    func buscaCPF(request: String, db: OpaquePointer?) -> Future<Bool, AppError>{
        
        return Future{ promise in
            var statement: OpaquePointer? = nil
            var result = 0
            
            let query = "SELECT count(id) FROM person WHERE document = '\(request)'"
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    result = Int(sqlite3_column_int(statement, 0))
                }
            }
            else{
                promise(.failure(AppError.response(message: CNPJErrorResponse(status: 403, titulo: "Erro na Query", detalhes: "", validacao: ""))))
            }
            sqlite3_finalize(statement)
            if result != 0{
                promise(.success(false))
            }
            else{
                promise(.success(true))
            }
        }
    }
    
    func buscaCNPJ(request: String, db: OpaquePointer?) -> Future<Bool, AppError>{
        
        return Future{ promise in
            var statement: OpaquePointer? = nil
            var result = 0
            var companyId = 0
            
            var query = "SELECT id FROM company WHERE cnpj = '\(request)'"
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    companyId = Int(sqlite3_column_int(statement, 0))
                }
                
                if companyId != 0 {
                    
                    query = "SELECT count(id) FROM client WHERE company_id = '\(companyId)'"
                    
                    if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                        while sqlite3_step(statement) == SQLITE_ROW {
                            result = Int(sqlite3_column_int(statement, 0))
                        }
                    }
                    if result != 0{
                        promise(.failure(AppError.response(message: CNPJErrorResponse(status: 403, titulo: "Cliente já cadastrado", detalhes: "", validacao: ""))))
                    }
                    else{
                        promise(.success(true))
                    }
                }
                else {//Não encontrou id
                    promise(.success(false))
                }
            }
            else{//Erro na query
                promise(.failure(AppError.response(message: CNPJErrorResponse(status: 403, titulo: "Erro na Query", detalhes: "", validacao: ""))))
            }
            sqlite3_finalize(statement)
        }
    }
}
