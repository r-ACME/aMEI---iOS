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
    
    @Published var uiState: MainUIState = .loading
    
    @Published var date: Date = .now
    @Published var beginHour: Int = 0
    @Published var endHour: Int = 24
    
    
    
}
