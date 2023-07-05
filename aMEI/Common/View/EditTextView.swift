//
//  EditTextView.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import SwiftUI

struct EditTextView: View{
    
    var placeholder: String = ""
    @Binding var text: String
    
    var error: String? = nil
    var failure: Bool? = nil
    
    var keyboard: UIKeyboardType = .default
    
    var border: Color = .clear
    var isSecure: Bool = false
    
    var body: some View{
        VStack{
            if isSecure{
                SecureField(placeholder, text: $text)
                    .border(border)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocapitalization(.none)
                if let error = error, failure == true, !text.isEmpty{
                    Text(error).foregroundColor(.red)
                }
            }
            else{
                TextField(placeholder, text: $text)
                        .border(border)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(keyboard)
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocapitalization(.none)
                if let error = error, failure == true, !text.isEmpty{
                    Text(error).foregroundColor(.red)
                }
            }
        }
        .padding(.bottom, 10)
    }
}
