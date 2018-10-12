//
//  CanvasZoomToastView.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/01.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class CanvasZoomToastView: UIView {
    @IBOutlet weak var zoomLabel: AttributeLabel!
    var zoomLabelString = "100.0%"
    
    class func instanceFromNib() -> CanvasZoomToastView {
        let instance: CanvasZoomToastView = UINib(
            nibName:"CanvasZoomToastView",
            bundle: Bundle.main
            ).instantiate(withOwner: self, options: nil)[0] as! CanvasZoomToastView
        
        return instance
    }
    
    func addToView(view: UIView) {
        var frame: CGRect = self.frame
        frame.origin = CGPoint(x: 0.0, y: self.frame.size.height)
        self.alpha = 0.0
        self.frame = frame
        backgroundColor = UIColor.clear
        view.addSubview(self)
        self.center = CGPoint(x: view.frame.size.width / 2.0, y: self.frame.size.height * 1.5)
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.alpha = 1.0
        }) { (finished:Bool) -> Void in

        }
    }
    
    func removeToView() {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in

            self.alpha = 0.0
        }) { (finished:Bool) -> Void in
        self.removeFromSuperview()
        }
    }
    
    func setZoomParam(zoomParamString: String) {
        self.zoomLabel.text = zoomParamString
    }
}
