//
//  SplashViewRouter.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import SwiftUI


enum SplashViewRouter{
    
    static func makeLoginView() -> some View{
        let viewModel = LoginViewModel(interactor: LoginInteractor())
        return LoginView(viewModel: viewModel)
    }
    
    static func makeMainView() -> some View{
        let viewModel = MainViewModel()
        return MainView(viewModel: viewModel)
    }
}
