//
//  SignUpInteractor.swift
//  aMEI
//
//  Created by coltec on 13/06/23.
//

import Foundation
import Combine
import SQLite3

class CreateScheduleInteractor{
    
    private let remoteCreateSchedule: CreateScheduleRemoteDataSource = .shared
    private let remoteDataBase: RemoteDataBase = .shared
    private let local: LocalDataSource = .shared
    
    func fetchLastId(table: String) -> Int{
        remoteDataBase.getLastId(table: table, db: remoteDataBase.db)
    }
    
    func saveSchedule(query: [String]) -> Future<Bool, AppError>{
        remoteCreateSchedule.saveSchedule(query: query, db: remoteDataBase.db)
    }
    
}
