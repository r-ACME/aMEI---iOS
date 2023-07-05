//
//  About.swift
//  aMEI
//
//  Created by coltec on 14/06/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack{
            HStack{//logo
                
            }
            HStack{
                Text("Sistema aMEI  desenvolvido para facilitar o controle e gerenciamento de sua Micro Empresa Individual(MEI).\n\nSistema contempla funcionalidades de controle de agenda, contabilidade e RH e o cadastro de clientes, produtos e serviços.\n\nOferecemos também um suporte para o usuário com perguntas frequentes sobre a legislação de MEIs e um contato caso encontre algum problema com o sistema.\n\nUtilizando aMEI o empreendedor poderá gerenciar sua empresa diretamente do aplicativo de forma simples, facil e pratica sem a necessidade de consultas externas.\n\n\n")
                    .multilineTextAlignment(.center)
            }
            
            HStack{
                Text("Equipe desenvolvedora:")
                    .bold()
            }
            VStack{
                Text("Mariana Gressi")
                Text("Raphael Menezes")
            }
        }.padding(50)
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
