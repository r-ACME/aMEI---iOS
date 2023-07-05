//
//  ClientView.swift
//  aMEI
//
//  Created by coltec on 14/06/23.
//

import SwiftUI

struct ClientView: View {
    @State var action: Int? = 0
    @ObservedObject var viewModel: ClientViewModel
    @State private var selection: Int = 0
    
    @State var tudo: String = ""
    @State var all: Bool = false
    var body: some View {
        VStack{
            switch viewModel.uiState{
            case .none:
                Form{
                    mainClientBase
                    Section(header: Text("Clientes")) {
                        if case ClientUIState.none(let rows) = viewModel.uiState{
                            if rows.count == 0{
                                VStack{
                                    Text("Você não possui clientes")
                                }
                            }
                            else{
                                LazyVStack{
                                    ForEach(rows, id: \.id) { row in
                                        VStack{
                                            Spacer()
                                            viewModel.showClientList(row: row)
                                            if row != rows.last{
                                                Divider()
                                            }
                                        }.onTapGesture {
                                            viewModel.clientToShow = row.id
                                        }
                                        .sheet(isPresented: Binding<Bool>(get: { viewModel.clientToShow == row.id }, set: { _ in viewModel.clientToShow = 0})) {
                                            viewModel.showDetails(current: row)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    showAddClient
                }.onAppear(perform: {viewModel.loading()})
            case .loading:
                Form{
                    mainClientBase
                    Text("Loading")
                }
            case .searching:
                Form{
                    mainClientBase
                    Text("Searching")
                }
            case .goToCreateClient:
                viewModel.createClient()
            case .error(let error):
                ErrorView().loadingView(error: error)
            }
        }
    }
}


struct ClientView_Previews: PreviewProvider {
    static var previews: some View {
        ClientView(viewModel: ClientViewModel(interactor: ClientInteractor()))
    }
}


extension ClientView{

    var mainClientBase: some View{
        VStack {
            Section(header: Text("")) {
                HStack{
                    Button {
                        //viewModel.goToCreateClient()
                    } label: {
                        HStack{
                            Text("Nome da Empresa")
                            Spacer()
                        }
                    }
                }
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
                }
            }
        }
    }
    
    var showAddClient: some View{
        Section(header: Text("")) {
            HStack{
                Button {
                    viewModel.goToCreateClient()
                } label: {
                    HStack{
                        Text("Novo Cliente")
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

