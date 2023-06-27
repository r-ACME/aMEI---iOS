//
//  Alert.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import Foundation

enum Alert: String, CaseIterable, Identifiable{
    case onehour = "Uma hora"
    case twelve = "Doze horas"
    case oneday = "Um dia"
    case twodays = "Dois dias"
    case oneweek = "Uma semana"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index{
        return Self.allCases.firstIndex{ self == $0} ?? 0
    }
}
