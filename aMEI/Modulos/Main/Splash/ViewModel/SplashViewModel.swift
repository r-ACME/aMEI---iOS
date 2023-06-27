//
//  SplashViewModel.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import SwiftUI
import Combine
import UserNotifications

class SplashViewModel: ObservableObject{
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellable: AnyCancellable?
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor){
        self.interactor = interactor
    }
    deinit{
        cancellable?.cancel()
    }
    
    func loginView() -> some View{
        return SplashViewRouter.makeLoginView()
    }
    
    func mainView() -> some View{
        return SplashViewRouter.makeMainView()
    }
    
    func onAppear(){
        
        Notification.scheduleVerification(notificationId: "Schedule_id: 0") { exists in
            if exists {
                print("A notificação já está agendada.")
            } else {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        
                        var dateComponents = DateComponents()
                        dateComponents.day = 20
                        dateComponents.hour = 12
                        
                        Notification.scheduleNotification(title: "Pagamento de DAS", message: "Não se esqueça de confirmar se o pagamento da DAS já foi feito", scheduleAt: dateComponents, id: 0, repeats: true)
                    }
                }
            }
        }
    }
}


//34241472000158
