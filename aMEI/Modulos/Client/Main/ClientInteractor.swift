//
//  File.swift
//  aMEI
//
//  Created by coltec on 21/06/23.
//

import Foundation
import Combine
import SQLite3

class ClientInteractor{
    
    private let remoteClientDataBase: ClientRemoteDataSource = .shared
    private let remoteDataBase: RemoteDataBase = .shared
    private let local: LocalDataSource = .shared
    
    func fetchClients() -> [ClientRawData]{
        remoteClientDataBase.getAllClients(db: remoteDataBase.db)
    }
    func fetchPerson(id: Int) -> Person{
        remoteClientDataBase.getPersonData(id: id, db: remoteDataBase.db)
    }
    func fetchCompany(id: Int) -> Company{
        remoteClientDataBase.getCompanyData(id: id, db: remoteDataBase.db)
    }
    func fetchAdress(id: Int) -> Endereco{
        remoteClientDataBase.getAdressData(id: id, db: remoteDataBase.db)
    }
}
