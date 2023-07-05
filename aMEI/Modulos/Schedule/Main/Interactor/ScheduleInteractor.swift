//
//  ScheduleInteractor.swift
//  aMEI
//
//  Created by coltec on 22/06/23.
//

import Foundation
import Combine
import SQLite3

class ScheduleInteractor{
    
    private let remoteClientDataBase: ScheduleRemoteDataBase = .shared
    private let remoteDataBase: RemoteDataBase = .shared
    private let local: LocalDataSource = .shared
    
    func getScheduleData(date: Date) -> [Schedule]{
        remoteClientDataBase.getScheduleData(date: date, db: remoteDataBase.db)
    }
}
