//
//  SignupModuleInterface.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/28.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol SignupModuleInterface: class {
    func executeSignupApi(_ parameters: Dictionary<String, Dictionary<String, String>>)
}
