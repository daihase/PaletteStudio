//
//  SignupWireframe.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/28.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class SignupWireframe: NSObject {

    weak var signupViewController: SignupViewController!
    var signupPresenter: SignupPresenter!
    var signupWireframe: SignupWireframe!
     var rootWireframe: RootWireframe!
    var containerWireframe: ContainerWireframe!
    
    override init()
    {
        super.init()
        
        let signupInteractor = SignupInteractor()
        self.signupPresenter = SignupPresenter()
        self.signupPresenter.interactor = signupInteractor
        self.signupPresenter.wireframe = self.signupWireframe
        signupInteractor.output = self.signupPresenter
        
        self.containerWireframe = ContainerWireframe()
        let rootWireframe = RootWireframe()
        self.containerWireframe.rootWireframe = rootWireframe
        
    }
    
    func presentSignupInterfaceFromViewController(_ controller: UIViewController)
    {
        self.signupViewController = StoryboardBuilder.sharedInstance.signupViewController()
        self.signupViewController.presenter = self.signupPresenter
        self.signupPresenter.view = self.signupViewController
        self.signupPresenter.wireframe = self

        let navigationController = UINavigationController(rootViewController: self.signupViewController)
        
        controller.present(navigationController, animated: true, completion: nil)

    }
    
    func presentContainerInterfaceForSignup() {
         self.containerWireframe.presentContainerInterfaceForSignup()
    }
}
