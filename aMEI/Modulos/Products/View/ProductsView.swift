//
//  ProductsView.swift
//  aMEI
//
//  Created by coltec on 14/06/23.
//

import SwiftUI

struct ProductsView: View {
    
    @State var tudo: String = ""
    @State var all: Bool = false
    
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Pesquisa")) {
                    HStack{
                        EditTextView( placeholder: "Informe o produto/serviço",
                                      text: $tudo,
                                      keyboard: .default)
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    }
                }
                showProductList
                showServiceList
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}

extension ProductsView{

    var showProductList: some View{
        Section(header: Text("Produtos")) {
            HStack{
                HStack{
                    Text("Produto 1")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Produto 2")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Produto 3")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Produto 4")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Produto 5")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}


extension ProductsView{

    var showServiceList: some View{
        Section(header: Text("Serviços")) {
            HStack{
                HStack{
                    Text("Serviço 1")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Serviço 2")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Serviço 3")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Serviço 4")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
            HStack{
                HStack{
                    Text("Serviço 5")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

