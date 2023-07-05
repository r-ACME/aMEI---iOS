//
//  CreateClientUIState.swift
//  aMEI
//
//  Created by coltec on 20/06/23.
//

import Foundation

enum CreateClientUIState: Equatable{
    case none
    case loading
    case cepfound
    case success
    case error(String)
}
