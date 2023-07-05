//
//  Schedule.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import Foundation

struct Schedule: Codable, Equatable{
    
    var id: Int
    var datetime: String
    var title: String
    var description: String
    var alert: String
    var clientid: Int
    
}
