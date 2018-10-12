//
//  NVActivityIndicatorViewManager.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/19.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class NVActivityIndicatorViewManager: NSObject {
    var loadingUI: NVActivityIndicatorView?
    static var sharedInstance: NVActivityIndicatorViewManager = {
        
        return NVActivityIndicatorViewManager()
    }()

     func startLoadingIndicator(positionX :CGFloat = 0, positionY:CGFloat = 0, view: UIView) {
        
        let loadingUI = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        loadingUI.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        loadingUI.color = PSColor.companyColor()
        loadingUI.type = .lineSpinFadeLoader
        view.addSubview(loadingUI)
        view.bringSubview(toFront: loadingUI)
        loadingUI.startAnimating()
        
        self.loadingUI = loadingUI
    }
    
    func stopLoadingIndicator() {
        if let indicator = self.loadingUI {
           indicator.stopAnimating()
        }
    }
}
