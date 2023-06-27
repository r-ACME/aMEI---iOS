//
//  LoginViewRouter.swift
//  aMEI
//
//  Created by coltec on 13/06/23.
//

import Foundation
import SwiftUI
import Combine


enum LoginViewRouter{
    
    static func makeMainView() -> some View{
        let viewModel = MainViewModel()
        return MainView(viewModel: viewModel)
    }
    
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View{
        let viewModel = SignUpViewModel(interactor: SignUpInteractor())
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
    }
}
