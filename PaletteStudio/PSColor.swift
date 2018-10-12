//
//  DoodleColor.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/08.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//
import UIKit

class PSColor: NSObject {
    class func subDialogViewBorderColor() -> UIColor {
        return UIColor(hexString: "#cfcfcf", alpha: 1.0)
    }
    
    class func subDialogViewBackgroundColor() -> UIColor {
        return UIColor(hexString: "#f6f6f6", alpha: 1.0)
    }
    
    class func companyColor() -> UIColor {
        return UIColor(hexString: "3c8ba7", alpha: 1.0)
    }
    
    class func buttonHighlightCompanyColor() -> UIColor {
        return UIColor(hexString: "247490", alpha: 1.0)
    }
    
    class func canvasBackgroundColor() -> UIColor {
        return UIColor(hexString: "3b3b3b", alpha: 1.0)
    }
}
