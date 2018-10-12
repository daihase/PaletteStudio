//
//  PhotoFilterScrollView.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/26.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol PhotoFilterScrollViewDelegate{
    func tapFilterButtonImage(touchNumber: Int)
}

class PhotoFilterScrollView: UIScrollView {
    var Delegate: PhotoFilterScrollViewDelegate!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!

        if let buttonImage = touchEvent.view as? UIImageView {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut,  animations: {() -> Void in
                buttonImage.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
            })
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let preDx = touchEvent.previousLocation(in: self).x
        let newDx = touchEvent.location(in: self).x
        let dx = newDx - preDx
        
        if dx > 0.1 || dx < -0.1 {
            if let buttonImage = touchEvent.view as? UIImageView {
                
                UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut,  animations: {() -> Void in
                    buttonImage.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        if let buttonImage = touchEvent.view as? UIImageView {
            UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                buttonImage.transform = CGAffineTransform.identity.scaledBy(x: 1.08, y: 1.08)}, completion: {(_) -> Void in
                    
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        buttonImage.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                    })
            })
            
            self.Delegate.tapFilterButtonImage(touchNumber: Int(buttonImage.tag))
        }
    }
}
