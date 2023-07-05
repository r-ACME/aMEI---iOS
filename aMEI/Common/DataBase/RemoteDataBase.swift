//
//  DataBase.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation
import SQLite3
import Combine

class RemoteDataBase{
    
    var db: OpaquePointer?
    private let databaseName = "aMEIDataBase.sqlite"
    private var databasePath: String?
    
    static var shared: RemoteDataBase = RemoteDataBase()
    
    private init(){
        databasePath = getDatabasePath()
        createDatabaseIfNeeded()
    }

    deinit{
        closeDataBase()
    }
    
    private func getDatabasePath() -> String? {
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let databaseURL = documentsURL.appendingPathComponent(databaseName)
        return databaseURL.path
    }
    
    private func runCreates(){
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, SQLDataBase.createFAQ.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createFAQ statment success.")
                } else {
                    print("createFAQ statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createTYPE.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createTYPE statment success.")
                } else {
                    print("createTYPE statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createFINANCIAL.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createFINANCIAL statment success.")
                } else {
                    print("createFINANCIAL statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createSERVICE.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createSERVICE statment success.")
                } else {
                    print("createSERVICE statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createPRODUCT.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createPRODUCT statment success.")
                } else {
                    print("createPRODUCT statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createINVENTORY.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createINVENTORY statment success.")
                } else {
                    print("createINVENTORY statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createQSA.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createQSA statment success.")
                } else {
                    print("createQSA statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createACTIVITY.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createACTIVITY statment success.")
                } else {
                    print("createACTIVITY statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createADRESS.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createADRESS statment success.")
                } else {
                    print("createADRESS statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createPERSON.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createPERSON statment success.")
                } else {
                    print("createPERSON statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createRH.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createRH statment success.")
                } else {
                    print("createRH statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createCLOCK.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createCLOCK statment success.")
                } else {
                    print("createCLOCK statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createCOMPANY.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createCOMPANY statment success.")
                } else {
                    print("createCOMPANY statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createCLIENT.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createCLIENT statment success.")
                } else {
                    print("createCLIENT statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createSCHEDULE.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createSCHEDULE statment success.")
                } else {
                    print("createSCHEDULE statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createSCHEDULE_SERVICE.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createSCHEDULE_SERVICE statment success.")
                } else {
                    print("createSCHEDULE_SERVICE statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createUSERS.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createUSERS statment success.")
                } else {
                    print("createUSERS statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createACCOUNTING.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createACCOUNTING statment success.")
                } else {
                    print("createACCOUNTING statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createCOMPANY_ACTIVITIES.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createCOMPANY_ACTIVITIES statment success.")
                } else {
                    print("createCOMPANY_ACTIVITIES statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.createCOMPANY_QSA.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("createCOMPANY_QSA statment success.")
                } else {
                    print("createCOMPANY_QSA statment failure.")
                    return
                }
        }
        
        if sqlite3_prepare_v2(db, SQLDataBase.insertAdress0.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("insertPerson0 statment success.")
                } else {
                    print("insertPerson0 statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.insertCompany0.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("insertCompany0 statment success.")
                } else {
                    print("insertCompany0 statment failure.")
                    return
                }
        }
        if sqlite3_prepare_v2(db, SQLDataBase.insertPerson0.rawValue, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE{
                    print("insertPerson0 statment success.")
                } else {
                    print("insertPerson0 statment failure.")
                    return
                }
        }
        for query in FAQInsert.insertFAQ(){
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE{
                        print("insertFAQ statment success.")
                    } else {
                        print("insertFAQ statment failure.")
                        return
                    }
            }
        }
        sqlite3_finalize(statement)
    }
    
    private func createDatabaseIfNeeded() {
        guard let path = databasePath else {
            print("Failed to get database path")
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            
            if sqlite3_open(path, &db) == SQLITE_OK {
                runCreates()
                print("Successfully created connection to database at \(path)")
                //sqlite3_close(db)
            } else {
                print("Failed to create and open the database at \(path)")
            }
        }
        else{
            if sqlite3_open(path, &db) == SQLITE_OK {
                print("Successfully opened connection to database at \(path)")
                //sqlite3_close(db)
            }
        }
    }

    func getLastId(table: String, db: OpaquePointer?) -> Int{//Generico apenas para verificar o padrão ///NAO UTILIZAR
        
        let query = "SELECT max(id) FROM " + table
        var statement: OpaquePointer?
        var result: Int = 0
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                 result = Int(sqlite3_column_int(statement, 0))
            }
        }
        sqlite3_finalize(statement) // Release the statement when done
        
        return result + 1
    }
    
    func getCompanyId(cnpj: String, db: OpaquePointer?) -> Int{//Generico apenas para verificar o padrão ///NAO UTILIZAR
        
        let query = "SELECT id FROM company WHERE cnpj = " + cnpj
        var statement: OpaquePointer?
        var result: Int = 0
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                 result = Int(sqlite3_column_int(statement, 0))
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
        else{
            print("Successfully close database")
        }
    }
}
