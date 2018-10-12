//
//  StampIconModelManager.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/08.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StampIconModelManager: NSObject {

    typealias StampIconModel = (image: UIImage, themeColor: UIColor)
    
    static var sharedInstance: StampIconModelManager = {
        return StampIconModelManager()
    }()
    
    let data: [StampIconModel] = [
        (image: UIImage(named: "NormalStampIcon")!, themeColor: UIColor.red),
        (image: UIImage(named: "FontStampIcon")!, themeColor: UIColor.red),
        (image: UIImage(named: "AnimalStampIcon")!, themeColor: UIColor.red),
        (image: UIImage(named: "VehicleStampIcon")!, themeColor: UIColor.red),
        (image: UIImage(named: "FaceStampIcon")!, themeColor: UIColor.red)
    ]
}
