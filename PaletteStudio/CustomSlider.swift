//
//  CustomSlider.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/29.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    var markColor: UIColor = UIColor(red: 106/255.0, green: 106/255.0, blue: 124/255.0, alpha: 0.7)
    var markWidth: CGFloat = 1.0
    var markPositions: NSArray = [10,20,30,40,50,60,70,80,90,100]
    var selectedBarColor: UIColor = UIColor(red: 179/255.0, green: 179/255.0, blue: 193/255.0, alpha:0.8)
    var unselectedBarColor: UIColor = UIColor(red: 55/255.0, green: 55/255.0, blue: 94/255.0, alpha: 0.8)
    var handlerImage: UIImage?
    var handlerColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let innerRect = rect.insetBy(dx: 1.0, dy: 10.0)

        UIGraphicsBeginImageContextWithOptions(innerRect.size, false, 0);
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(12.0)
        context.move(to: CGPoint(x: 6, y: innerRect.height / 2))
        context.addLine(to: CGPoint(x: innerRect.size.width - 10, y: innerRect.height / 2))
        context.setStrokeColor(self.selectedBarColor.cgColor)
        context.strokePath()

        let selectedSide = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero)
        
        context.setLineCap(CGLineCap.round);
        context.setLineWidth(12.0);
        context.move(to: CGPoint(x: 6, y: innerRect.height / 2));
        context.addLine(to: CGPoint(x: innerRect.size.width - 9, y: innerRect.height / 2));
        context.setStrokeColor(self.unselectedBarColor.cgColor)
        context.strokePath();
        let unselectedSide = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero)
        
        selectedSide?.draw(at: CGPoint(x: 0,y: 0))
        for i in 0 ..< self.markPositions.count {
            context.setLineWidth(self.markWidth)
            let floatStr = String(format: "%f", (self.markPositions[i] as AnyObject).doubleValue)
            let position = CGFloat(Double(floatStr)!) * innerRect.size.width / 100.0
            context.move(to: CGPoint(x: position, y: innerRect.height / 2 - 5))
            context.addLine(to: CGPoint(x: position, y: innerRect.height / 2 + 5))
            context.setStrokeColor(self.markColor.cgColor)
            context.strokePath()
        }
        
        let selectedStripSide = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero)
        
        unselectedSide?.draw(at: CGPoint(x: 0,y: 0))
        for i in 0 ..< self.markPositions.count {
            context.setLineWidth(self.markWidth)
            let floatStr = String(format: "%f", (self.markPositions[i] as AnyObject).doubleValue)
            let position = CGFloat(Double(floatStr)!) * innerRect.size.width / 100.0
            context.move(to: CGPoint(x: position, y: innerRect.height / 2 - 5))
            context.addLine(to: CGPoint(x: position, y: innerRect.height / 2 + 5))
            context.setStrokeColor(self.markColor.cgColor)
            context.strokePath()
        }
        
        let  unselectedStripSide = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero)
        
        UIGraphicsEndImageContext()
        
        self.setMinimumTrackImage(selectedStripSide, for: UIControlState())
        self.setMaximumTrackImage(unselectedStripSide, for: UIControlState())
        
        if self.handlerImage != nil {
            self.setThumbImage(self.handlerImage, for:UIControlState())
        } else if self.handlerColor != nil {
            self.setThumbImage(UIImage(), for: UIControlState())
            self.thumbTintColor = self.handlerColor
        }
    }
}
