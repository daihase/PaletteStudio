//
//  SettingTableViewCell.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/22.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet weak var title: AttributeLabel!
    
    struct Constant {
        static let name = "SettingTableViewCell"
        static let identifier = "SettingTableViewCellIdentifier"
        static let height: CGFloat = 43.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
