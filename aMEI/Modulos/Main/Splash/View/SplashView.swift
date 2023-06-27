//
//  SplashView.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group{
            switch viewModel.uiState{
            case .loading:
                chose
            case .goToLogin:
                viewModel.loginView()
            case .goToMain:
                viewModel.mainView()
            case .error(let error):
                ErrorView().loadingView(error: error)
            }
        }.onAppear(perform: {viewModel.onAppear()})
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
    }
}


extension SplashView{
    
    var chose: some View{
        
        ZStack{
            Text("")
                .alert(isPresented: .constant(true)){
                    Alert(title: Text("aMEI"),
                          message: Text("Deseja continuar a sessão?"),
                          primaryButton: .default(Text("Sim")){viewModel.uiState = .goToMain},
                          secondaryButton: .default(Text("Não")){viewModel.uiState = .goToLogin})
                }
        }
    }
}
