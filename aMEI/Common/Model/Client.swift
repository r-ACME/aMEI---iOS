//
//  Client.swift
//  aMEI
//
//  Created by coltec on 20/06/23.
//

import Foundation

struct Client: Codable, Equatable, Identifiable{
    
    var id: Int
    var personId: Int
    var companyId: Int
    var type: String
    var active: Int

}

struct ClientRawData: Codable, Equatable, Identifiable{
    var id: Int
    var personId: Int
    var companyId: Int
    var type: String
    var active: Bool
    var name: String
}

struct Person: Codable{
    
    var id: Int
    var adressId: Int
    var name: String
    var document: String
    var phone: String
    var email: String
}

struct Company: Codable{
    
    var id: Int
    var adressId: Int
    var name: String
    var document: String
    var phone: String
    var email: String
}

enum ClientType: String, CaseIterable, Identifiable{
    case person = "CPF"
    case company = "CNPJ"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index{
        return Self.allCases.firstIndex{ self == $0} ?? 0
    }
}
