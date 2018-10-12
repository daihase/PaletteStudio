//
//  StarListWireframe.swift
//  PaletteStudio
//
//  Created by daihase on 2016/11/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class StarListWireframe: NSObject {
    weak var containerViewController: UIViewController!
    weak var starListViewController: StarListViewController!
    var starListPresenter: StarListPresenter!
    var starListWireframe: StarListWireframe!
    
    override init()
    {
        super.init()
        let starListInteractor = StarListInteractor()
        self.starListPresenter = StarListPresenter()
        self.starListPresenter.interactor = starListInteractor
        self.starListPresenter.wireframe = self
        
        starListInteractor.output = self.starListPresenter
    }
    
    func presentStarListInterfaceFromViewController()
    {
        self.starListViewController = StoryboardBuilder.sharedInstance.starListViewController()
        self.containerViewController = UINavigationController(rootViewController:  starListViewController)
        self.starListViewController.presenter = self.starListPresenter
        self.starListPresenter.view = starListViewController
        self.starListPresenter.wireframe = self
        
        if let slideMenuController = UIApplication.shared.keyWindow?.rootViewController as? SlideMenuController {
            slideMenuController.changeMainViewController(self.containerViewController, close: true)
        } else {
            let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
            let slideMenuController = navigationController.childViewControllers[0] as? SlideMenuController
            
            slideMenuController?.changeMainViewController(self.containerViewController, close: true)
        }
        
    }
}

