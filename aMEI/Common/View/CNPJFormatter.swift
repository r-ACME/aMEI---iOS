//
//  CNPJFormatter.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            let formattedText = formatCNPJ(text)
            textView.text = formattedText
        }
    }
    
    func formatCNPJ(_ cnpj: String) -> String {
        var formattedCNPJ = cnpj.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if formattedCNPJ.count > 14 {
            let endIndex = formattedCNPJ.index(formattedCNPJ.startIndex, offsetBy: 14)
            formattedCNPJ = String(formattedCNPJ[..<endIndex])
        }
        
        if formattedCNPJ.count >= 3 {
            formattedCNPJ.insert(".", at: formattedCNPJ.index(formattedCNPJ.startIndex, offsetBy: 2))
        }
        
        if formattedCNPJ.count >= 7 {
            formattedCNPJ.insert(".", at: formattedCNPJ.index(formattedCNPJ.startIndex, offsetBy: 6))
        }
        
        if formattedCNPJ.count >= 11 {
            formattedCNPJ.insert("/", at: formattedCNPJ.index(formattedCNPJ.startIndex, offsetBy: 10))
        }
        
        return formattedCNPJ
    }
}
