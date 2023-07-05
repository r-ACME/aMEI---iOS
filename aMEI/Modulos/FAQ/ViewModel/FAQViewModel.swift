//
//  FAQViewModel.swift
//  aMEI
//
//  Created by coltec on 22/06/23.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class FAQViewModel: ObservableObject{
    
    @Published var uiState: FAQUIState = .loading
    @Published var faqToShow: Int? = 0
    private var cancellable: AnyCancellable?
    private let interactor: FAQInteractor
    var faqs: [FAQ] = []
    
    init(interactor: FAQInteractor){
        self.interactor = interactor
        
    }
    
    
    deinit{
        cancellable?.cancel()
    }
    
    
    func fetchFAQs(){
        self.faqs = self.interactor.getFAQs()
        self.uiState = .none(self.faqs)
    }
    
    func faqQuestion(current: FAQ) -> some View{

        HStack{
            Text("\(current.question)")
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.black)
            }
        }
    }
    
    func faq(current: FAQ) -> some View{
        Form{
            Section(header: Text(current.question)) {
                HStack{
                    Text(current.answer)
                }
            }
        }
    }
}
