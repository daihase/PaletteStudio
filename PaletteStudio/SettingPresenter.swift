//
//  SettingPresenter.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/21.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class SettingPresenter: SettingModuleInterface {
    var view: SettingViewInterface!
    var interactor: SettingInteractor!
    var wireframe: SettingWireframe!
}

extension SettingPresenter: SettingInteractorOutput {}
