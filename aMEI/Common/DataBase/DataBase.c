//
//  DataBase.c
//  aMEI
//
//  Created by coltec on 15/06/23.
//

#include "DataBase.h"



func openDatabase() -> OpaquePointer? {
    var db: OpaquePointer?
    guard let part1DbPath = part1DbPath else {
      print("part1DbPath is nil.")
      return nil
    }
    if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
      print("Successfully opened connection to database at \(part1DbPath)")
      return db
    } else {
      print("Unable to open database.")
      PlaygroundPage.current.finishExecution()
    }
  }
