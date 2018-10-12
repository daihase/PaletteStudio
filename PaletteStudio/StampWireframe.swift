//
//  StampWireframe.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/15.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StampWireframe: NSObject {
    weak var stampContainerViewController: StampContainerViewController!
    var stampPresenter: StampPresenter!
    var canvasIconList: CanvasIconList!
    
    override init()
    {
        super.init()
        
        let stampInteractor = StampInteractor()
        self.stampPresenter = StampPresenter()
        self.stampPresenter.interactor = stampInteractor
        stampInteractor.output = self.stampPresenter
    }
    
    func presentCanvasInterfaceFromViewController(_ controller: UIViewController)
    {
        let presenter = StampPresenter()
        let interactor = StampInteractor()
        let stampContainerViewController = StoryboardBuilder.sharedInstance.stampContainerViewController()
        stampContainerViewController.stampHandler = presenter
        stampContainerViewController.delegate = self.canvasIconList
        presenter.view = stampContainerViewController
        presenter.interactor = interactor
        interactor.output = presenter
        stampContainerViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        controller.present(stampContainerViewController, animated: true, completion: nil)
    }
}
