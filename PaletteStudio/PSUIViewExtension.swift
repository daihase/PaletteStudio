//
//  PSUIViewExtension.swift
//  PaletteStudio
//
//  Created by daihase on 2016/09/21.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

extension UIView
{
    func copyView() -> AnyObject
    {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self))! as AnyObject
    }
}
