//
//  CNPJErrorResponse.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation

struct CNPJErrorResponse: Error, Decodable{
    
    let status: Int
    let titulo: String
    let detalhes: String
    let validacao: String
    
    enum CodingKeys: String, CodingKey{
        case status
        case titulo
        case detalhes
        case validacao
    }
}

struct CEPErrorResponse: Error, Decodable{
    
    let name: String
    let message: String
    let type: String
    let errors: [GenericErrorCEP]
}

struct GenericErrorCEP: Error, Decodable{
    let name: String
    let message: String
    let service: String
}
