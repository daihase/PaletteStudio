//
//  LoginInteractor.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/27.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class LoginInteractor: NSObject, LoginInteractorInput {
    var output: LoginInteractorOutput!
    
    func executeLoginApi(_ parameters: Dictionary<String, Dictionary<String, String>>) {
        print(parameters)
        
        self.output.showContainerView()
    }
    
    func tapReissueButton() {
        self.output.showReissueView()
    }
}
