//
//  CEPConsulta.swift
//  aMEI
//
//  Created by coltec on 20/06/23.
//

import Foundation

struct CEP: Decodable{
    var cep: String
    var state: String
    var city: String
    var neighborhood: String
    var street: String
    var service: String
}


struct Endereco: Decodable, Equatable, Identifiable{
    var id: Int
    var street: String
    var number: String
    var complement: String
    var cep: String
    var neighborhood: String
    var city: String
    var state: String

}
