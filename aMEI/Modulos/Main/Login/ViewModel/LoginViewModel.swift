//
//  LoginViewModel.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject{
    
    @Published var uiState: LoginUIState = .none
    
    @Published var cnpj = ""
    @Published var senha = ""
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: LoginInteractor
    
    
    init(interactor: LoginInteractor){
        self.interactor = interactor
        cancellable = publisher.sink{ value in
            if(value){
                self.uiState = .goToMain
            }
            else{
                self.uiState = .none
            }
        }
    }
    
    func login(){
        self.uiState = .loading  //para barra de progresso e carregamento
        
        cancellableRequest = interactor.login(request: UserAuth(cnpj: self.cnpj, password: self.senha))
            .receive(on: DispatchQueue.main)
            .sink{ completion in
                
                switch(completion){
                case .failure(let appError):
                    self.uiState = LoginUIState.error(appError.message.titulo + "\n" + appError.message.detalhes)
                    break
                case .finished:
                    break
                }
            } receiveValue: { success in
                self.interactor.insertAuth(user: UserAuth(cnpj: self.cnpj, password: self.senha))
                self.uiState = .goToMain
            }
    }
    
    
    func goToMain() -> some View{
        return  LoginViewRouter.makeMainView()
    }
    
    func signUpView(){
        self.uiState = .goToSignUp
    }
    
    func goToSignUp() -> some View{
        return LoginViewRouter.makeSignUpView(publisher: publisher)
    }
    
}
