//
//  TopInteractor.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/02/27.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class TopInteractor: NSObject, TopInteractorInput {
    var output: TopInteractorOutput!
    
    func setupView() {
        self.output.setupedView()
    }
}
