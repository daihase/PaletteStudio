//
//  SettingWireframe.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/21.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class SettingWireframe: NSObject {
    weak var containerViewController: UIViewController!
    weak var settingViewController: SettingViewController!
    var settingPresenter: SettingPresenter!
    var settingWireframe: SettingWireframe!
    
    override init()
    {
        super.init()
        let settingInteractor = SettingInteractor()
        self.settingPresenter = SettingPresenter()
        self.settingPresenter.interactor = settingInteractor
        self.settingPresenter.wireframe = self
        
        settingInteractor.output = self.settingPresenter
    }
    
    func presentSettingInterfaceFromViewController()
    {
        self.settingViewController = StoryboardBuilder.sharedInstance.settingViewController()
        self.containerViewController = UINavigationController(rootViewController:  settingViewController)
        self.settingViewController.presenter = self.settingPresenter
            //.presenter = self.settingPresenter
        self.settingPresenter.view = settingViewController
        self.settingPresenter.wireframe = self
        
        if let slideMenuController = UIApplication.shared.keyWindow?.rootViewController as? SlideMenuController {
            slideMenuController.changeMainViewController(self.containerViewController, close: true)
        } else {
            let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
            let slideMenuController = navigationController.childViewControllers[0] as? SlideMenuController
            
            slideMenuController?.changeMainViewController(self.containerViewController, close: true)
        }
    }
}
