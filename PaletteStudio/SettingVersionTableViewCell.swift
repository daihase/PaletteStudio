//
//  SettingVersionTableViewCell.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/23.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class SettingVersionTableViewCell: UITableViewCell {
    @IBOutlet weak var title: AttributeLabel!
    @IBOutlet weak var version: AttributeLabel!
    let titleLabel = "バージョン"
    var versionLabel: String!
    
    struct Constant {
        static let name = "SettingVersionTableViewCell"
        static let identifier = "SettingVersionTableViewCellIdentifier"
        static let height: CGFloat = 43.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLabel()
    }
    
    private func setupLabel() {
        self.title.text = titleLabel.localized()
        if let appVersion =  Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            self.version.text = appVersion
        } else {
            self.version.text = ""
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
