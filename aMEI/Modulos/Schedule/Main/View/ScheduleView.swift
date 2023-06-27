//
//  ScheduleView.swift
//  aMEI
//
//  Created by coltec on 14/06/23.
//

import SwiftUI
import UIKit

struct ScheduleView: View {
    
    @ObservedObject var viewModel: ScheduleViewModel
    
    var body: some View {
        VStack{
            VStack{
                DatePicker(selection: $viewModel.date, displayedComponents: [.date], label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    .datePickerStyle(.graphical)
            }
            Form {
                Section(header: Text("Agendamentos do Dia")) {
                    HStack{
                        HStack{
                            Text("18:30 - Aula no coltec")
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
                        Button {
                            
                        } label: {
                            HStack{
                                Text("Novo Agendamento")
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
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(viewModel: ScheduleViewModel())
    }
}
