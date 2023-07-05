//
//  ScheduleViewModel.swift
//  aMEI
//
//  Created by coltec on 14/06/23.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class ScheduleViewModel: ObservableObject{
    
    @Published var uiState: ScheduleUIState = .loading
    
    private let publisher = PassthroughSubject<Bool, Never>()
    private var cancellable: AnyCancellable?
    private let interactor: ScheduleInteractor
    
    @Published var date: Date = .now
    @Published var beginHour: Int = 0
    @Published var endHour: Int = 24
    @Published var schedules = [Schedule(id: 0, datetime: "", title: "", description: "", alert: "", clientid: 0)]
    @Published var scheduleToShow = 0
    
    init(interactor: ScheduleInteractor){
        self.interactor = interactor
        cancellable = publisher.sink{ value in
            if(value){
                self.uiState = .loading
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.fetchSchedule()
                })
            }
        }
    }
    
    deinit{
        cancellable?.cancel()
    }
    
    func goToCreateSchedule(){
        self.uiState = .goToCreateSchedule
    }
    
    func createSchedule() -> some View{
        return ScheduleViewRouter.makeCreateScheduleView(publisher: publisher, date: self.date)
    }
    
    func fetchSchedule(){
        self.schedules = self.interactor.getScheduleData(date: self.date)
        self.uiState = .none(self.schedules)
    }
    
    func fetchTime(dateTime: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        let data = formatter.date(from: dateTime)
        var result = ""
        formatter.dateFormat = "HH:mm"
        result = formatter.string(from: data!)
        return result
    }
    
    func schedules(row: Schedule) -> some View{

        HStack{
            Text("\(self.fetchTime(dateTime: row.datetime)) - \(row.title.count == 0 ? "Sem Titulo" : row.title)")
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "pencil.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
        }
    }
}
