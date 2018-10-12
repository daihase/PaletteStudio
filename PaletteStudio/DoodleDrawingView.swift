//
//  DoodleView.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/14.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

enum DoodleToolType {
    case doodleToolTypePen
    case doodleToolTypeEraser
    case doodleToolTypeLine
    case doodleToolTypeRectagleStroke
    case doodleToolTypeRectagleFill
    case doodleToolTypeEllipseStroke
    case doodleToolTypeEllipseFill
    case doodleToolTypeText
    case doodleToolTypeMultilineText
    case doodleToolTypeCustoToolm
    case doodleToolTypeStamp
}

enum DoodleDrawingMode {
    case doodleDrawingModeScale
    case doodleDrawingModeOriginalSize
}

@objc protocol DoodleDrawingViewDelegate :NSObjectProtocol  {
    @objc optional func drawingView(_ view: DoodleDrawingView, willBeginDrawUsingTool tool: AnyObject)
    @objc optional func drawingView(_ view: DoodleDrawingView, didEndDrawUsingTool tool: AnyObject)
}

class DoodleDrawingView: UIView {
    var delegate: DoodleDrawingViewDelegate?
    var lineColor: UIColor = UIColor.red
    var lineWidth: CGFloat = 10.0
    var lineAlpha: CGFloat = 1
    var lineWidthEraser: CGFloat = 10.0
    var currentPoint: CGPoint?
    var previousPoint1: CGPoint?
    var previousPoint2: CGPoint?
    var originalFrameYPos: CGFloat = 0
    var pathArray: NSMutableArray = NSMutableArray()
    var bufferArray: NSMutableArray = NSMutableArray()
    var currentTool: DoodleDrawingTools?
    var drawMode: DoodleDrawingMode = DoodleDrawingMode.doodleDrawingModeOriginalSize
    var image: UIImage?
    var backgroundImage: UIImage?
    var drawTool: DoodleToolType = .doodleToolTypePen
    var drawintPenType: PenType!
    var stampImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        configure()
    }

    private func configure() {
        self.backgroundColor = UIColor.clear
        self.originalFrameYPos = self.frame.origin.y
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        switch self.drawMode {
        case .doodleDrawingModeOriginalSize:
            self.image?.draw(at: CGPoint.zero)
            break
            
        case .doodleDrawingModeScale:
            self.image?.draw(in: self.bounds)
            break
        }
    
        self.currentTool?.draw()
    }
    
    private func updateCacheImage(_ redraw: Bool) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
        if redraw {
            self.image = nil;
            switch self.drawMode {
            case .doodleDrawingModeOriginalSize:
                if let backgroundImage = self.backgroundImage  {
                (backgroundImage.copy() as! UIImage).draw(at: CGPoint.zero)
                }
                
                break
            case .doodleDrawingModeScale:
                (self.backgroundImage?.copy() as! UIImage).draw(in: self.bounds)
                break
            }
            
            for obj in self.pathArray {
                if let tool = obj as? DoodleDrawingTools {
                    tool.draw()
                }
            }
            
        } else {
            self.image?.draw(at: CGPoint.zero)
            self.currentTool?.draw()
        }
            self.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext()
    }
    
    private func toolWithCurrentSettings() -> DoodleDrawingTools? {
        switch self.drawTool {
        case .doodleToolTypePen:
            return DoodleDrawingPenTool()
        case .doodleToolTypeEraser:
            return  DoodleDrawingEraserTool()
        case .doodleToolTypeStamp:
            return DoodleDrawingStampTool()
        default:
            return DoodleDrawingPenTool()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        self.previousPoint1 = touch.previousLocation(in: self)
        self.currentPoint = touch.location(in: self)
        self.currentTool = self.toolWithCurrentSettings()
        self.currentTool?.lineWidth = self.lineWidth
        self.currentTool?.lineWidthEraser = self.lineWidthEraser
        self.currentTool?.lineColor = self.lineColor
        self.currentTool?.lineAlpha = self.lineAlpha

        if let tool = self.currentTool as? DoodleDrawingStampTool {
            self.pathArray.add(tool)
            tool.setStampImage(stampImage: stampImage)
            tool.setInitialPoint(self.currentPoint!)
        } else {
            if let tool = self.currentTool as? DoodleDrawingPenTool {
                self.pathArray.add(tool)
                tool.drawingPenType = self.drawintPenType
                tool.setInitialPoint(self.currentPoint!)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        self.previousPoint2 = self.previousPoint1
        self.previousPoint1 = touch.previousLocation(in: self)
        self.currentPoint = touch.location(in: self)

        if let penTool = self.currentTool as? DoodleDrawingPenTool {
            let bounds = penTool.addPathPathPreviousPreviousPoint(self.previousPoint2!, widhPreviousPoint: self.previousPoint1!, withCurrentPoint: self.currentPoint!)
            var drawBox: CGRect = bounds
            drawBox.origin.x -= self.lineWidth *  2.0
            drawBox.origin.y -= self.lineWidth * 2.0
            drawBox.size.width += self.lineWidth * 4.0
            drawBox.size.height += self.lineWidth * 4.0
            
            self.setNeedsDisplay(drawBox)
        }
        else {
            self.currentTool?.moveFromPoint(self.previousPoint1!, toPoint: self.currentPoint!)
            self.setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesMoved(touches, with: event)
        self.finishDrawing()
    }
    
    fileprivate func finishDrawing() {
        self.updateCacheImage(false)
        self.bufferArray.removeAllObjects()
        self.delegate?.drawingView!(self, didEndDrawUsingTool: self.currentTool! as AnyObject)
        self.currentTool = nil;
    }
    
    func resetTool() {
        self.currentTool = nil
    }

    func clear() {
        self.resetTool()
        self.bufferArray.removeAllObjects()
        self.pathArray.removeAllObjects()
        self.updateCacheImage(true)
        self.setNeedsDisplay()
    }
    
    func pinch() {
        self.resetTool()
        let tool: DoodleDrawingTools = self.pathArray.lastObject as! DoodleDrawingTools
        self.bufferArray.add(tool)
        self.pathArray.removeLastObject()
        self.updateCacheImage(true)
        self.setNeedsDisplay()
    }

    func loadImage(image: UIImage) {
        self.image = image
        self.backgroundImage =  image.copy() as? UIImage
        self.bufferArray.removeAllObjects()
        self.pathArray.removeAllObjects()
        self.updateCacheImage(true)
        self.setNeedsDisplay()
    }
    
    func canUndo() -> Bool {
        return self.pathArray.count > 0
    }
    
    func undoLatestStep() {
        if self.canUndo() {
            self.resetTool()
            let tool: DoodleDrawingTools = self.pathArray.lastObject as! DoodleDrawingTools
            self.bufferArray.add(tool)
            self.pathArray.removeLastObject()
            self.updateCacheImage(true)
            self.setNeedsDisplay()
        }
    }
    
    func canRedo() -> Bool {
        return self.bufferArray.count > 0;
    }
    
    func redoLatestStep() {
        if self.canRedo() {
            self.resetTool()
            let tool: DoodleDrawingTools = self.bufferArray.lastObject as! DoodleDrawingTools
            self.pathArray.add(tool)
            self.bufferArray.removeLastObject()
            self.updateCacheImage(true)
            self.setNeedsDisplay()
        }
    }
}
