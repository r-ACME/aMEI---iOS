//
//  FAQInteractor.swift
//  aMEI
//
//  Created by coltec on 22/06/23.
//

import Foundation
import Combine
import SQLite3

class FAQInteractor{
    
    private let remoteFAQDataBase: FAQRemoteDataBase = .shared
    private let remoteDataBase: RemoteDataBase = .shared
    private let local: LocalDataSource = .shared
    
    func getFAQs() -> [FAQ]{
        remoteFAQDataBase.getFAQs(db: remoteDataBase.db)
    }
}

