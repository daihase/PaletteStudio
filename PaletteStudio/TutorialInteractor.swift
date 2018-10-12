//
//  TutorialInteractor.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/26.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class TutorialInteractor: NSObject, TutorialInteractorInput {
    var output: TutorialInteractorOutput!
    
    func tapSignupButton() {
        self.output.showSignupView()
    }
    
    func tapLoginButton() {
        self.output.showLoginView()
    }
}
