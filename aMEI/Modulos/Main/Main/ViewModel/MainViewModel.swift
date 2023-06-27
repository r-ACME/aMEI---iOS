//
//  MainViewModel.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import SwiftUI
import Combine

class MainViewModel: ObservableObject{
    
    @Published var uiState: MainUIState = .loading
    
    
    
    func createAbout() -> some View{
        return MainViewRouter.makeAboutView()
    }
    
    func createSchedule() -> some View{
        return MainViewRouter.makeScheduleView()
    }
    
    func createClient() -> some View{
        return MainViewRouter.makeClientView()
    }
    
    func createProduct() -> some View{
        return MainViewRouter.makeProductsView()
    }
    
    func createPremium() -> some View{
        return MainViewRouter.makePremiumView()
    }
    
    func createContactUs() -> some View{
        return MainViewRouter.makeContactUsView()
    }
    
    func logout() -> some View{
        //desvincular usuário logado
        return MainViewRouter.makeLoginView()
    }
}
