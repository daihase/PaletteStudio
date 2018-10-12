//
//  MenuSelectPresenter.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/01.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class ContainerPresenter: ContainerModuleInterface {
    var view: ContainerViewInterface!
    var interactor: ContainerInteractor!
    var wireframe: ContainerWireframe!
    
    func showContainer() {
        self.interactor.showContainer()
    }

    func showCanvas(_ image: UIImage) {
        self.interactor.showCanvas(image)
    }
    
    func showStarListViewController() {
        self.interactor.showStarListViewController()
    }
    
    func showSettingViewController() {
        self.interactor.showSettingViewController()
    }
}

extension ContainerPresenter: ContainerInteractorOutput {
    func movedToContainerScreen() {
        self.wireframe.presentContainerInterfaceForModeSelect()
    }
    
    func movedToCanvasScreen(_ image: UIImage) {
        self.wireframe.presentCanvasInterfaceForModeSelect(image)
    }
    
    func movedToStarListScreen() {
        self.wireframe.presentStarListInterfaceForModeSelect()
    }
    
    func movedToSettingScreen() {
        self.wireframe.presentSettingInterfaceForModeSelect()
    }
}
