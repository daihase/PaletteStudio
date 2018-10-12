//
//  ShareConfirmViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/09/24.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol ShareConfirmViewControllerDelegate {
    func tappedTwitterShareButton()
    func tappedFacebookShareButton()
    func tappedLineShareButton()
    func tappedShareReturnButton()
}

class ShareConfirmViewController: BaseViewController {
    @IBOutlet weak var titleLabel: AttributeLabel!
    @IBOutlet weak var returnLabel: AttributeLabel!
    var shareTitle = "Share?"
    var returnString = "Return"
    var delegate: ShareConfirmViewControllerDelegate!
    
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
        self.titleLabel.setAttributeText(text: self.shareTitle.localized())
        self.returnLabel.setAttributeText(text: self.returnString.localized())
    }
    
    fileprivate func setupView() {
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    @IBAction func twitterShareButton(_ sender: AnyObject) {
        self.delegate.tappedTwitterShareButton()
    }

    @IBAction func facebookShareButton(_ sender: AnyObject) {
        self.delegate.tappedFacebookShareButton()
    }

    @IBAction func lineShareButton(_ sender: AnyObject) {
        self.delegate.tappedLineShareButton()
    }
    
    @IBAction func tapReturnButton(_ sender: AnyObject) {
        self.delegate.tappedShareReturnButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
