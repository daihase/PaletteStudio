//
//  LoginModuleInterface.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/27.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol LoginModuleInterface: class {
    func tapReissueButton()
    func executeLoginApi(_ parameters: Dictionary<String, Dictionary<String, String>>)
}
