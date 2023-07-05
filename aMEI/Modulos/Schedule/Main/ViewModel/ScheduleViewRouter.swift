//
//  ScheduleViewRouter.swift
//  aMEI
//
//  Created by coltec on 19/06/23.
//

import Foundation
import SwiftUI
import Combine


enum ScheduleViewRouter{
    
    static func makeCreateScheduleView(publisher: PassthroughSubject<Bool, Never>, date: Date) -> some View{
        let viewModel = CreateScheduleViewModel(interactor: CreateScheduleInteractor())
        viewModel.publisher = publisher
        viewModel.date = date
        return CreateScheduleView(viewModel: viewModel)
    }
    
    static func makeCreateScheduleView(schedule: Schedule, publisher: PassthroughSubject<Bool, Never>) -> some View{
        let viewModel = CreateScheduleViewModel(schedule: schedule, interactor: CreateScheduleInteractor())
        viewModel.publisher = publisher
        return CreateScheduleView(viewModel: viewModel)
    }
}
