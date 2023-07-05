//
//  ClientUIState.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation

enum ClientUIState: Equatable{
    case none([ClientRawData])
    case loading
    case searching
    case goToCreateClient
    case error(String)
}
