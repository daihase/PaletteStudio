//
//  PhotoFilterManager.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/26.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class PhotoFilterManager: NSObject {
    class  func setPhotoFilter(number: Int, targetImageView: UIImageView) -> UIImage {
        let CIfilterName = "\(filtersArray[number])"
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: targetImageView.image!)
        let filter = CIFilter(name: CIfilterName)
        filter!.setDefaults()
        
        switch number {
            
        case 13: 
            let color:UIColor = UIColor(red: 211/255.0, green: 46/255.0, blue: 178/255.0, alpha: 1.0)
            filter!.setValue(CIColor(color: color), forKey: kCIInputColorKey)
            filter!.setValue(0.8, forKey: kCIInputIntensityKey)
        case 14:
            let color:UIColor = UIColor(red: 50/255.0, green: 70/255.0, blue: 218/255.0, alpha: 1.0)
            filter!.setValue(CIColor(color: color), forKey: kCIInputColorKey)
            filter!.setValue(0.8, forKey: kCIInputIntensityKey)
        case 15:
            let color:UIColor = UIColor(red: 99/255.0, green: 218/255.0, blue: 90/255.0, alpha: 1.0)
            filter!.setValue(CIColor(color: color), forKey: kCIInputColorKey)
            filter!.setValue(0.8, forKey: kCIInputIntensityKey)
        case 16:
            let color:UIColor = UIColor(red: 247/255.0, green: 174/255.0, blue: 71/255.0, alpha: 1.0)
            filter!.setValue(CIColor(color: color), forKey: kCIInputColorKey)
            filter!.setValue(0.8, forKey: kCIInputIntensityKey)
        case 17:
            let color:UIColor = UIColor(red: 201/255.0, green: 91/255.0, blue: 96/255.0, alpha: 1.0)
            filter!.setValue(CIColor(color: color), forKey: kCIInputColorKey)
            filter!.setValue(0.8, forKey: kCIInputIntensityKey)
        case 18:
            let color:UIColor = UIColor(red: 241/255.0, green: 247/255.0, blue: 71/255.0, alpha: 1.0)
            filter!.setValue(CIColor(color: color), forKey: kCIInputColorKey)
            filter!.setValue(0.8, forKey: kCIInputIntensityKey)
        case 19:
            filter!.setValue(6.0, forKey: "inputLevels")
        case 20:
            let color0:UIColor = UIColor(red: 50/255.0, green: 70/255.0, blue: 218/255.0, alpha: 0.6)
            filter!.setValue(CIColor(color: color0), forKey: "inputColor0")
            let color1:UIColor = UIColor(red: 242/255.0, green: 192/255.0, blue: 18/255.0, alpha: 0.4)
            filter!.setValue(CIColor(color: color1), forKey: "inputColor1")
        case 21:
            let color0:UIColor = UIColor(red: 201/255.0, green: 91/255.0, blue: 97/255.0, alpha: 0.6)
            filter!.setValue(CIColor(color: color0), forKey: "inputColor0")
            let color1:UIColor = UIColor(red: 169/255.0, green: 201/255.0, blue: 91/255.0, alpha: 0.4)
            filter!.setValue(CIColor(color: color1), forKey: "inputColor1")
        case 22:
            let color0:UIColor = UIColor(red: 91/255.0, green: 201/255.0, blue: 99/255.0, alpha: 0.6)
            filter!.setValue(CIColor(color: color0), forKey: "inputColor0")
            let color1:UIColor = UIColor(red: 131/255.0, green: 145/255.0, blue: 38/255.0, alpha: 0.2)
            filter!.setValue(CIColor(color: color1), forKey: "inputColor1")
        case 23:
            let color0:UIColor = UIColor(red: 71/255.0, green: 247/255.0, blue: 220/255.0, alpha: 0.2)
            filter!.setValue(CIColor(color: color0), forKey: "inputColor0")
            let color1:UIColor = UIColor(red: 60/255.0, green: 230/255.0, blue: 200/255.0, alpha: 0.6)
            filter!.setValue(CIColor(color: color1), forKey: "inputColor1")
        case 24:
            let color0:UIColor = UIColor(red: 237/255.0, green: 71/255.0, blue: 247/255.0, alpha: 0.2)
            filter!.setValue(CIColor(color: color0), forKey: "inputColor0")
            let color1:UIColor = UIColor(red: 70/255.0, green: 6/255.0, blue: 147/255.0, alpha: 0.6)
            filter!.setValue(CIColor(color: color1), forKey: "inputColor1")
        case 25:
            filter!.setValue(0.9, forKey: kCIInputSharpnessKey)
        case 26:
            filter!.setValue(3.0, forKey: kCIInputRadiusKey)
            filter!.setValue(4.0, forKey: kCIInputIntensityKey)
        case 27:
            filter!.setValue(CIVector(x: 150, y: 150), forKey: kCIInputCenterKey)
            filter!.setValue(20.0, forKey: kCIInputScaleKey)
        case 28:
            filter!.setValue(3, forKey: kCIInputEVKey)
        case 29:
            filter!.setValue(-2, forKey: kCIInputEVKey)
        case 30:
            filter!.setValue(3, forKey: "inputPower")
        case 31:
            filter!.setValue(0.6, forKey: "inputPower")
        case 32:
            filter!.setValue(3.10, forKey: kCIInputAngleKey)
        case 33:
            filter!.setValue(2.00, forKey: kCIInputAngleKey)
            break
        case 34:
            filter!.setValue(1.00, forKey: kCIInputAngleKey)
            break
        case 36:
            filter!.setValue(0.5, forKey: "inputAmount")
            break
        case 37:
            filter!.setValue(0.5, forKey:"inputIntensity")
            break
        case 38:
            filter!.setValue(0.8, forKey:"inputIntensity")
            break
        case 39:
            filter!.setValue(3, forKey:"inputRadius")
            break
            
        default: break }
        
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
        let resultImage = UIImage(cgImage: filteredImageRef!)
        
        return resultImage
    }
}
