//
//  ReissueWireframe.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/28.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class ReissueWireframe: NSObject {
    weak var reissueViewController: ReissueViewController!
    var reissuePresenter: ReissuePresenter!
    var reissueWireframe: ReissueWireframe!
    
    override init()
    {
        super.init()
        
        let reissueInteractor = ReissueInteractor()
        self.reissuePresenter = ReissuePresenter()
        self.reissuePresenter.interactor = reissueInteractor
        self.reissuePresenter.wireframe = self.reissueWireframe
        
        reissueInteractor.output = self.reissuePresenter
    }
    
    func presentReissueInterfaceFromViewController(_ controller: UIViewController)
    {
        self.reissueViewController = StoryboardBuilder.sharedInstance.reissueViewController()
        self.reissueViewController.presenter = self.reissuePresenter
        self.reissuePresenter.view = self.reissueViewController
        self.reissuePresenter.wireframe = self
        
        controller.navigationController!.pushViewController(reissueViewController, animated: true)
    }
}
