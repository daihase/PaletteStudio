//
//  LoginPresenter.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/27.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class LoginPresenter: LoginModuleInterface {
    var view: LoginViewInterface!
    var interactor: LoginInteractorInput!
    var wireframe: LoginWireframe!
    
    func executeLoginApi(_ parameters: Dictionary<String, Dictionary<String, String>>) {
        self.interactor.executeLoginApi(parameters)
    }
    
    func tapReissueButton() {
        self.interactor.tapReissueButton()
    }
    
}

extension LoginPresenter: LoginInteractorOutput {
    func showReissueView() {
        self.wireframe.presentReissueInterfaceForLogin()
    }
    
    func showContainerView() {
        self.wireframe.presentContainerInterfaceForLogin()
        self.view.dismissLoginViewController()
    }
}
