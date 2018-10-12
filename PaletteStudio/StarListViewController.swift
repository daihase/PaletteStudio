//
//  StarListViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/11/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StarListViewController: BaseViewController {
    var presenter: StarListModuleInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension StarListViewController: StarListViewInterface {}
