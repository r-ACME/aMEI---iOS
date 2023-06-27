//
//  LocalDataSource.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import Combine

class LocalDataSource{
    
    static var shared: LocalDataSource = LocalDataSource()
    
    private init(){
        
    }
    
    private func saveValue(value: UserAuth){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    private func readValue(forKey key: String) -> UserAuth?{
        var userAuth: UserAuth?
        if let data = UserDefaults.standard.value(forKey: key) as? Data{
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        return userAuth
    }
    
    func insertUserAuth(userAuth: UserAuth){
        saveValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never>{
        let userAuth = readValue(forKey: "user_key")
        return Future{ promise in
            promise(.success(userAuth))
        }
    }
}
