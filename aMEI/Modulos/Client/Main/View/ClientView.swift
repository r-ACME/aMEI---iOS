//
//  ClientView.swift
//  aMEI
//
//  Created by coltec on 14/06/23.
//

import SwiftUI

struct ClientView: View {
    @ObservedObject var viewModel: ClientViewModel
    
    @State var tudo: String = ""
    @State var all: Bool = false
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Sua empresa")) {
                    Button("Nome da Empresa"){}
                }
                Section(header: Text("Pesquisa")) {
                    HStack{
                        EditTextView( placeholder: "Informe o cliente",
                                      text: $viewModel.search,
                                      keyboard: .default)
                        Button {
//                            searchClient()
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                switch viewModel.uiState{
                case .none:
//                    clients
                    showClientList
                case .loading:
                    Text("Loading")
                case .searching:
                    Text("Searching")
                case .error(let error):
                    ErrorView().loadingView(error: error)
                }
            }
        }
    }
}

struct ClientView_Previews: PreviewProvider {
    static var previews: some View {
        ClientView(viewModel: ClientViewModel())
    }
}


extension ClientView{

    var showClientList: some View{
        Section(header: Text("Clientes")) {
            HStack{
                HStack{
                    Text("Cliente 1")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Cliente 2")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Cliente 3")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

