//
//  CreateScheduleUIState.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import Foundation

enum CreateScheduleUIState: Equatable{
    case none
    case loading
    case success
    case error(String)
}
