//
//  ContainerCollectionViewCell.swift
//  PaletteStudio
//
//  Created by daihase on 2016/11/02.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class ContainerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    struct Constant {
        static let name = "ContainerCollectionViewCell"
        static let identifier = "ContainerCollectionViewCellIdentifier"
    }
}
