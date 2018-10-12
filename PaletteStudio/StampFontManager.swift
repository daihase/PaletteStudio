//
//  StampFontManager.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/16.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StampFontManager: NSObject {
    typealias StampFontModel = (UIImage)
    
    static var sharedInstance: StampFontManager = {
        return StampFontManager()
    }()
    
    let data: [StampFontModel] = [
        (UIImage(named:"b_1.png"))!,
        (UIImage(named:"b_2.png"))!,
        (UIImage(named:"b_3.png"))!,
        (UIImage(named:"b_4.png"))!,
        (UIImage(named:"b_5.png"))!,
        (UIImage(named:"b_6.png"))!
    ]
}
