//
//  MenuSelectTopInteractor.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/01.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class ContainerInteractor: NSObject, ContainerInteractorInput {
    var output: ContainerInteractorOutput!
    
    func showContainer() {
        self.output.movedToContainerScreen()
    }
    
    func showCanvas(_ image: UIImage) {
        self.output.movedToCanvasScreen(image)
    }
    
    func showStarListViewController() {
        self.output.movedToStarListScreen()
    }
    
    func showSettingViewController() {
        self.output.movedToSettingScreen()
    }
}
