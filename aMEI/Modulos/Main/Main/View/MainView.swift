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
    @State private var selection: Int = 0
    
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
                    }.tag(1)
                
                viewModel.createProduct()
                    .tabItem{
                        Image(systemName: "list.clipboard.fill").imageScale(.small)
                        Text("Produtos")
                    }.tag(2)
                
                viewModel.createPremium()
                    .tabItem{
                        Image(systemName: "brazilianrealsign.circle.fill").imageScale(.small)
                        Text("Contabilidade")
                    }.tag(3)

                viewModel.createPremium()
                    .tabItem{
                        Image(systemName: "list.bullet.circle.fill").imageScale(.small)
                        Text("RH")
                    }.tag(4)
                
                viewModel.createPremium()
                    .tabItem{
                        Image(systemName: "pin.square.fill").imageScale(.small)
                        Text("Registro")
                    }.tag(5)
                
                viewModel.createFAQ()
                    .tabItem{
                        Image(systemName: "questionmark.circle.fill").imageScale(.small)
                        Text("FAQ")
                    }.tag(6)
                
                viewModel.createContactUs()
                    .tabItem{
                        Image(systemName: "mail.fill").imageScale(.small)
                        Text("Fale conosco")
                    }.tag(7)
                
                viewModel.createAbout()
                    .tabItem{
                        Image(systemName: "exclamationmark.circle").imageScale(.small)
                        Text("Sobre")
                    }.tag(8)
                
                chose
                    .tabItem{
                        Button(action: {viewModel.logout()}, label: {Image(systemName: "rectangle.portrait.and.arrow.forward.fill").imageScale(.small)
                            Text("Logout")})
                    }.tag(9)
                    
            }
            .background(Color.white)
            .accentColor(Color.cyan)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(interactor: MainInteractor()))
    }
}


extension MainView{
    
    var chose: some View{
        
        ZStack{
            Text("")
                .alert(isPresented: .constant(true)){
                    Alert(title: Text("aMEI"),
                          message: Text("Deseja sair?"),
                          primaryButton: .default(Text("Sim")){viewModel.logout()},
                          secondaryButton: .default(Text("Não")){})
                }
        }
    }
}
