//
//  File.swift
//  aMEI
//
//  Created by coltec on 22/06/23.
//

import Foundation

enum FAQUIState{
    case none([FAQ])
    case loading
    case error(String)
}
