//
//  CreateScheduleViewModel.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class CreateScheduleViewModel: ObservableObject{
    
    @Published var uiState: CreateScheduleUIState = .none
    
    var publisher: PassthroughSubject<Bool, Never>!
    private var cancellableSaveRequest: AnyCancellable?
    private let interactor: CreateScheduleInteractor
    
    @Published var date: Date = .now
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var alert = AlertSchedule.onehour
    @Published var repeatSchedule = false
    @Published var repeatType = AlertFrequency.weekly
    private var id: Int = 0
    private var old_date: Date = .now
    private var old_title: String = ""
    private var old_description: String = ""
    private var old_alert = AlertSchedule.onehour
    //@Published var client: Int = 0
    //private var old_client: Int = 0
    
    @Published var isNew: Bool = true
    
    
    init(schedule: Schedule, interactor: CreateScheduleInteractor) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        self.id = schedule.id
        self.date = formatter.date(from: schedule.datetime)!
        self.title = schedule.title
        self.description = schedule.description
        self.alert =  AlertSchedule.allCases[Int(schedule.alert)!]
//        self.client = schedule.client!
        self.old_date = formatter.date(from: schedule.datetime)!
        self.old_title = schedule.title
        self.old_description = schedule.description
        self.old_alert =  AlertSchedule.allCases[Int(schedule.alert)!]
//        self.old_client = schedule.client!
        self.isNew = false
        self.interactor = interactor
    }
    
    init(interactor: CreateScheduleInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableSaveRequest?.cancel()
    }
    
    
    func insertSchedule() -> String{
        let scheduleid = interactor.fetchLastId(table: "schedule")
        return "INSERT INTO schedule VALUES(\(scheduleid), '\(self.date)', '\(self.title)', '\(self.description)', '\(self.alert)', NULL )"
    }
    
    func updateSchedule() -> String{
        let query = "UPDATE schedule SET datetime = '\(self.date)', title = '\(self.title)', description = '\(self.description)', alerts = '\(self.alert)' WHERE id = \(self.id)"
        
//        if(self.old_client != self.client){
//            query += "client_id = \(self.client)"
//        }
        
        return query
    }
    
    func saveSchedule(){
        
        var finalQuery = [""].self
        
        if self.isNew{
            finalQuery.append(insertSchedule())
            //finalQuery.append(insertScheduleService())
        }
        else {
            finalQuery.append(updateSchedule())
            //finalQuery.append(updateScheduleService())
        }
        
        self.cancellableSaveRequest = self.interactor.saveSchedule(query: finalQuery)
            .receive(on: DispatchQueue.main)
            .sink{ completion in
                
                switch(completion){
                case .failure(let appError):
                    self.uiState = CreateScheduleUIState.error(appError.message.titulo + "\n" + appError.message.detalhes)
                    break
                case .finished:
                    break
                }
            } receiveValue: { created in
                if created {
                    self.uiState = CreateScheduleUIState.error("Agendamento salvo")
                    self.publisher.send(created)
                    self.uiState = .none
                }
            }
        
    }
    
    func scheduleNotification(){
        Notification.scheduleVerification(notificationId: "Schedule_id: \(self.id)") { exists in
            if exists {
                Notification.scheduleRemoval(notificationId: "Schedule_id: \(self.id)")
            }
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                var dateComponents = DateComponents()
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.date)

                
                if !self.repeatSchedule{
                    dateComponents.year = components.year
                    dateComponents.month = components.month
                    dateComponents.day = components.day
                }
                else if self.repeatType == .weekly{
                    dateComponents.weekday = components.weekday
                }
                else if self.repeatType == .monthly{
                    dateComponents.day = components.day
                }
                dateComponents.hour = components.hour
                dateComponents.minute = components.minute
                
                Notification.scheduleNotification(title: self.title, message: self.description, scheduleAt: dateComponents, id: self.id, repeats: self.repeatSchedule)
            }
        }
    }
}
