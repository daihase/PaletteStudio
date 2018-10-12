//
//  DoodleDrawingSubTools.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/31.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

enum DoodleSubToolType {
    case doodleSubToolTypePen
    case doodleSubToolTypeEraser
}

protocol DoodleDrawingSubTools {
    var lineColor: UIColor { get set }
    var lineAlpha: CGFloat { get set }
    var lineWidth: CGFloat { get set }
    var lineWidthEraser: CGFloat { get set }
    
    func setInitialPoint(_ firstPoint: CGPoint)
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint)
    func draw(_ rect: CGRect)
}

class DoodleDrawingSubPenTool: UIBezierPath, DoodleDrawingSubTools {
    var path: CGMutablePath?
    var lineColor:UIColor = UIColor.blue
    var lineAlpha: CGFloat = 0
    var lineWidthEraser: CGFloat = 0
    var red: CGFloat = 1.0
    var green: CGFloat = 1.0
    var blue: CGFloat = 1.0
    var alpha: CGFloat = 1.0
    
    override init() {
        super.init()
        
        self.lineCapStyle = CGLineCap.round
        path = CGMutablePath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInitialPoint(_ firstPoint: CGPoint) {
    }
    
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
    }
    
    func draw(_ rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setLineCap(CGLineCap.round);
        context.setLineWidth(self.lineWidth);
        context.setStrokeColor(self.lineColor.cgColor)
        self.lineColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        context.setStrokeColor(red: red, green: green, blue: blue, alpha: self.lineAlpha)
        let startPoint = CGPoint(x: 20, y: rect.size.height / 2)
        let endPoint = CGPoint(x: rect.size.width - 20, y: rect.size.height / 2)
        let middlePoint1 = CGPoint(x: (rect.size.width - 20) / 3, y: (startPoint.y) * -1)
        let middlePoint2 = CGPoint(x: ((rect.size.width) / 3 * 2), y: startPoint.y * 3)
        context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        context.addCurve(to: CGPoint(x: endPoint.x, y: endPoint.y), control1: CGPoint(x: middlePoint1.x, y: middlePoint1.y), control2: CGPoint(x: middlePoint2.x, y: middlePoint2.y))
        context.strokePath()
    }
}

class DoodleDrawingSubEraserTool:  DoodleDrawingSubPenTool {
    override func draw(_ rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()!

        context.setLineCap(CGLineCap.round);
        context.setLineWidth(self.lineWidthEraser);
        context.setStrokeColor(UIColor.white.cgColor);
        context.setBlendMode(CGBlendMode.normal);
        
        let startPoint = CGPoint(x: 20, y: rect.size.height / 2)
        let endPoint = CGPoint(x: rect.size.width - 20, y: rect.size.height / 2)
        let middlePoint1 = CGPoint(x: (rect.size.width - 20) / 3, y: (startPoint.y) * -1)
        let middlePoint2 = CGPoint(x: ((rect.size.width) / 3 * 2), y: startPoint.y * 3)
        context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        context.addCurve(to: CGPoint(x: endPoint.x, y: endPoint.y), control1: CGPoint(x: middlePoint1.x, y: middlePoint1.y), control2: CGPoint(x: middlePoint2.x, y: middlePoint2.y))
        context.strokePath()
    }
}

