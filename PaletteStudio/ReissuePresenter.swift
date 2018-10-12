//
//  ReissuePresenter.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/28.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class ReissuePresenter: ReissueModuleInterface {
    var view: ReissueViewInterface!
    var interactor: ReissueInteractorInput!
    var wireframe: ReissueWireframe!
}

extension ReissuePresenter: ReissueInteractorOutput {
}
