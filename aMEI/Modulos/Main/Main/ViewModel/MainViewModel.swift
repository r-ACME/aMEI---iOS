//
//  MainViewModel.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class MainViewModel: ObservableObject{
    
    @Published var uiState: MainUIState = .loading
    private let interactor: MainInteractor
    
    init(interactor: MainInteractor){
        self.interactor = interactor
    }
    
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
    
    func createFAQ() -> some View{
        return MainViewRouter.makeFAQView()
    }
    
    func logout(){
        self.interactor.logout()
        //self.restartApplication()
    }
    
    func restartApplication() {
        if let window = UIApplication.shared.keyWindow {
                let storyboard = UIStoryboard(name: "Main", bundle: nil) // Substitua "Main" pelo nome correto do storyboard
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") // Substitua "LoginViewController" pelo identificador correto do seu controlador de login
                window.rootViewController = loginViewController
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
    }
}
