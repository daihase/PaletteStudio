//
//  SaveConfirmViewController.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/14.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol SaveConfirmViewControllerDelegate {
    func tappedSaveButton()
    func tappedSaveReturnButton()
}

class SaveConfirmViewController: BaseViewController {
    @IBOutlet weak var titleLabel: AttributeLabel!
    @IBOutlet weak var returnLabel: AttributeLabel!
    @IBOutlet weak var saveLabel: AttributeLabel!
    var delegate: SaveConfirmViewControllerDelegate!
    let saveTitle = "Save this Picture?"
    let saveString = "Save As"
    let returnString = "Return"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabel()
        self.setupView()
    }
    
    fileprivate func setupLabel() {
        self.titleLabel.fontName = DoodleFont.constants.roundedMplusName
        self.saveLabel.fontName = DoodleFont.constants.roundedMplusName
        self.returnLabel.fontName = DoodleFont.constants.roundedMplusName
        self.titleLabel.minFontSize = 16
        self.saveLabel.minFontSize = 16
        self.returnLabel.minFontSize = 16
        self.titleLabel.setAttributeText(text: self.saveTitle.localized())
        self.saveLabel.setAttributeText(text: self.saveString.localized())
        self.returnLabel.setAttributeText(text: self.returnString.localized())
    }
    
    private func setupView() {
        self.view.frame.size.width = UIScreen.main.bounds.width
    }

    @IBAction func saveButton(_ sender: AnyObject) {
       self.delegate.tappedSaveButton()
    }
    
    @IBAction func tapReturnButton(_ sender: AnyObject) {
        self.delegate.tappedSaveReturnButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
