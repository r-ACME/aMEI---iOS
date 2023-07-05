//
//  ClientRemoteDataSource.swift
//  aMEI
//
//  Created by coltec on 21/06/23.
//

import Foundation
import Combine
import SQLite3

class ClientRemoteDataSource{
    
    static var shared: ClientRemoteDataSource = ClientRemoteDataSource()
    
    private init(){
        
    }
    
    func getAdressData(id: Int, db: OpaquePointer?) -> Endereco{
        
        var statement: OpaquePointer? = nil
        let query = "SELECT * FROM adress WHERE id = \(id)"
        var result = Endereco(id: 0, street: "", number: "", complement: "", cep: "", neighborhood: "", city: "", state: "")
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_int(statement, 0))
                var street = ""
                if let cString = sqlite3_column_text(statement, 1){
                    street = String(cString: cString)
                }
                var number = ""
                if let cString = sqlite3_column_text(statement, 2){
                    number = String(cString: cString)
                }
                var complement = ""
                if let cString = sqlite3_column_text(statement, 3){
                    complement = String(cString: cString)
                }
                var cep = ""
                if let cString = sqlite3_column_text(statement, 4){
                    cep = String(cString: cString)
                }
                var neighborhood = ""
                if let cString = sqlite3_column_text(statement, 5){
                    neighborhood = String(cString: cString)
                }
                var city = ""
                if let cString = sqlite3_column_text(statement, 6){
                    city = String(cString: cString)
                }
                var state = ""
                if let cString = sqlite3_column_text(statement, 7){
                    state = String(cString: cString)
                }
                result = Endereco(id: id, street: street, number: number, complement: complement, cep: cep, neighborhood: neighborhood, city: city, state: state)
            }
        }
        sqlite3_finalize(statement)
        return result
    }
    
    func getPersonData(id: Int, db: OpaquePointer?) -> Person{
        let person = getClientData(query: "SELECT * FROM person WHERE id = \(id)", db: db)
        return person
    }
    
    func getCompanyData(id: Int, db: OpaquePointer?) -> Company{
        let data = getClientData(query: "SELECT id, adress_id, nome, cnpj, telefone, email FROM company WHERE id = \(id)", db: db)
        var company = Company(id: 0, adressId: 0, name: "", document: "", phone: "", email: "")
        company.id = data.id
        company.adressId = data.adressId
        company.name = data.name
        company.document = data.document
        company.phone = data.phone
        company.email = data.email
        return company
    }
    
    func getClientData(query: String, db: OpaquePointer?) -> Person{
        
        var statement: OpaquePointer? = nil
        var result = Person(id: 0, adressId: 0, name: "", document: "", phone: "", email: "")
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_int(statement, 0))
                let adressId = Int(sqlite3_column_int(statement, 1))
                var name = ""
                if let cString = sqlite3_column_text(statement, 2){
                    name = String(cString: cString)
                }
                var document = ""
                if let cString = sqlite3_column_text(statement, 3){
                    document = String(cString: cString)
                }
                var phone = ""
                if let cString = sqlite3_column_text(statement, 4){
                    phone = String(cString: cString)
                }
                var email = ""
                if let cString = sqlite3_column_text(statement, 5){
                    email = String(cString: cString)
                }
                result = Person(id: id, adressId: adressId, name: name, document: document, phone: phone, email: email)
            }
        }
        sqlite3_finalize(statement)
        return result
    }
    
    func getAllClients(db: OpaquePointer?) -> [ClientRawData]{
        var clientRawData: [ClientRawData] = []
        
        var dados: [ClientRawData] = []
        var statement: OpaquePointer? = nil
        
        var query = "SELECT * FROM client"
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_int(statement, 0))
                let personId = Int(sqlite3_column_int(statement, 1))
                let companyId = Int(sqlite3_column_int(statement, 2))
                var type = ""
                if let cString = sqlite3_column_text(statement, 3){
                    type = String(cString: cString)
                }
                let intActive = Int(sqlite3_column_int(statement, 4))
                var active: Bool = false
                if intActive == 1{
                    active = true
                }
                let result = ClientRawData(id: id, personId: personId, companyId: companyId, type: type, active: active, name: "")
                dados.append(result)
            }
        }
        sqlite3_finalize(statement)
        
        
        for var dado in dados{
            statement = nil
            if dado.personId == 0{
                query = "SELECT nome FROM company WHERE id = \(dado.companyId)"
            }
            else{
                query = "SELECT name FROM person WHERE id = \(dado.personId)"
            }
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    var nome = ""
                    if let cString = sqlite3_column_text(statement, 0){
                        nome = String(cString: cString)
                    }
                    dado.name = nome
                    clientRawData.append(dado)
                }
            }
            sqlite3_finalize(statement)
        }
        

        return clientRawData
    }
    
    
}
