//
//  CanvasWireFrame.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/08.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class CanvasWireframe: NSObject {
    weak var canvasViewController: CanvasViewController!
    var canvasPresenter: CanvasPresenter!
    var rootWireframe: RootWireframe!
    var canvasIconList: CanvasIconList!
    var filtersArrayNumber: Int?
    var stampWireframe: StampWireframe!
    var photoFilterWireframe: PhotoFilterWireframe!
    var loadImage: UIImage!
    
    override init()
    {
        super.init()
        
        let canvasInteractor = CanvasInteractor()
        self.canvasPresenter = CanvasPresenter()
        self.canvasPresenter.interactor = canvasInteractor
        self.canvasPresenter.wireframe = self
        
        canvasInteractor.output = self.canvasPresenter
    }
    
    func presentCanvasInterfaceFromViewController(_ controller: UIViewController, loadImage: UIImage)
    {
        self.canvasViewController = StoryboardBuilder.sharedInstance.canvasViewController()
        self.canvasViewController.presenter = self.canvasPresenter
        self.canvasViewController.loadImage = loadImage
        self.canvasPresenter.view = canvasViewController
        
        controller.navigationController!.pushViewController(canvasViewController, animated: true)
    }
    
    func presentStampInterfaceForCanvas()
    {
        self.stampWireframe = StampWireframe()
        self.stampWireframe.canvasIconList = self.canvasIconList
        self.stampWireframe.presentCanvasInterfaceFromViewController(self.canvasViewController)
    }
    
    func presentPhotoFilterInterfaceForCanvas() {
        self.photoFilterWireframe = PhotoFilterWireframe()
        self.photoFilterWireframe.loadImage = self.loadImage
        self.photoFilterWireframe.canvasIconList = self.canvasIconList
        self.photoFilterWireframe.filtersArrayNumber = self.filtersArrayNumber
        self.photoFilterWireframe.presentPhotoFilterInterfaceFromViewController(self.canvasViewController)
    }
}
