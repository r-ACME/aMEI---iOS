//
//  MainViewRouter.swift
//  aMEI
//
//  Created by coltec on 14/06/23.
//

import Foundation
import SwiftUI


enum MainViewRouter{
    
    static func makeAboutView() -> some View{
        return AboutView()
    }
    
    static func makeScheduleView() -> some View{
        let viewModel = ScheduleViewModel(interactor: ScheduleInteractor())
        return ScheduleView(viewModel: viewModel)
    }
    
    static func makeClientView() -> some View{
        let viewModel = ClientViewModel(interactor: ClientInteractor())
        return ClientView(viewModel: viewModel)
    }
    
    static func makeProductsView() -> some View{
//        let viewModel = ClientViewModel()
        return ProductsView()
    }
    
    static func makePremiumView() -> some View{
//        let viewModel = ClientViewModel()
        return PremiumView()
    }
    
    static func makeLoginView() -> some View{
        let viewModel = LoginViewModel(interactor: LoginInteractor())
        return LoginView(viewModel: viewModel)
    }
    
    static func makeContactUsView() -> some View{
        let viewModel = ContactUsViewModel()
        return ContactUsView(viewModel: viewModel)
    }
    
    static func makeFAQView() -> some View{
        let viewModel = FAQViewModel(interactor: FAQInteractor())
        return FAQView(viewModel: viewModel)
    }

}
