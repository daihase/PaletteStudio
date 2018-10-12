//
//  PSUIImageExtension.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/22.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

extension UIImage {
    func resize (sourceImage:UIImage, scaledToWidth: CGFloat, scaledToHeight: CGFloat) -> UIImage {
        let oldWidth = sourceImage.size.width
        let oldHeight = sourceImage.size.height
        var newHeight: CGFloat!
        var newWidth: CGFloat!
        if  oldWidth > oldHeight || oldWidth == oldHeight {
            let scaleFactor = scaledToWidth / oldWidth
            let beforeNewHeight = sourceImage.size.height * scaleFactor
            let beforeNewWidth = oldWidth * scaleFactor
            
            if beforeNewHeight > scaledToHeight {
                let scaleFactor = scaledToHeight / beforeNewHeight
                newWidth = beforeNewWidth * scaleFactor
                newHeight = beforeNewHeight * scaleFactor
            } else {
                newWidth = beforeNewWidth
                newHeight = beforeNewHeight
            }
        } else {
            let scaleFactor = scaledToHeight / oldHeight
            let beforeNewWidth = sourceImage.size.width * scaleFactor
            let beforeNewHeight = oldHeight * scaleFactor
            
            if beforeNewHeight > scaledToWidth {
                let scaleFactor = scaledToWidth / beforeNewWidth
                newWidth = beforeNewWidth * scaleFactor
                newHeight = beforeNewHeight * scaleFactor
            } else {
                newWidth = beforeNewWidth
                newHeight = beforeNewHeight
            }
        }
        
        let imageSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        sourceImage.draw(in: CGRect(x:0, y:0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
