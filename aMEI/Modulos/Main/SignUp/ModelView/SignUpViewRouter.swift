//
//  SignUpViewRouter.swift
//  aMEI
//
//  Created by coltec on 13/06/23.
//

import Foundation
import SwiftUI


enum SignUpViewRouter{
    
    static func makeMainView() -> some View{
        let viewModel = MainViewModel()
        return MainView(viewModel: viewModel)
    }
}
