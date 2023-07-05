//
//  DataBaseService.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation
import Combine
import SQLite3

class DataBaseService{
    
    
    func executeQueries(query: String, db: OpaquePointer?) -> Any{//Generico apenas para verificar o padrão ///NAO UTILIZAR
        
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
    
}
