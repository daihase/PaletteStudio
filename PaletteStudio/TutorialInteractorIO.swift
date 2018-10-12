//
//  TutorialInteractorIO.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/26.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol TutorialInteractorInput {
    func tapSignupButton()
    func tapLoginButton()
}

protocol TutorialInteractorOutput {
    func showLoginView()
    func showSignupView()
}
