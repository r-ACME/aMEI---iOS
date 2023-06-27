//
//  SignUpUIState.swift
//  aMEI
//
//  Created by coltec on 13/06/23.
//

import Foundation

enum SignUpUIState: Equatable{
    case none
    case loading
    case success
    case error(String)
}
