//
//  ScheduleView.swift
//  aMEI
//
//  Created by coltec on 14/06/23.
//

import SwiftUI
import UIKit

struct ScheduleView: View {
    @State var action: Int? = 0
    @ObservedObject var viewModel: ScheduleViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                switch viewModel.uiState{
                case .none:
                    main
                    Spacer()
                    Form{
                        Section(header: Text("Agendamentos do Dia")) {
                            if case ScheduleUIState.none(let rows) = viewModel.uiState{
                                if rows.count == 0{
                                    VStack{
                                        Text("Você não possui agendamentos para o dia")
                                    }
                                }
                                else{
                                    LazyVStack{
                                        ForEach(rows, id: \.id) { row in
                                            VStack{
                                                Spacer()
                                                viewModel.schedules(row: row)
                                                if row != rows.last{
                                                    Divider()
                                                }
                                            }.onTapGesture {
                                                viewModel.scheduleToShow = row.id
                                            }
                                            .sheet(isPresented: Binding<Bool>(get: { viewModel.scheduleToShow == row.id }, set: { _ in viewModel.scheduleToShow = 0})) {
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        addSchedules
                    }
                case .loading:
                    Text("Loading")
                case .goToCreateSchedule:
                    VStack{
                        viewModel.createSchedule()
                    }
                case .error(let error):
                    ErrorView().loadingView(error: error)
                }
            }
            .navigationBarTitle("Agendamento", displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear(perform: {
                viewModel.fetchSchedule()
            })
        }.padding(10)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(viewModel: ScheduleViewModel(interactor: ScheduleInteractor()))
    }
}

extension ScheduleView{
    
    var main: some View{
        VStack{
            VStack{
                DatePicker(selection: $viewModel.date, displayedComponents: [.date], label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    .datePickerStyle(.graphical)
            }.onChange(of: viewModel.date) { _ in
                viewModel.fetchSchedule()
            }
        }
    }
    
    var addSchedules: some View{
        HStack{
            Button {
                viewModel.goToCreateSchedule()
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
