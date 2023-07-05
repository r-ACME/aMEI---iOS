//
//  ContactUsUIState.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation

enum ContactUsUIState: Equatable{
    case none
    case loading
    case send
    case error(String)
}
