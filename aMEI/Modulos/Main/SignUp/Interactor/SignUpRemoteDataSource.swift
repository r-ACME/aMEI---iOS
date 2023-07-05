//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by coltec on 13/06/23.
//

import Foundation
import Combine
import SQLite3

class SignUpRemoteDataSource{
    
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init(){
        
    }
    
    func createAccount(query: [String], db: OpaquePointer?) -> Future <Bool, AppError>{//Generico apenas para verificar o padrão ///NAO UTILIZAR
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
                            promise(.failure(AppError.response(message: CNPJErrorResponse(status: 403, titulo: "Usuário já cadastrado", detalhes: "", validacao: ""))))
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
    
    func buscaCNPJ(request: String) -> Future<CNPJConsulta, CNPJErrorResponse>{
        
        return Future<CNPJConsulta, CNPJErrorResponse>{ promise in
            
            WebService.call(cnpj: request){ result in
                switch result{
                case .failure(let error, let data):
                    if let data = data{
                        if error == .unauthorized{
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(CNPJErrorResponse.self, from: data)
                            promise(.failure(CNPJErrorResponse(status: response?.status ?? 404, titulo: response?.titulo ?? "", detalhes: response?.detalhes ?? "", validacao: response?.validacao ?? "")))
                        }
                        if error == .toManny{
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(CNPJErrorResponse.self, from: data)
                            promise(.failure(CNPJErrorResponse(status: response?.status ?? 429, titulo: response?.titulo ?? "Muitas pesquisas", detalhes: response?.detalhes ?? "Aguarde um momento e tente novamente", validacao: response?.validacao ?? "")))
                        }
                    }
                    break
                case .success(let data):
                    if let data = data{
                        let decoder = JSONDecoder()//Erro
                        let response = try? decoder.decode(CNPJConsulta.self, from: data)
                        
//                        print("AQUI>>>>> \(String(data:data, encoding: .utf8)!)")
//                        print("ALI>>>>> \(response)")
                        
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
}
