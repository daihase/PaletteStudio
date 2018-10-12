//
//  StampNormalManager.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/15.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StampNormalManager: NSObject {
    typealias StampNormalModel = (String)
    
    static var sharedInstance: StampNormalManager = {
        return StampNormalManager()
    }()
    
    let data: [StampNormalModel] = [
        ("a_1.png"),
        ("a_2.png"),
        ("a_3.png"),
        ("a_4.png"),
        ("a_5.png"),
        ("a_6.png"),
        ("a_7.png"),
        ("a_8.png"),
        ("a_9.png"),
        ("a_10.png"),
        ("a_11.png"),
        ("a_12.png"),
        ("a_13.png"),
        ("a_14.png"),
        ("a_15png")
        ]
    
    func getSelectedStampImage(_ index: Int) -> String {
        return self.data[index]
    }
}
