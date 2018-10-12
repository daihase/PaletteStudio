//
//  StampIconCollectionViewCell.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StampIconCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var stampIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ image: UIImage, active: Bool) {
        stampIcon.image = image
        focusCell(active)
    }
    
    func focusCell(_ active: Bool) {
        if active == true {
        stampIcon.alpha = 0.5
        } else {
            stampIcon.alpha = 1.0
        }
    }
}
