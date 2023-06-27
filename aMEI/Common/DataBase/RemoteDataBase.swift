//
//  DataBase.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation
import SQLite3

class DataBase{
    
    var db: OpaquePointer?
    var databasePath: String = ""
    init(){
        if let bundlePath = Bundle.main.bundlePath as NSString? {
            databasePath = bundlePath.deletingLastPathComponent
        }
    }
    
    func createDataBase(){
        
        let createTableQuery = SQLDataBase.database.rawValue
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            // Handle error
            print("Failed to create table")
        }
        
    }
    
    func openDataBase() -> OpaquePointer?{
        
        if sqlite3_open(databasePath, &db) != SQLITE_OK {
            // Handle error
            print("Failed to open database")
        }
        
        return db
    }
    
    func executeQueries(query: String) -> Any{
        
//        let query = "SELECT * FROM your_table"
        var statement: OpaquePointer?
        var result: Any = ""
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            
            
            while sqlite3_step(statement) == SQLITE_ROW {
                
                //Atribuiçao item a item das variaveis para criar o objeto
                
//                let id = Int(sqlite3_column_int(statement, 0))
//                let name = String(cString: sqlite3_column_text(statement, 1))
//                let age = Int(sqlite3_column_int(statement, 2))
                       
                
            }
        }
        sqlite3_finalize(statement) // Release the statement when done
        
        return result
    }
    
    
    func closeDataBase(){
        if sqlite3_close(db) != SQLITE_OK {
            // Handle error
            print("Failed to close database")
        }
    }
}
