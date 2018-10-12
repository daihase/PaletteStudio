//
//  ReissueViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/28.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class ReissueViewController: UIViewController {
    @IBOutlet weak var sendButton: UIButton!
    let sendButtonText = "送信"
    var presenter: ReissueModuleInterface!
    
    let navigationTitle = "Log In"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.configure()
    }
    
    func setNavigationBar() {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    
    func configure() {
        self.sendButton.setTitle(self.sendButtonText.localized(), for: .normal)
        self.sendButton.setBackgroundImage(PSUtil.createColorImageFromUIColor(color: PSColor.companyColor()), for: .normal)
        self.sendButton.setBackgroundImage(PSUtil.createColorImageFromUIColor(color: PSColor.buttonHighlightCompanyColor()), for: .highlighted)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ReissueViewController: ReissueViewInterface {}
