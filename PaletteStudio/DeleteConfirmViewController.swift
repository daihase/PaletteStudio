//
//  DeleteConfirmViewController.swift
//  DoodleMaker
//
//  Created by daihase on 2016/05/25.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol DeleteConfirmViewControllerDelegate {
    func tappedDeletePositiveButton()
    func tappedDeleteNegativeButton()
}

class DeleteConfirmViewController: BaseViewController {
    @IBOutlet weak var titleLabel: AttributeLabel!
    @IBOutlet weak var positiveLabel: AttributeLabel!
    @IBOutlet weak var negativeLabel: AttributeLabel!
    var delegate: DeleteConfirmViewControllerDelegate?
    let deleteTitle = "Clear All?"
    let yesString = "YES"
    let noString = "NO"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabel()
        self.setupView()
    }

    private func setupLabel() {
        self.titleLabel.fontName = DoodleFont.constants.roundedMplusName
        self.positiveLabel.fontName = DoodleFont.constants.roundedMplusName
        self.negativeLabel.fontName = DoodleFont.constants.roundedMplusName
        self.titleLabel.minFontSize = 16
        self.positiveLabel.minFontSize = 16
        self.negativeLabel.minFontSize = 16
        self.titleLabel.setAttributeText(text: self.deleteTitle.localized())
        self.positiveLabel.setAttributeText(text: self.yesString.localized())
        self.negativeLabel.setAttributeText(text: self.noString.localized())
    }
    
    fileprivate func setupView() {
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    @IBAction func tapPositiveButton(_ sender: AnyObject) {
         self.delegate?.tappedDeletePositiveButton()
    }

    @IBAction func tapNegativeButton(_ sender: AnyObject) {
         self.delegate?.tappedDeleteNegativeButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
