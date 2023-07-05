//
//  String+Extension.swift
//  aMEI
//
//  Created by coltec on 21/06/23.
//

import Foundation
import Combine


extension String{
    func isEmail() -> Bool{
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,10}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
}
