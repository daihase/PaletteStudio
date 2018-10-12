//
//  ModeSelectInterface.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/01.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol ContainerModuleInterface {
    func showContainer()
    func showCanvas(_ image: UIImage)
    func showStarListViewController()
    func showSettingViewController()
}
