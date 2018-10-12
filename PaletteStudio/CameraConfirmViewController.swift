//
//  CameraConfirmViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/04.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol CameraConfirmViewControllerDelegate {
    func tappedCameraButton()
    func tappedGalleryButton()
    func tappedCameraReturnButton()
}

class CameraConfirmViewController: BaseViewController {
    @IBOutlet weak var titleLabel: AttributeLabel!
    @IBOutlet weak var returnLabel: AttributeLabel!
    var delegate: CameraConfirmViewControllerDelegate!
    let cameraTitle = "Camera?"
    let returnString = "戻る"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabel()
        self.setupView()
    }
    
    private func setupLabel() {
        self.titleLabel.fontName = DoodleFont.constants.roundedMplusName
        self.returnLabel.fontName = DoodleFont.constants.roundedMplusName
        self.titleLabel.minFontSize = 16
        self.returnLabel.minFontSize = 16
        self.titleLabel.setAttributeText(text: self.cameraTitle.localized())
        self.returnLabel.setAttributeText(text: self.returnString.localized())
    }
    
    private func setupView() {
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    @IBAction func tapCameraButton(_ sender: AnyObject) {
        self.delegate.tappedCameraButton()
    }
    
    @IBAction func tapGalleryButton(_ sender: AnyObject) {
        self.delegate.tappedGalleryButton()
    }
    
    @IBAction func tapReturnButton(_ sender: AnyObject) {
        self.delegate.tappedCameraReturnButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}
