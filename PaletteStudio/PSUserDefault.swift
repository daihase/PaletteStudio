//
//  DoodleUserDefault.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/04.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class PSUserDefault: NSObject {
    struct Keys {
        static let penThickness: String = "thicknessOfPen"
        static let penColorHexString: String = "penColor"
        static let eraserThickness: String = "thicknessOfEraser"
        static let penTransparency: String = "transparencyOfPen"
        static let user_id: String = "user_id"
    }
    
    var userDefault : UserDefaults
    
    override init() {
        userDefault = UserDefaults.standard
    }
    
    static var sharedInstance: PSUserDefault = {
        return PSUserDefault()
    }()
    
    func valueFromUserDefault(key : String) -> AnyObject? {
        return userDefault.value(forKey: key) as AnyObject?
    }
    
    func stringValueFromUserDefault(_ key : String) -> String? {
        return valueFromUserDefault(key: key)?.stringValue
    }
    
    func integerValueFromUserDefault(_ key: String) -> Int? {
        return valueFromUserDefault(key: key)?.intValue
    }
    
    func floatValueFromUserDefault(_ key: String) -> Float? {
        return valueFromUserDefault(key: key)?.floatValue
    }
    
    func setFloatValue(_ value: Float, key: String) {
        userDefault.set(value, forKey: key)
        userDefault.synchronize()
    }
    
    func setStringValue(_ value: String, key: String) {
        userDefault.set(value, forKey: key)
        userDefault.synchronize()
    }
}
