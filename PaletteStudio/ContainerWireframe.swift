//
//  ModeWireframe.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/14.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ContainerWireframe: NSObject {
    weak var containerViewController: UIViewController!
    weak var settingViewController: SettingViewController!
    var containerPresenter: ContainerPresenter!
    var rootWireframe: RootWireframe!
    var canvasWireframe: CanvasWireframe!
    var settingWireframe: SettingWireframe!
    var starListWireframe: StarListWireframe!
    var targetViewController: UIViewController!
    
    override init()
    {
        super.init()
        let containerInteractor = ContainerInteractor()
        self.containerPresenter = ContainerPresenter()
        self.containerPresenter.interactor = containerInteractor
        self.containerPresenter.wireframe = self
        
        containerInteractor.output = self.containerPresenter
    }
    
    func presentContainerInterfaceFromWindow(_ window: UIWindow)
    {
        let containerViewController = StoryboardBuilder.sharedInstance.containerViewController()
        containerViewController.presenter = self.containerPresenter
        self.containerPresenter.view = containerViewController
        self.containerPresenter.wireframe = self
        self.targetViewController = containerViewController
        self.rootWireframe.showRootViewControllerInWindow(containerViewController, window: window)
    }
    
    func presentContainerInterfaceForSignup() {
        let containerViewController = StoryboardBuilder.sharedInstance.containerViewController()
        containerViewController.presenter = self.containerPresenter
        self.containerPresenter.view = containerViewController
        self.containerPresenter.wireframe = self
        self.targetViewController = containerViewController
        let leftViewController = StoryboardBuilder.sharedInstance.slideMenuViewController()
        let navigationController: UINavigationController = UINavigationController(rootViewController: containerViewController)
        
        leftViewController.mainViewController = navigationController
        leftViewController.delegate = containerViewController
        
        let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        let currentRootViewController = UIApplication.shared.keyWindow?.rootViewController

        (currentRootViewController as? UINavigationController)?.setViewControllers([slideMenuController], animated: false)
    }
    
    func presentContainerInterfaceForLogin() {
        let containerViewController = StoryboardBuilder.sharedInstance.containerViewController()
        containerViewController.presenter = self.containerPresenter
        self.containerPresenter.view = containerViewController
        self.containerPresenter.wireframe = self
        self.targetViewController = containerViewController
        let leftViewController = StoryboardBuilder.sharedInstance.slideMenuViewController()
        let navigationController: UINavigationController = UINavigationController(rootViewController: containerViewController)
        leftViewController.mainViewController = navigationController
        leftViewController.delegate = containerViewController
        let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        let currentRootViewController = UIApplication.shared.keyWindow?.rootViewController

        (currentRootViewController as? UINavigationController)?.setViewControllers([slideMenuController], animated: false)
    }
    
    func presentContainerInterfaceForModeSelect()
    {
        let containerViewController = StoryboardBuilder.sharedInstance.containerViewController()
        containerViewController.presenter = self.containerPresenter
        self.containerPresenter.view = containerViewController
        self.containerPresenter.wireframe = self
        self.containerViewController = UINavigationController(rootViewController: containerViewController)
        self.targetViewController = containerViewController // Canvas遷移のためのtargetセット.

        if let slideMenuController = UIApplication.shared.keyWindow?.rootViewController as? SlideMenuController {
            slideMenuController.changeMainViewController(self.containerViewController, close: true)
        } else {
            let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
            let slideMenuController = navigationController.childViewControllers[0] as? SlideMenuController
            
            slideMenuController?.changeMainViewController(self.containerViewController, close: true)
        }
    }
    
    func presentCanvasInterfaceForModeSelect(_ image: UIImage)
    {
        self.canvasWireframe = CanvasWireframe()
        self.canvasWireframe.presentCanvasInterfaceFromViewController(self.targetViewController, loadImage: image)
    }
    
    func presentStarListInterfaceForModeSelect() {
        self.starListWireframe = StarListWireframe()
        self.starListWireframe.presentStarListInterfaceFromViewController()
        self.targetViewController = self.starListWireframe.starListViewController
    }
    
    func presentSettingInterfaceForModeSelect() {
        self.settingWireframe = SettingWireframe()
        self.settingWireframe.presentSettingInterfaceFromViewController()
        self.targetViewController = self.settingWireframe.settingViewController
    }
}
