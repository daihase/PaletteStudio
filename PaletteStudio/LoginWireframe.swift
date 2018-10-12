//
//  LoginWireframe.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/27.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class LoginWireframe: NSObject {
    
    weak var loginViewController: LoginViewController!
    var loginPresenter: LoginPresenter!
    var loginWireframe: LoginWireframe!
    var reissueWireframe: ReissueWireframe!
    var containerWireframe: ContainerWireframe!
    var rootWireframe: RootWireframe!
    
    override init()
    {
        super.init()
        
        let loginInteractor = LoginInteractor()
        self.loginPresenter = LoginPresenter()
        self.loginPresenter.interactor = loginInteractor
        self.loginPresenter.wireframe = self.loginWireframe
        loginInteractor.output = self.loginPresenter
        
        self.containerWireframe = ContainerWireframe()
        let rootWireframe = RootWireframe()
        self.containerWireframe.rootWireframe = rootWireframe
    }
    
    func presentLoginInterfaceFromViewController(_ controller: UIViewController)
    {
        self.loginViewController = StoryboardBuilder.sharedInstance.loginViewController()
        self.loginViewController.presenter = self.loginPresenter
        self.loginPresenter.view = self.loginViewController
        self.loginPresenter.wireframe = self
        
        let navigationController = UINavigationController(rootViewController: self.loginViewController)
        
        controller.present(navigationController, animated: true, completion: nil)
    }
    
    func presentReissueInterfaceForLogin() {
        self.reissueWireframe = ReissueWireframe()
        self.reissueWireframe.presentReissueInterfaceFromViewController(self.loginViewController)
    }
    
    func presentContainerInterfaceForLogin() {
         self.containerWireframe.presentContainerInterfaceForLogin()
    }
}
