//
//  DoodleUtil.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/03.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import Foundation
import UIKit

class PSUtil {
    var rootWindow : UIWindow!
    class var sharedInstance : PSUtil {
        struct Static {
            static let instance : PSUtil = PSUtil()
        }
        return Static.instance
    }
    
    class func createColorImageFromUIColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    class func scaleRatioWithScreenWidth() -> CGFloat {
        switch DoodleDevice.size() {
        case .screen5_5Inch:
            return screen5_5InchWidth/screen4_InchWidth
        case .screen4_7Inch:
            return screen4_7InchWidth/screen4_InchWidth
        default:
            return 1
        }
    }
    
    class func getScreenCapture(targetView: UIView, rect: CGRect? = nil) -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(targetView.frame.size, false, scale);
        targetView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return screenshot!
    }
    
    func cropThumbnailImage(image :UIImage, w:Int, h:Int) -> UIImage {
        let origRef    = image.cgImage;
        let origWidth  = Int(origRef!.width)
        let origHeight = Int(origRef!.height)
        var resizeWidth:Int = 0, resizeHeight:Int = 0
        
        if (origWidth < origHeight) {
            resizeWidth = w
            resizeHeight = origHeight * resizeWidth / origWidth
        } else {
            resizeHeight = h
            resizeWidth = origWidth * resizeHeight / origHeight
        }
        
        let resizeSize = CGSize(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))
        UIGraphicsBeginImageContext(resizeSize)
        
        image.draw(in: CGRect(x: 0, y: 0, width: CGFloat(resizeWidth), height: CGFloat(resizeHeight)))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cropRect  = CGRect(
            x: CGFloat((resizeWidth - w) / 2),
            y: CGFloat((resizeHeight - h) / 2),
            width: CGFloat(w), height: CGFloat(h))
        let cropRef   = (resizeImage?.cgImage!)!.cropping(to: cropRect)
        let cropImage = UIImage(cgImage: cropRef!)
        
        return cropImage
    }
    
    class func showAlertView(
        title : String? = nil,
        message : String,
        actionTitles : [String],
        actions : [() -> ()]?) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.clear
        window.rootViewController = UIViewController()
        PSUtil.sharedInstance.rootWindow = UIApplication.shared.windows[0]
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        for title in actionTitles {
            let action = UIAlertAction(title: title, style: .default, handler: { (action : UIAlertAction) -> Void in
                if let acts = actions {
                    if acts.count >= actionTitles.count {
                        acts[actionTitles.index(of: title)!]()
                    }
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    alert.dismiss(animated: true, completion: nil)
                    window.isHidden = true
                    window.removeFromSuperview()
                    PSUtil.sharedInstance.rootWindow.makeKeyAndVisible()
                })
            })
            alert.addAction(action)
        }

        window.windowLevel = UIWindowLevelAlert
        window.makeKeyAndVisible()
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
