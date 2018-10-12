//
//  DoodleDrawingTools.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/15.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol DoodleDrawingTools {
    var lineColor: UIColor { get set}
    var lineAlpha: CGFloat { get set}
    var lineWidth: CGFloat { get set}
    var lineWidthEraser: CGFloat { get set}
    
    func setInitialPoint(_ firstPoint: CGPoint)
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint)
    func draw()
}

public enum PenType {
    case normal
    case blur
    case neon
}

class DoodleDrawingPenTool: UIBezierPath, DoodleDrawingTools {
    var path: CGMutablePath?
    var lineColor = UIColor.blue
    var lineAlpha: CGFloat = 0
    var lineWidthEraser: CGFloat = 0
    var drawingPenType: PenType!
    
    override init() {
        super.init()
        self.lineCapStyle = CGLineCap.round
        path = CGMutablePath.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInitialPoint(_ firstPoint: CGPoint) {
    }
    
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
    }
    
    func addPathPathPreviousPreviousPoint(_ p2Point: CGPoint, widhPreviousPoint p1Point: CGPoint, withCurrentPoint cpoint: CGPoint) -> CGRect {
        let mid1 = midPoint(p1Point, p2: p2Point)
        let mid2 = midPoint(cpoint, p2: p1Point)
        let subpath = CGMutablePath.init()
        subpath.move(to: CGPoint(x: mid1.x, y: mid1.y))
        subpath.addQuadCurve(to: CGPoint(x: mid2.x, y: mid2.y), control: CGPoint(x: p1Point.x, y: p1Point.y))
        let bounds: CGRect = subpath.boundingBox
        path?.addPath(subpath)

        return bounds
    }
    
    fileprivate func midPoint(_ p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) * 0.5, y: (p1.y + p2.y) * 0.5)
    }
    
    func draw() {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        if let type = self.drawingPenType {
            switch type {
            case .normal:
                context.addPath(path!)
                context.setLineCap(CGLineCap.round)
                context.setLineWidth(self.lineWidth);
                context.setStrokeColor(self.lineColor.cgColor)
                context.setBlendMode(CGBlendMode.normal)
                context.setAlpha(self.lineAlpha)
                context.strokePath()
                break
            case .blur:
                context.addPath(self.path!)
                context.setLineCap(CGLineCap.round)
                context.setLineWidth(self.lineWidth)
                context.setStrokeColor(self.lineColor.cgColor)
                context.setShadow(offset: CGSize(width:0, height:0), blur: self.lineWidth/1.25, color: self.lineColor.cgColor)
                context.setAlpha(self.lineAlpha)
                context.strokePath()
                break
            case .neon:
                context.addPath(self.path!)
                context.setLineCap(CGLineCap.round)
                context.setLineWidth(self.lineWidth)
                context.setStrokeColor(UIColor.white.cgColor)
                context.setShadow(offset: CGSize(width:0, height:0), blur: self.lineWidth/1.25, color: self.lineColor.cgColor)
                context.setBlendMode(CGBlendMode.screen)
                context.setAlpha(self.lineAlpha)
                context.strokePath()
                break
            }
        }
    }
}

class DoodleDrawingEraserTool:  DoodleDrawingPenTool {
    override func draw() {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.saveGState()
        context.addPath(path!)
        context.setLineCap(CGLineCap.round);
        context.setLineWidth(self.lineWidthEraser);
        context.setBlendMode(CGBlendMode.clear);
        context.strokePath()
        context.restoreGState()
    }
}

class DoodleDrawingStampTool: DoodleDrawingTools {
    var path: CGMutablePath?
    var lineColor = UIColor.blue
    var lineAlpha: CGFloat = 0
    var lineWidth: CGFloat = 0
    var lineWidthEraser: CGFloat = 0
    var touchPoint: CGPoint = CGPoint(x:0, y:0)
    var stampImage: UIImage?
    
    init() {
        path = CGMutablePath()
    }
    
    func setStampImage(stampImage: UIImage?) {
        if let stampImage = stampImage {
            self.stampImage = stampImage
        }
    }

    func getStamImage() -> UIImage?{
        return self.stampImage
    }
    
    func setInitialPoint(_ firstPoint: CGPoint) {
        self.touchPoint = firstPoint
    }
    
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
    }
    
    func draw() {
        if let image = self.getStamImage() {
            let imageX = touchPoint.x  - (image.size.width / 2)
            let imageY = touchPoint.y - (image.size.height / 2)
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            image.draw(in: CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight))
        }
    }
}


