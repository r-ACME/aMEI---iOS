//
//  FAQRemoteDataBase.swift
//  aMEI
//
//  Created by coltec on 22/06/23.
//

import Foundation
import Combine
import SQLite3

class FAQRemoteDataBase{
    
    static var shared: FAQRemoteDataBase = FAQRemoteDataBase()
    
    private init(){
        
    }
    
    func getFAQs(db: OpaquePointer?) -> [FAQ]{
        
        var faq: [FAQ] = []
        
        var statement: OpaquePointer? = nil
        let query = "SELECT * FROM faq"

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_int(statement, 0))
                var question = ""
                if let cString = sqlite3_column_text(statement, 1){
                    question = String(cString: cString)
                }
                var answer = ""
                if let cString = sqlite3_column_text(statement, 2){
                    answer = String(cString: cString)
                }
                
                faq.append(FAQ(id: id, question: question, answer: answer))
            }
        }
        sqlite3_finalize(statement)
        
        return faq
    }
    
}
