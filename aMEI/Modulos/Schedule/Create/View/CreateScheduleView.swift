//
//  CreateSchedule.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import SwiftUI

struct CreateScheduleView: View {
    
    @ObservedObject var viewModel: CreateScheduleViewModel
    
    var body: some View {
        VStack{
            HStack{
                DatePicker(selection: $viewModel.date, displayedComponents: [.date, .hourAndMinute], label: { Text("Data") })
            }
            HStack{
                Text("Evento")
                EditTextView( placeholder: "Nomeie seu evento",
                              text: $viewModel.title,
                              error: "Titulo precisa de mais caracteres",
                              failure: viewModel.title.count < 3,
                              keyboard: .default)
            }
            HStack{
                Toggle("Evento Mensal", isOn: $viewModel.repeatSchedule)
            }
            VStack{
                HStack{
                    Text("Descrição")
                    Spacer()
                }
                TextEditor(text: $viewModel.description)
                    .border(.black)
                    .textFieldStyle(.roundedBorder)
                    .textFieldStyle(CustomTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .lineLimit(10)
            }
            HStack{
                Text("Lembrar ")
                Picker("Lembrete", selection: $viewModel.alert){
                    ForEach(AlertSchedule.allCases, id: \.self){
                        value in
                        Text(value.rawValue).tag(value)
                    }
                }
                Text(" antes")
            }
            
//            HStack{
//                Text("Cliente: ")
//                Picker("Lembrete", selection: $viewModel.alert){
//                    ForEach(AlertSchedule.allCases, id: \.self){
//                        value in
//                        Text(value.rawValue).tag(value)
//                    }
//                }
//            }
//            HStack{
//                Text("Serviços e produtos: ")
//            }
            HStack{
                LoadingButtonView(action: { viewModel.saveSchedule() },
                                  text: (viewModel.isNew ? "Salvar" : "Editar"))
                
            }
        }.padding(.horizontal, 50)
    }
}

struct CreateScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        CreateScheduleView(viewModel: CreateScheduleViewModel(interactor: CreateScheduleInteractor()))
    }
}
