//
//  SignUpView.swift
//  aMEI
//
//  Created by coltec on 13/06/23.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
            switch viewModel.uiState{
            case .none:
                if(viewModel.action == 5){
                    ErrorView().loadingView(error: "CNPJ encontrado não é MEI, favor procure um sistema mais adequado!")
                }
                cadastro
            case .loading:
                Text("Loading")
            case .success:
                Text("OK")
            case .error(let error):
                ErrorView().loadingView(error: error)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
    }
}


extension SignUpView{
    var cadastro: some View{
    //func buildSignUpPage() -> some View{
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack(alignment: .center, spacing: 8){
                    
                    HStack{//logo
                        
                    }.padding(10)
                    VStack{//login
                        Text("Informe um CNPJ valido")
                            .disabled(!viewModel.cnpjValido)
                        EditTextView( placeholder: "CNPJ",
                                      text: $viewModel.cnpj,
                                      error: "CNPJ invalido",
                                      failure: viewModel.cnpj.count != 14,
                                      keyboard: .numberPad)
                    }.padding(10)
                    if(!viewModel.cnpjValido){
                        HStack{
                            NavigationLink(destination: EmptyView(), tag: 1, selection: $viewModel.action, label: {EmptyView()})
                            Button("Procurar CNPJ"){
                                viewModel.buscaCNPJ()
                            }
                        }.padding(10)
                    }
                    if(viewModel.cnpjValido){
                        HStack{//senha
                            EditTextView(placeholder: "Digite sua senha",
                                         text: $viewModel.senha,
                                         error: "Senha deve possuir ao menos 8 caracteres",
                                         failure: viewModel.cnpj.count < 8,
                                         keyboard: .alphabet,
                                         isSecure: true)
                        }.padding(10)
                        HStack{//botão
                            
                            NavigationLink(destination: EmptyView(), tag: 1, selection: $viewModel.action, label: {EmptyView()})
                            Button("Criar sua conta"){
                                viewModel.createAccount()
                            }
                        }.padding(10)
                    }
                }.padding(40)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 32)
                .background(Color.white)
                .navigationBarTitle("Login", displayMode: .inline)
                .navigationBarHidden(false)
                .navigationBarItems(leading: Button(action: {
                    viewModel.publisher.send(true)
                }, label: {
                    Text("Voltar")
                }))
        }
        
    }
}

