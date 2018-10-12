//
//  TopWireFrame.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/14.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//
// 未使用クラス
import UIKit

/*
class TopWireframe: NSObject {
    
    weak var topViewController: TopViewController!
    var topPresenter: TopPresenter!
    var rootWireframe: RootWireframe!
    var containerWireframe: ContainerWireframe!
    
    override init()
    {
        super.init()
        
        let topInteractor = TopInteractor()
        self.topPresenter = TopPresenter()
        self.topPresenter.interactor = topInteractor
        self.topPresenter.wireframe = self
        
        topInteractor.output = self.topPresenter
    }
    
    // TOP画面表示.
    func presentTopInterfaceFromWindow(_ window: UIWindow)
    {
        // トップ画面を生成し表示.
        self.topViewController = StoryboardBuilder.sharedInstance.topViewController()
        self.topViewController.presenter = self.topPresenter
        self.topPresenter.view = self.topViewController
        
        self.rootWireframe.showRootViewControllerInWindow(self.topViewController, window: window)
    }
    
    // Container画面表示.
    func presentContainerInterfaceForTop()
    {
        self.containerWireframe = ContainerWireframe()
//        self.containerWireframe.presentContainerInterfaceFromViewController(self.topViewController)
    }
}
*/
