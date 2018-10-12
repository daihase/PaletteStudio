//
//  PhotoFilterWireframe.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/25.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class PhotoFilterWireframe: NSObject {
    weak var photoFilterViewController: PhotoFilterViewController!
    var photoFilterPresenter: PhotoFilterPresenter!
    var canvasIconList: CanvasIconList!
    var filtersArrayNumber: Int?
    var loadImage: UIImage!
    
    override init()
    {
        super.init()
        
        let photoFilterInteractor = PhotoFilterInteractor()
        self.photoFilterPresenter = PhotoFilterPresenter()
        self.photoFilterPresenter.interactor = photoFilterInteractor
        
        photoFilterInteractor.output = self.photoFilterPresenter
    }
    
    func presentPhotoFilterInterfaceFromViewController(_ controller: UIViewController)
    {
        self.photoFilterViewController = StoryboardBuilder.sharedInstance.photoFilterViewController()
        self.photoFilterViewController.presenter = self.photoFilterPresenter
        self.photoFilterViewController.loadImage = self.loadImage
        self.photoFilterViewController.delegate = self.canvasIconList
        self.photoFilterViewController.filtersArrayNumber = self.filtersArrayNumber
        self.photoFilterPresenter.view = self.photoFilterViewController
        self.photoFilterPresenter.wireframe = self
        let navigationController = UINavigationController(rootViewController: photoFilterViewController)
        
        controller.present(navigationController, animated: true, completion: nil)
    }
}
