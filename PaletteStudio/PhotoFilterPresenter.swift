//
//  PhotoFilterPresenter.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/25.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class PhotoFilterPresenter: PhotoFilterModuleInterface {
    var view: PhotoFilterViewInterface!
    var interactor: PhotoFilterInteractor!
    var wireframe: PhotoFilterWireframe!
    
}

extension PhotoFilterPresenter: PhotoFilterInteractorOutput {}
