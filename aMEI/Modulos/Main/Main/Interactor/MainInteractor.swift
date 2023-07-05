//
//  MainInteractor.swift
//  aMEI
//
//  Created by coltec on 21/06/23.
//

import Foundation
import Combine

class MainInteractor{

    private let local: LocalDataSource = .shared

    
    func logout(){
        local.removeUserAuth()
    }
    
    
}
