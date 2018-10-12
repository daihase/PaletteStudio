//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by daihase on 2016/08/02.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class DoodleColorPicker: UIView {
    var colorWheel: ColorWheel!
    var brightnessView: BrightnessView!
    var selectedColorView: SelectedColorView!
    var color: UIColor!
    var hue: CGFloat = 1.0
    var saturation: CGFloat = 1.0
    var brightness: CGFloat = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    func setColorPicker(_ color: UIColor) {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        let ok: Bool = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        if (!ok) {
            print("SwiftHSVColorPicker: exception <The color provided to SwiftHSVColorPicker is not convertible to HSV>")
        }
        
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.color = color
        
        setup()
    }
    
    func setup() {
        let views = self.subviews
        
        for view in views {
            view.removeFromSuperview()
        }
        
        let selectedColorViewHeight: CGFloat = 44.0
        let brightnessViewHeight: CGFloat = 26.0     
        let colorWheelSize = min(self.bounds.width, self.bounds.height - selectedColorViewHeight - brightnessViewHeight)
        let centeredX = (self.bounds.width - colorWheelSize) / 2.0
        
        colorWheel = ColorWheel(frame: CGRect(x: centeredX, y: 0, width: colorWheelSize, height: colorWheelSize), color: self.color)
        colorWheel.delegate = self
        
        self.addSubview(colorWheel)
        
        selectedColorView = SelectedColorView(frame: CGRect(x: centeredX, y: colorWheel.frame.maxY, width: colorWheelSize, height: selectedColorViewHeight), color: self.color)
        
        self.addSubview(selectedColorView)
        
        brightnessView = BrightnessView(frame: CGRect(x: centeredX, y: selectedColorView.frame.maxY + 10, width: colorWheelSize, height: brightnessViewHeight), color: self.color)
        brightnessView.delegate = self
        
        self.addSubview(brightnessView)
    }
    
    func hueAndSaturationSelected(_ hue: CGFloat, saturation: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: 1.0)
        brightnessView.setViewColor(self.color)
        selectedColorView.setViewColor(self.color)
    }
    
    func brightnessSelected(_ brightness: CGFloat) {
        self.brightness = brightness
        self.color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: 1.0)
        colorWheel.setViewBrightness(brightness)
        selectedColorView.setViewColor(self.color)
    }
}
