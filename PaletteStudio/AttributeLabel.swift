//
//  AttributeLabel.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/26.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class AttributeLabel: UILabel {
    @IBInspectable var fontName: String?
    @IBInspectable var minFontSize: NSNumber?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setAttributeNormalText(text: String) {
        let attText = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: text)
        
        if let autoFontSize = self.minFontSize {
            let fontSize = PSUtil.scaleRatioWithScreenWidth() * CGFloat(autoFontSize)
            let font = UIFont.systemFont(ofSize: fontSize)
            attText.addAttribute(NSFontAttributeName, value: font, range: range)
        }

        attributedText = attText
    }
    
    func setAttributeBoldText(text: String) {
        
        let attText = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: text)
        
        if let autoFontSize = self.minFontSize {
            let fontSize = PSUtil.scaleRatioWithScreenWidth() * CGFloat(autoFontSize)
            let font = UIFont.boldSystemFont(ofSize: fontSize)
            attText.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        attributedText = attText
    }
    
    func setAttributeText(text: String) {
        let attText = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: text)
        
        if let fontName = self.fontName, let autoFontSize = self.minFontSize {
            let fontSize = PSUtil.scaleRatioWithScreenWidth() * CGFloat(autoFontSize)
            let font = UIFont(name: fontName, size: fontSize)
            attText.addAttribute(NSFontAttributeName, value: font!, range: range)
        }
        attributedText = attText
    }
}
