//
//  ScheduleUIState.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import Foundation

enum ScheduleUIState: Equatable{
    case none([Schedule])
    case goToCreateSchedule
    case loading
    case error(String)
}
