//
//  ScheduleService.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import Foundation

struct ScheduleService: Codable{
    
    var id: Int
    var scheduleId: Int
    var serviceId: Int?
    var productId: Int?
    var amount_product: String?
    var completion: Int
    var discount: String?
    
}
