//
//  ScheduleRemoteDataBase.swift
//  aMEI
//
//  Created by coltec on 22/06/23.
//

import Foundation
import Combine
import SQLite3

class ScheduleRemoteDataBase{
    
    static var shared: ScheduleRemoteDataBase = ScheduleRemoteDataBase()
    
    private init(){
        
    }
    
    func getScheduleData(date: Date, db: OpaquePointer?) -> [Schedule]{
        
        var statement: OpaquePointer? = nil
        var result: [Schedule] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var data = formatter.string(from: date)
        let query = "SELECT * FROM schedule WHERE datetime LIKE '%\(data)%'"

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_int(statement, 0))
                var datetime = ""
                if let cString = sqlite3_column_text(statement, 1){
                    datetime = String(cString: cString)
                }
                var title = ""
                if let cString = sqlite3_column_text(statement, 2){
                    title = String(cString: cString)
                }
                var description = ""
                if let cString = sqlite3_column_text(statement, 3){
                    description = String(cString: cString)
                }
                var alert = ""
                if let cString = sqlite3_column_text(statement, 4){
                    alert = String(cString: cString)
                }
                let clientid = Int(sqlite3_column_int(statement, 5))
                result.append(Schedule(id: id, datetime: datetime, title: title, description: description, alert: alert, clientid: clientid))
            }
        }
        sqlite3_finalize(statement)

        return result
    }
    
}
