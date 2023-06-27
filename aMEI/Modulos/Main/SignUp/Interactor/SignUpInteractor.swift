//
//  SignUpInteractor.swift
//  aMEI
//
//  Created by coltec on 13/06/23.
//

import Foundation
import Combine
import SQLite3

class SignUpInteractor{
    
    private let remoteLogin: LoginRemoteDataSource = .shared
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteDataBase: RemoteDataBase = .shared
    private let local: LocalDataSource = .shared

    func createAccount(query: [String]) -> Future<Bool, AppError>{
        return remoteSignUp.createAccount(query: query, db: remoteDataBase.db)
    }
    
    func buscaCNPJ(request: String) -> Future<CNPJConsulta, CNPJErrorResponse>{
        remoteSignUp.buscaCNPJ(request: request)
    }
    
    func fetchLastId(table: String) -> Int{
        remoteDataBase.getLastId(table: table, db: remoteDataBase.db)
    }
    
    func login(request: UserAuth) -> Future<Bool, AppError>{
        return remoteLogin.login(request: request, db: remoteDataBase.db)
    }
    
    func insertAuth(user: UserAuth){
        local.insertCurrentUser(user: user)
    }
    
}
