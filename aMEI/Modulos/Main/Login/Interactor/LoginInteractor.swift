//
//  LoginInteractor.swift
//  aMEI
//
//  Created by coltec on 13/06/23.
//

import Foundation
import Combine

class LoginInteractor{
    
    private let remote: LoginRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    private let remoteDataBase: RemoteDataBase = .shared
    
    func insertAuth(user: UserAuth){
        local.insertCurrentUser(user: user)
    }
    
    func fetchAuth() -> Future<UserAuth?, Never>{
        return local.getUserAuth()
    }
    
    func login(request: UserAuth) -> Future<Bool, AppError>{
        
        return remote.login(request: request, db: remoteDataBase.db)
    }
    
}
