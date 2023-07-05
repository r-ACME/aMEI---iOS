//
//  ContactUsViewModel.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import Foundation
import SwiftUI
import Combine

class ContactUsViewModel: ObservableObject{
    
    @Published var uiState: ContactUsUIState = .none
    
    @Published var subject = ""
    @Published var body = ""
    
    private var email = Email()
    
    func sendEmail(){
        email.sendEmail(subject: subject, body: body)
    }
}
