//
//  LocalDataSource.swift
//  aMEI
//
//  Created by coltec on 16/06/23.
//

import Foundation
import Combine

class LocalDataSource{
    
    static var shared: LocalDataSource = LocalDataSource()
    
    private init(){
        
    }
    
    private func saveValue(value: UserAuth){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "current_user")
    }
    
    private func readValue(forKey key: String) -> UserAuth?{
        var currentUser: UserAuth?
        if let data = UserDefaults.standard.value(forKey: key) as? Data{
            currentUser = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        if ((currentUser?.cnpj.isEmpty) != nil){
            return currentUser
        }
            
        return UserAuth(cnpj: "", password: "")
    }
    
    func insertCurrentUser(user: UserAuth){
        saveValue(value: user)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never>{
        let currentUser = readValue(forKey: "current_user")
        return Future{ promise in
            promise(.success(currentUser))
        }
    }
    
    func removeUserAuth() {
        UserDefaults.standard.removeObject(forKey: "current_user")
        UserDefaults.standard.synchronize()
    }
}

