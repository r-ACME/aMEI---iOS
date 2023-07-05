//
//  ProductsUIState.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import Foundation

enum ProductsUIState: Equatable{
    case none
    case loading
    case searching
    case error(String)
}
