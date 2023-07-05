//
//  File.swift
//  aMEI
//
//  Created by coltec on 14/06/23.
//

import Foundation
import SwiftUI

struct ExecuteCode : View {
    init( _ codeToExec: () -> () ) {
        codeToExec()
    }
    
    var body: some View {
        EmptyView()
    }
}
