//
//  Alert.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import Foundation

enum AlertSchedule: String, CaseIterable, Identifiable{
    case none = "nunca"
    case onehour = "uma hora"
    case twelve = "doze horas"
    case oneday = "um dia"
    case twodays = "dois dias"
    case oneweek = "uma semana"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index{
        return Self.allCases.firstIndex{ self == $0} ?? 0
    }
}

enum AlertFrequency: String, CaseIterable, Identifiable{
    case weekly = "Semanal"
    case monthly = "Mensal"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index{
        return Self.allCases.firstIndex{ self == $0} ?? 0
    }
}
