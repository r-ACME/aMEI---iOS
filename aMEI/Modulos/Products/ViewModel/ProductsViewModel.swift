//
//  ClientViewModel.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation
import SwiftUI
import Combine

class ProductsViewModel: ObservableObject{
    
    @Published var uiState: ProductsUIState = .loading
    
    @Published var search = ""
    @Published var body = ""
    
    private var email = Email()
    
    init(){
        self.uiState = .loading
        
        //Carregar clientes
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.uiState = .none
        }
    }
    
    
    func searchClient(){
        self.uiState = .searching
        
        //Pesquisar clientes
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.uiState = .none
        }
    }
    
//    func addClient() -> some View{
//        return ClientViewRouter.makeClientAdd()
//    }
}
