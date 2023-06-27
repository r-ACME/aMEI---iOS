//
//  MainView.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State var action: Int? = 0
    @State var selection = 0
    
    var body: some View {
        Group{
            TabView(selection: $selection){

                viewModel.createSchedule()
                    .tabItem{
                        Image(systemName: "calendar.circle.fill").imageScale(.small)
                        Text("Agenda")
                    }.tag(0)
                
                viewModel.createClient()
                    .tabItem{
                        Image(systemName: "person.3.fill").imageScale(.small)
                        Text("Clientes")
                    }.tag(0)
                
                viewModel.createProduct()
                    .tabItem{
                        Image(systemName: "list.clipboard.fill").imageScale(.small)
                        Text("Produtos")
                    }.tag(0)
                
                viewModel.createPremium()
                    .tabItem{
                        Image(systemName: "brazilianrealsign.circle.fill").imageScale(.small)
                        Text("Contabilidade")
                    }.tag(0)

                viewModel.createPremium()
                    .tabItem{
                        Image(systemName: "list.bullet.circle.fill").imageScale(.small)
                        Text("RH")
                    }.tag(0)
                
                viewModel.createPremium()
                    .tabItem{
                        Image(systemName: "pin.square.fill").imageScale(.small)
                        Text("Registro")
                    }.tag(0)
                
                viewModel.createPremium()
                    .tabItem{
                        Image(systemName: "questionmark.circle.fill").imageScale(.small)
                        Text("FAQ")
                    }.tag(0)
                
                viewModel.createContactUs()
                    .tabItem{
                        Image(systemName: "mail.fill").imageScale(.small)
                        Text("Fale conosco")
                    }.tag(0)
                
                viewModel.createAbout()
                    .tabItem{
                        Image(systemName: "exclamationmark.circle").imageScale(.small)
                        Text("Sobre")
                    }.tag(0)
                
                viewModel.logout()
                    .tabItem{
                        Image(systemName: "rectangle.portrait.and.arrow.forward.fill").imageScale(.small)
                        Text("Logout")
                    }.tag(0)
            }
            .background(Color.white)
            .accentColor(Color.cyan)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
