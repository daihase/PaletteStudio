//
//  StampPresenter.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StampPresenter: NSObject {
    var view: StampViewInterface?
    var interactor: StampInteractor?
    
    func selectStampIcon(stampData: StampTypeManager) {
        self.interactor?.selectStampIcon(stampData: stampData)
    }
}

extension StampPresenter: StampInteractorOutput {
    func didSelectStampIcon(_ stampImage: UIImage) {
        self.view?.closeStampDialogView(stampImage)
    }
}
