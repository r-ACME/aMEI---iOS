//
//  ContactUsView.swift
//  aMEI
//
//  Created by coltec on 15/06/23.
//

import SwiftUI

struct ContactUsView: View {
    @ObservedObject var viewModel: ContactUsViewModel
    @State var action: Int? = 0
    
    var body: some View {
        VStack{
            VStack{
                Text("Assunto")
                EditTextView( placeholder: "",
                              text: $viewModel.subject,
                              failure: viewModel.subject.count < 3,
                              keyboard: .default,
                              border: .black)
            }
            
            VStack{
                Text("Mensagem")
                TextEditor(text: $viewModel.body)
                    .border(.black)
                    .textFieldStyle(.roundedBorder)
                    .textFieldStyle(CustomTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .lineLimit(10)
                    
            }.padding(.bottom, 20)
            
            VStack{
                NavigationLink(destination: EmptyView(), tag: 1, selection: $action, label: {EmptyView()})
                    Button("Enviar E-mail"){
                        viewModel.sendEmail()
                    }
            }.foregroundColor(.black)
        }.padding(40)
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView(viewModel: ContactUsViewModel())
    }
}
