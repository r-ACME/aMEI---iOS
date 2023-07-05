//
//  CreateSchedule.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import SwiftUI

struct CreateScheduleView: View {
    
    @ObservedObject var viewModel: CreateScheduleViewModel
    @Environment(\.dismiss) var dismiss
    private let options = ["Semanal", "Mensal"]
    
    var body: some View {
        NavigationView{
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
                    Text("Repetir ")
                    Picker("Repetir ", selection: $viewModel.repeatType) {
                        ForEach(AlertFrequency.allCases, id: \.self){
                            value in
                            Text(value.rawValue).tag(value)
                        }
                    }
                    Toggle("", isOn: $viewModel.repeatSchedule)
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
                    Text(" antes").opacity( viewModel.alert == AlertSchedule.none ? 0.0 : 100.0)
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
                //                HStack{
                //                    LoadingButtonView(action: { viewModel.saveSchedule() },
                //                                      text: (viewModel.isNew ? "Salvar" : "Editar"))
                //
                //                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Agendamento", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                viewModel.saveSchedule()
            }, label: {
                Text(viewModel.isNew ? "Salvar" : "Editar")
            }))
            .navigationBarItems(leading: Button(action: {
                viewModel.publisher.send(true)
            }, label: {
                Text("Voltar")
            }))
            .padding(.bottom, 20)
        }
    }
}
    

struct CreateScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        CreateScheduleView(viewModel: CreateScheduleViewModel(interactor: CreateScheduleInteractor()))
    }
}

