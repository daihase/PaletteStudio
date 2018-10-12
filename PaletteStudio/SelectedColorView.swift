//
//  SelectedColorView.swift
//  ColorPicker
//
//  Created by daihase on 2016/08/02.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class SelectedColorView: UIView {
    var color: UIColor!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        
        self.setViewColor(color)
    }
    
    func setViewColor(_ color: UIColor) {
        self.color = color
        setBackgroundColor()
    }
    
    func setBackgroundColor() {
        backgroundColor = self.color
    }
}
