//
//  SettingPushTableViewCell.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/24.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class SettingPushTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var toggle: UISwitch!
    let titleLabel = "バージョン"
    
    struct Constant {
        static let name = "SettingPushTableViewCell"
        static let identifier = "SettingPushTableViewCellIdentifier"
        static let height: CGFloat = 43.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
