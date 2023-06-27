//
//  LoginUIState.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation

enum LoginUIState: Equatable{
    case none
    case loading
    case goToMain
    case goToSignUp
    case error(String)
}
