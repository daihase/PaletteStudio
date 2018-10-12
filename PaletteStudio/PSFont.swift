//
//  Font.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/26.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
// Doodle Makerで使用するFontを管理.

import UIKit

class DoodleFont: NSObject {
    struct constants {
        static let roundedMplusName = "rounded-mplus-1p-black"
    }
    
    class func roundedMplusName(with size: CGFloat) -> UIFont {
        if let roundedMplusFont = UIFont(name: "rounded-mplus-1p-black", size: size) {
            return roundedMplusFont
        }
        return UIFont.systemFont(ofSize: size)
    }
}
