//
//  TutorialPresenter.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/26.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class TutorialPresenter: TutorialModuleInterface {
    var view: TutorialViewInterface!
    var interactor: TutorialInteractorInput!
    var wireframe: TutorialWireframe!
    
    func tapSignupButton() {
        self.interactor.tapSignupButton()
    }
    
    func tapLoginButton() {
        self.interactor.tapLoginButton()
    }

}

extension TutorialPresenter: TutorialInteractorOutput {
    func showSignupView() {
        self.wireframe.presentSignupInterfaceForTutorial()
    }
    
    func showLoginView() {
        self.wireframe.presentLoginInterfaceForTutorial()
    }
}
