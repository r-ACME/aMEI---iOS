//
//  aMEIApp.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import SwiftUI
import UIKit

@main
struct aMEIApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
