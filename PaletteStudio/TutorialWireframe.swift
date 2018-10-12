//
//  TutorialWireframe.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/26.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class TutorialWireframe: NSObject {
    weak var tutorialViewController: TutorialViewController!
    var tutorialPresenter: TutorialPresenter!
    var tutorialWireframe: TutorialWireframe!
    var rootWireframe: RootWireframe!
    var containerWireframe: ContainerWireframe!
    var signupWireframe: SignupWireframe!
    var loginWireframe: LoginWireframe!
    
    override init()
    {
        super.init()
        
        let tutorialInteractor = TutorialInteractor()
        self.tutorialPresenter = TutorialPresenter()
        self.tutorialPresenter.interactor = tutorialInteractor
        self.tutorialPresenter.wireframe = self
        
        tutorialInteractor.output = self.tutorialPresenter
    }
    
    func presentTutorialInterfaceFromWindow(_ window: UIWindow)
    {
        self.tutorialViewController = StoryboardBuilder.sharedInstance.tutorialViewController()
        self.tutorialViewController.presenter = self.tutorialPresenter
        self.tutorialPresenter.view = self.tutorialViewController
        
        self.rootWireframe.showRootViewControllerWithTutorialInWindow(self.tutorialViewController, window: window)
    }
    
    func presentSignupInterfaceForTutorial() {
        self.signupWireframe = SignupWireframe()
        self.signupWireframe.presentSignupInterfaceFromViewController(self.tutorialViewController)
    }
    
    func presentLoginInterfaceForTutorial() {
        self.loginWireframe = LoginWireframe()
        self.loginWireframe.presentLoginInterfaceFromViewController(self.tutorialViewController)
    }
    
    func presentContainerInterfaceForTop()
    {
        self.containerWireframe = ContainerWireframe()
    }
}
