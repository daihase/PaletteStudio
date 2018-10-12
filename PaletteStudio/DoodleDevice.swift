//
//  Device.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/02.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class DoodleDevice {
    static fileprivate func getVersion(code: String) -> DoodleVersion {
        switch code {
            /*** iPhone ***/
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return DoodleVersion.iPhone4
        case "iPhone4,1", "iPhone4,2", "iPhone4,3":      return DoodleVersion.iPhone4S
        case "iPhone5,1", "iPhone5,2":                   return DoodleVersion.iPhone5
        case "iPhone5,3", "iPhone5,4":                   return DoodleVersion.iPhone5C
        case "iPhone6,1", "iPhone6,2":                   return DoodleVersion.iPhone5S
        case "iPhone7,2":                                return DoodleVersion.iPhone6
        case "iPhone7,1":                                return DoodleVersion.iPhone6Plus
        case "iPhone8,1":                                return DoodleVersion.iPhone6S
        case "iPhone8,2":                                return DoodleVersion.iPhone6SPlus
            
            /*** iPad ***/
        case "iPad1,1":                                  return DoodleVersion.iPad1
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return DoodleVersion.iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":            return DoodleVersion.iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":            return DoodleVersion.iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":            return DoodleVersion.iPadAir
        case "iPad5,3", "iPad5,4":                       return DoodleVersion.iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":            return DoodleVersion.iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":            return DoodleVersion.iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":            return DoodleVersion.iPadMini3
        case "iPad5,1", "iPad5,2":                       return DoodleVersion.iPadMini4
        case "iPad6,7", "iPad6,8":                       return DoodleVersion.iPadPro
            
            /*** iPod ***/
        case "iPod1,1":                                  return DoodleVersion.iPodTouch1Gen
        case "iPod2,1":                                  return DoodleVersion.iPodTouch2Gen
        case "iPod3,1":                                  return DoodleVersion.iPodTouch3Gen
        case "iPod4,1":                                  return DoodleVersion.iPodTouch4Gen
        case "iPod5,1":                                  return DoodleVersion.iPodTouch5Gen
        case "iPod7,1":                                  return DoodleVersion.iPodTouch6Gen
            
            /*** Simulator ***/
        case "i386", "x86_64":                           return DoodleVersion.Simulator
            
        default:                                         return DoodleVersion.Unknown
        }
    }
    
    static func size() -> DoodleSize {
        let w: Double = Double(UIScreen.main.bounds.size.width)
        let h: Double = Double(UIScreen.main.bounds.size.height)
        let screenHeight: Double = max(w, h)
        
        switch screenHeight {
        case 480:
            return DoodleSize.screen3_5Inch
        case 568:
            return DoodleSize.screen4Inch
        case 667:
            return UIScreen.main.scale == 3.0 ? DoodleSize.screen5_5Inch : DoodleSize.screen4_7Inch
        case 736:
            return DoodleSize.screen5_5Inch
        default:
            return DoodleSize.unknownSize
        }
    }
    
    class func version() -> DoodleVersion {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let versionName: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
        
        return DoodleDevice.getVersion(code: versionName)
    }
}
