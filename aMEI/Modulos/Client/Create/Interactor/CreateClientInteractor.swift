//
//  CreateClientInteractor.swift
//  aMEI
//
//  Created by coltec on 20/06/23.
//

import Foundation
import Combine
import SQLite3

class CreateClientInteractor{
    
    private let remoteCreateClient: CreateClientRemoteDataSource = .shared
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteDataBase: RemoteDataBase = .shared
    private let local: LocalDataSource = .shared
    
    func fetchLastId(table: String) -> Int{
        remoteDataBase.getLastId(table: table, db: remoteDataBase.db)
    }
    
    func saveClient(query: [String]) -> Future<Bool, AppError>{
        remoteCreateClient.saveClient(query: query, db: remoteDataBase.db)
    }
    
    func fetchCompanyId(cnpj: String) -> Int{
        remoteDataBase.getCompanyId(cnpj: cnpj, db: remoteDataBase.db)
    }
    
    func buscaCEP(request: String) -> Future<CEP, CEPErrorResponse>{
        remoteCreateClient.buscaCEP(request: request)
    }
    
    func buscaCPF(request: String) -> Future<Bool, AppError>{
        remoteCreateClient.buscaCPF(request: request, db: remoteDataBase.db)
    }
    
    func buscaCNPJ(request: String) -> Future<CNPJConsulta, CNPJErrorResponse>{
        remoteSignUp.buscaCNPJ(request: request)
    }
    
    func buscaCNPJ(cnpj: String) -> Future<Bool, AppError>{
        remoteCreateClient.buscaCNPJ(request: cnpj, db: remoteDataBase.db)
    }
}
