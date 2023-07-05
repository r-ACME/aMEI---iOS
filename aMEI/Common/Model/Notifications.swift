//
//  Notifications.swift
//  aMEI
//
//  Created by coltec on 20/06/23.
//

import Foundation
import SwiftUI
import Combine
import UserNotifications

class Notification{
    
    static func scheduleNotification(title: String, message: String, scheduleAt: DateComponents, id: Int, repeats: Bool) {
            // Criar o conteúdo da notificação
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = message
            content.sound = UNNotificationSound.default

            // Criar a data para a notificação
            var dateComponents = scheduleAt

            // Criar o gatilho da notificação com base na data
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)

            // Criar o pedido de notificação
            let request = UNNotificationRequest(identifier: "Schedule_id: \(id)", content: content, trigger: trigger)

            // Agendar a notificação
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Erro ao agendar a notificação: \(error.localizedDescription)")
                } else {
                    print("Notificação agendada com sucesso.")
                }
            }
        }
    
    static func scheduleVerification(notificationId: String, completionHandler: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                if request.identifier == notificationId {
                    completionHandler(true)
                    return
                }
            }
            completionHandler(false)
        }
    }
    
    static func scheduleRemoval(notificationId: String){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
    }
}
