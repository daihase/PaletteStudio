//
//  SignupPresenter.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/28.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class SignupPresenter: SignupModuleInterface {
    var view: SignupViewInterface!
    var interactor: SignupInteractorInput!
    var wireframe: SignupWireframe!

    func executeSignupApi(_ parameters: Dictionary<String, Dictionary<String, String>>) {
        self.interactor.executeSignupApi(parameters)
    }
}

extension SignupPresenter: SignupInteractorOutput {
    func showContainerView() {
        self.wireframe.presentContainerInterfaceForSignup()
        self.view.dismissSignupViewController()
    }
}
