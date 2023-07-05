//
//  FAQView.swift
//  aMEI
//
//  Created by coltec on 22/06/23.
//

import SwiftUI

struct FAQView: View {
    
    @State var action: Int? = 0
    @ObservedObject var viewModel: FAQViewModel
    @State private var selection: Int = 0
    
    
    var body: some View {
        VStack{
            Text("Perguntas frequentes").bold()
            switch viewModel.uiState{
            case .none:
                if case FAQUIState.none(let rows) = viewModel.uiState{
                    LazyVStack{
                        ForEach(rows, id: \.id) { row in
                            VStack{
                                Spacer()
                                viewModel.faqQuestion(current: row)
                            }.onTapGesture {
                                viewModel.faqToShow = row.id
                            }
                            .sheet(isPresented: Binding<Bool>(get: { viewModel.faqToShow == row.id }, set: { _ in viewModel.faqToShow = 0})) {
                                viewModel.faq(current: row)
                            }
                        }
                    }
                }
            case .loading:
                Text("Loading")
            case .error(let error):
                ErrorView().loadingView(error: error)
            }
        }.onAppear(perform: {viewModel.fetchFAQs()})
            .padding(50)
        Spacer()
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView(viewModel: FAQViewModel(interactor: FAQInteractor()))
    }
}
