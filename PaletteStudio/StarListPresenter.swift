//
//  StarListPresenter.swift
//  PaletteStudio
//
//  Created by daihase on 2016/11/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StarListPresenter: StarListModuleInterface {
    var view: StarListViewInterface!
    var interactor: StarListInteractor!
    var wireframe: StarListWireframe!
}

extension StarListPresenter: StarListInteractorOutput {}
