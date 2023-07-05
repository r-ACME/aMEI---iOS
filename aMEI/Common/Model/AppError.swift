//
//  AppError.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation

enum AppError: Error, Decodable{
    case response(message: CNPJErrorResponse)
    
    public var message: CNPJErrorResponse{
        switch self{
        case .response(let message):
            return message
        }
    }
}
