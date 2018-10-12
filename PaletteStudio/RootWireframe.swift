//
//  TopWireFrame.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/14.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class RootWireframe: NSObject {
    func showRootViewControllerInWindow(_ viewController: UIViewController, window: UIWindow)
    {
        let leftViewController = StoryboardBuilder.sharedInstance.slideMenuViewController()
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        leftViewController.mainViewController = navigationController
        leftViewController.delegate = viewController as! ContainerViewController
        let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        window.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        window.rootViewController = slideMenuController
        window.makeKeyAndVisible()
    }
    
    func showRootViewControllerWithTutorialInWindow(_ viewController: UIViewController, window: UIWindow) {
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
    func showRootViewControllerWithLoginInWindow(_ viewController: UIViewController, window: UIWindow) {
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
