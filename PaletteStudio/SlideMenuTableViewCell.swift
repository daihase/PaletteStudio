//
//  SlideMenuTableViewCell.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/14.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class SlideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var title: AttributeLabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLabel()
    }
    
    struct Constant {
        static let name = "SlideMenuTableViewCell"
        static let identifier = "SlideMenuTableViewCellIdentifier"
        static let height: CGFloat = 50.0
    }
    
    fileprivate func setupLabel() {
        self.title.font = UIFont.boldSystemFont(ofSize: 15 * PSUtil.scaleRatioWithScreenWidth())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
