//
//  ClientViewRouter.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation
import SwiftUI
import Combine


enum ClientViewRouter{

    static func makeCreateClientView(publisher: PassthroughSubject<Bool, Never>) -> some View{
        let viewModel = CreateClientViewModel(interactor: CreateClientInteractor())
        viewModel.publisher = publisher
        return CreateClientView(viewModel: viewModel)
    }
    
    static func makeCreateClientView(client: Client, publisher: PassthroughSubject<Bool, Never>) -> some View{
        let viewModel = CreateClientViewModel(client: client, interactor: CreateClientInteractor())
        viewModel.publisher = publisher
        return CreateClientView(viewModel: viewModel)
    }
}
