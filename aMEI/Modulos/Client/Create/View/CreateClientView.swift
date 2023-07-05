//
//  CreateClientView.swift
//  aMEI
//
//  Created by coltec on 20/06/23.
//

import SwiftUI

struct CreateClientView: View {
    
    @State var action: Int? = 0
    @ObservedObject var viewModel: CreateClientViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                switch viewModel.uiState{
                case .error(let error):
                    ErrorView().loadingView(error: error)
                default:
                    form
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Clientes", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                if (viewModel.documentValido && viewModel.adress.number.count > 1 && viewModel.person.email.isEmail() && viewModel.person.phone.count > 9 && viewModel.person.phone.count < 12 || viewModel.cnpjValido){
                    viewModel.saveClient()
                }
            }, label: {
                Text(viewModel.isNew ? "Salvar" : "Editar")
            }).foregroundColor( (viewModel.documentValido && viewModel.adress.number.count > 1 && viewModel.person.email.isEmail() && viewModel.person.phone.count > 9 && viewModel.person.phone.count < 12 || viewModel.cnpjValido) ? .blue : .black))
            .navigationBarItems(leading: Button(action: {
                viewModel.publisher.send(true)
            }, label: {
                Text("Voltar")
            }))
            .padding(.horizontal, 50)
            .padding(.bottom, 20)
        }
    }
}
    

struct CreateClientView_Previews: PreviewProvider {
    static var previews: some View {
        CreateClientView(viewModel: CreateClientViewModel(interactor: CreateClientInteractor()))
    }
}


extension CreateClientView{
    
    var form: some View{
        VStack{
            HStack{
                Picker("Tipo de Cliente", selection: $viewModel.clientType){
                    ForEach(ClientType.allCases, id: \.self){
                        value in
                        Text(value.rawValue).tag(value)
                    }
                }.onChange(of: viewModel.clientType, perform: {newValue in viewModel.reset()})
                EditTextView( placeholder: "Documento",
                              text: $viewModel.document,
                              error: viewModel.clientType == ClientType.company ? "CNPJ Invalido" : "CPF invalido",
                              failure: viewModel.clientType == ClientType.company ? viewModel.document.count != 14 : viewModel.document.count != 11,
                              keyboard: .default)
                NavigationLink(destination: EmptyView(), tag: 1, selection: $action, label: {EmptyView()})
                Button(action: {
                    if viewModel.document.count == 14{
                        viewModel.validaDocumento()
                        viewModel.buscaDadosCNPJ()
                    }
                    if viewModel.document.count == 11 {
                        viewModel.validaDocumento()
                    }
                }, label:{
                    if(viewModel.documentValido){
                        Image(systemName: "checkmark.circle.fill").imageScale(.large)
                    }
                    else{
                        Image(systemName: "checkmark.circle").imageScale(.large)
                    }
                })
            }
            VStack{
                HStack{
                    EditTextView( placeholder: "Nome",
                                  text: $viewModel.person.name,
                                  error: "Informe seu nome completo",
                                  failure: !(viewModel.person.name.count > 3),
                                  keyboard: .default)
                }
                HStack{
                    EditTextView( placeholder: "Telefone",
                                  text: $viewModel.person.phone,
                                  error: "Informe telefone com DDD",
                                  failure: viewModel.person.phone.count > 11 || viewModel.person.phone.count < 10,
                                  keyboard: .numberPad)
                }
                HStack{
                    EditTextView( placeholder: "Email",
                                  text: $viewModel.person.email,
                                  error: "Informe um email valido",
                                  failure: !viewModel.person.email.isEmail(),
                                  keyboard: .emailAddress)
                }
                HStack{
                    EditTextView( placeholder: "CEP",
                                  text: $viewModel.adress.cep,
                                  error: "CEP Invalido",
                                  failure: viewModel.adress.cep.count != 8,
                                  keyboard: .numberPad)
                }
                if(viewModel.uiState != .cepfound){
                    HStack{
                        HStack{
                            NavigationLink(destination: EmptyView(), tag: 1, selection: $action, label: {EmptyView()})
                            Button("Buscar CEP"){
                                viewModel.buscaCEP()
                            }
                        }.padding(10)
                    }
                }
                if(viewModel.uiState == .cepfound){
                    HStack{
                        EditTextView( placeholder: "Numero",
                                      text: $viewModel.adress.number,
                                      error: "CEP Invalido",
                                      failure: viewModel.adress.number.count < 1,
                                      keyboard: .numberPad)
                        EditTextView( placeholder: "Complemento",
                                      text: $viewModel.adress.complement,
                                      keyboard: .default)
                    }
                }
            }.opacity( (viewModel.documentValido && viewModel.clientType == .person) ? 1 : 0)
            Text("Empresa valida para cadastro!\nClique em salvar")
                .opacity(viewModel.cnpjValido ? 1 : 0)
        }
    }
}
