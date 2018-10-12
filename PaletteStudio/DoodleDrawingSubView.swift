//
//  DoodleDrawingSubView.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/31.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class DoodleDrawingSubView: UIView {
    var lineColor: UIColor = UIColor.red
    var lineWidth: CGFloat = 10.0
    var lineWidthEraser: CGFloat = 10.0
    var lineAlpha: CGFloat = 1
    var drawTool: DoodleSubToolType?
    var currentTool: DoodleDrawingSubTools?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    fileprivate func toolWithCurrentSettings() -> DoodleDrawingSubTools? {
        if let toolType = self.drawTool {
            switch toolType {
            case .doodleSubToolTypePen:
                return DoodleDrawingSubPenTool()
            case .doodleSubToolTypeEraser:
                return  DoodleDrawingSubEraserTool()
            }
        }
        
        return DoodleDrawingSubPenTool()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.currentTool = self.toolWithCurrentSettings()
        self.currentTool?.lineWidth = self.lineWidth
        self.currentTool?.lineWidthEraser = self.lineWidthEraser
        self.currentTool?.lineAlpha = self.lineAlpha
        self.currentTool?.draw(rect)
    }
    
    func setPenThicknessParameter(_ value: Float) {
        self.lineWidth = CGFloat(value)
        self.setNeedsDisplay()
    }
    
    func setEraserThicknessParameter(_ value: Float) {
        self.lineWidthEraser = CGFloat(value)
        self.setNeedsDisplay()
    }

    func setTransparencyParameter(_ value: Float) {
        self.lineAlpha = CGFloat(value)
        self.setNeedsDisplay()
    }
}
