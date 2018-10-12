//
//  StampInteractor.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

enum StampType {
    case normal
    case font
    case animal
    case vehicle
    case face
}

typealias StampTypeManager = (stampType: StampType, indexPath: IndexPath)

class StampInteractor: NSObject, StampInteractorInput {
    var output: StampInteractorOutput?
    var stampImage: UIImage!
    
    func selectStampIcon(stampData: StampTypeManager) {
        var stampFileName: String = ""
        switch stampData.stampType {
        case .normal:
            stampFileName = StampNormalManager.sharedInstance.getSelectedStampImage((stampData.indexPath as NSIndexPath).row)
            print("stampName: \(stampFileName)")
            self.stampImage =  UIImage(named: stampFileName)!
            
        case .font:
            print("a")
        case .animal:
            print("b")
        case .vehicle:
            print("c")
        case .face:
            print("d")
        }
        self.output?.didSelectStampIcon(self.stampImage)
    }
}
