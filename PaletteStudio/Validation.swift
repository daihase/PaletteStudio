//
//  Validation.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/28.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class Validation: NSObject {
    class func validEmail(_ string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: string)
        return result
    }
    
    class func validPassword(_ string: String) -> String {
        
        let result =  string.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        return result
    }
    
    class func validBlankAndSpace(_ string: String) -> String {
        let result =  string.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        return result
    }
    
    class func validPhoneNumber(_ string: String) -> Bool {
        let phoneNumberRegEx = "[0-9]{2,4}-[0-9]{2,4}-[0-9]{2,4}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegEx)
        let result = predicate.evaluate(with: string)
        
        return result
    }
    
    class func validOnlyNumber(_ string: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES '\\\\d+'")
        let result = predicate.evaluate(with: string)
        
        return result
    }
    
    class func validAlphabetNumber(_ string: String) -> Bool {
        let alphabetNumberRegEx = "[a-zA-Z0-9]+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", alphabetNumberRegEx)
        let result = predicate.evaluate(with: string)
        
        return result
    }
}
