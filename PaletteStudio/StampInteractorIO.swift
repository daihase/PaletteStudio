//
//  StampInteractorIO.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol StampInteractorInput {
    func selectStampIcon(stampData: StampTypeManager)
}

protocol StampInteractorOutput {
    func didSelectStampIcon(_ stampImage: UIImage)
}
