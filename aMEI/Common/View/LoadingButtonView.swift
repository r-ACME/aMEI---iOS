//
//  LoadingButtonView.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import SwiftUI

struct LoadingButtonView: View {
    var action: () -> Void
    var text: String
    var disabled: Bool = false
    var showProgress: Bool = false
    
    var body: some View {
        ZStack{
            Button{
                action()
            }label:{
                Text(showProgress ? " " : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disabled ? Color("lightBlue"): Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(4.0)
            }.disabled(disabled || showProgress)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
        }
    }
}
