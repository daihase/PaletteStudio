//
//  ReissueInteractor.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/28.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class ReissueInteractor: NSObject, ReissueInteractorInput{
    
    var output: ReissueInteractorOutput!
    
    func executeLoginApi(_ parameters : Dictionary<String, Dictionary<String, String>>) {
        print(parameters)
    }
}
