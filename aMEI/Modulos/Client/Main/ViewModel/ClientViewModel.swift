//
//  ClientViewModel.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation
import SwiftUI
import Combine

class ClientViewModel: ObservableObject{
    
    @Published var uiState: ClientUIState = .none([])
    
    private let publisher = PassthroughSubject<Bool, Never>()
    private var cancellable: AnyCancellable?
    private let interactor: ClientInteractor
    
    @Published var search = ""
    @Published var body = ""
    @Published var clientToShow = 0
    
    private var email = Email()
    
    init(interactor: ClientInteractor){
        self.interactor = interactor
        cancellable = publisher.sink{ value in
            if(value){
                self.uiState = .none([])
            }
            else{
                self.uiState = ClientUIState.error("Cliente já cadastrado")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.uiState = .none([])
                }
            }
        }
    }
    
    func loading(){
        self.uiState = .loading
        self.uiState = .none(interactor.fetchClients())
    }
    
    func searchClient(){
        self.uiState = .searching
        
        //Pesquisar clientes
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.uiState = .none([])
        }
    }
    
    func goToCreateClient(){
        self.uiState = .goToCreateClient
    }
    
    func createClient() -> some View{
        return ClientViewRouter.makeCreateClientView(publisher: publisher)
    }
    
    func fixNameSize(name: String) -> String {
        let words = name.components(separatedBy: " ")
        
        var finalName: String = ""
        
        if words.count >= 2 {
            let endIndex = name.index(name.startIndex, offsetBy: name.range(of: words[1])!.upperBound.utf16Offset(in: name))
            finalName = String(name.prefix(upTo: endIndex)) + "..."
        } else {
            finalName = name
        }
        
        return finalName
    }
    
    func showDetails(current: ClientRawData) -> some View{
        
        VStack{
            if current.companyId == 0{
                showDetailsPerson(current: current)
            }
            else{
                showDetailsCompany(current: current)
            }
        }.padding(40)
    }
    
    func showDetailsPerson(current: ClientRawData) -> some View{
        
        Form{
            let person: Person = self.interactor.fetchPerson(id: current.personId)
            Section(header: Text("Cliente")) {
                HStack{
                    Text("Nome: \(person.name)")
                }
                Toggle("Ativo", isOn: Binding<Bool>(get: { self.clientToShow == current.id }, set: { _ in }))
                HStack{
                    Text("Telefone: \(person.phone)")
                }
                HStack{
                    Text("Email: \(person.email)")
                }
            }
            Section(header: Text("Endereço")) {
                showDetailAdress(id: person.adressId)
            }
        }
    }
    func showDetailsCompany(current: ClientRawData) -> some View{
        
        Form{
            let company: Company = self.interactor.fetchCompany(id: current.companyId)
            Section(header: Text("Cliente")) {
                HStack{
                    Text("Empresa: \(company.name)")
                }
                Toggle("Ativo", isOn: Binding<Bool>(get: { self.clientToShow == current.id }, set: { _ in }))
                HStack{
                    Text("CNPJ: \(company.document)")
                }
                HStack{
                    Text("Telefone: \(company.phone)")
                }
                HStack{
                    Text("Email: \(company.email)")
                }
            }
            Section(header: Text("Endereço")) {
                showDetailAdress(id: company.adressId)
            }
        }
    }
    
    func showDetailAdress(id: Int) -> some View{
        
        VStack{
            
            let adress = self.interactor.fetchAdress(id: id)
            HStack{
                if adress.complement.count == 0{
                    Text("Rua: \(adress.street), \(adress.number)")
                }
                else{
                    Text("Rua: \(adress.street) \n\(adress.number) - \(adress.complement)")
                }
            }
            HStack{
                Text("Bairro: \(adress.neighborhood)")
            }
            HStack{
                Text("Cidade: \(adress.city) / \(adress.state)")
            }
            
        }
    }
    
    func showClientList(row: ClientRawData) -> some View{
        
        HStack{
            Image(systemName: row.companyId == 0 ? "person.fill" : "building.2.fill")
                .imageScale(.large)
                .foregroundColor(.black)
            Text(self.fixNameSize(name: row.name))
            Spacer()
            
            Image(systemName: "pencil.circle.fill")
                .imageScale(.large)
                .foregroundColor(.black)
            
        }
    }
}
