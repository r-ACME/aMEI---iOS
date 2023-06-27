//
//  LoginVIew.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    @State var action: Int? = 0
    
    var body: some View {
        
        Group{
            switch viewModel.uiState{
            case .none:
                loginPage
            case .loading:
                Text("Loading")
            case .goToMain:
                viewModel.goToMain()
            case .goToSignUp:
                viewModel.goToSignUp()
            case .error(let error):
                ErrorView().loadingView(error: error)
            }
        }
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(interactor: LoginInteractor()))
    }
}




extension LoginView{
    var loginPage: some View{
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack(alignment: .center, spacing: 8){
                    
                    HStack{//logo
                        
                    }.padding(.bottom, 200)
                    HStack{//login
                        EditTextView( placeholder: "Informe seu CNPJ",
                                      text: $viewModel.cnpj,
                                      error: "CNPJ possui 14 digitos",
                                      failure: viewModel.cnpj.count != 14,
                                      keyboard: .numberPad)
                    }
                    HStack{//senha
                        EditTextView(placeholder: "Digite sua senha",
                                     text: $viewModel.senha,
                                     error: "Senha deve possuir ao menos 8 caracteres",
                                     failure: viewModel.cnpj.count < 8,
                                     keyboard: .alphabet,
                                     isSecure: true)
                    }
                    HStack{//botão
                        NavigationLink(destination: EmptyView(), tag: 1, selection: $action, label: {EmptyView()})
                        Button("Entrar"){
                            viewModel.login()
                        }
                    }.padding(.bottom, 40)
                    ZStack{
                        Button(action: {
                            viewModel.signUpView()
                            }, label: {
                                Text("Criar uma conta")
                            })
                    }
                }.padding(40)
            }.padding(.top, 120)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 32)
                .background(Color.white)
                .navigationBarTitle("Login", displayMode: .inline)
                .navigationBarHidden(true)
        }
        
    }
}
