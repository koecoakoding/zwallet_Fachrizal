//
//  StringExtention.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 15/08/23.
//

import Foundation

extension String{
    var isEmail: Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailpred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailpred.evaluate(with: self)
    }
    
    var isSecurePassword: Bool{
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passpred = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passpred.evaluate(with: self)
    }
    
    var isUsername: Bool{
        let uNameRegEx = "^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$" //(user_name)/(user.name)
        
        let uNamepred = NSPredicate(format: "SELF MATCHES %@", uNameRegEx)
        return uNamepred.evaluate(with: self)
    }
}
