//
//  SplashUIState.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation


enum SplashUIState: Equatable{
    case loading
    case goToLogin
    case goToMain
    case error(String)
}
