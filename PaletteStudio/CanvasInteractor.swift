//
//  CanvasInteractor.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/08.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import Photos
import Social

class CanvasInteractor: NSObject, CanvasInteractorInput {
    var composeView : SLComposeViewController!
    var output: CanvasInteractorOutput!
    
    func tapPenIcon() {
        self.output.showPenSettingView()
    }

    func changePenMode() {
        self.output.setDrawingMode(.doodleToolTypePen)
    }

    func tappedPenPositiveButton(_ lineWidth: Float, lineAlpha: Float) {
        PSUserDefault.sharedInstance.setFloatValue(lineWidth, key: PSUserDefault.Keys.penThickness)
        PSUserDefault.sharedInstance.setFloatValue(lineAlpha, key: PSUserDefault.Keys.penTransparency)
        
        self.output.setPenState(lineWidth, lineAlpha: lineAlpha)
    }
    
    func tapEraserIcon() {
        self.output.showEraserSettingView()
    }

    func changeEraserMode() {
        self.output.setDrawingMode(.doodleToolTypeEraser)
    }

    func tappedEraserPositiveButton(_ lineWidth: Float) {
        PSUserDefault.sharedInstance.setFloatValue(lineWidth, key: PSUserDefault.Keys.eraserThickness)
        
        self.output.setEraserState(lineWidth)
    }
    
    func tapStampIcon(_ canvasIcon: CanvasIconList?) {
        self.output.showStampView(canvasIcon)
    }

    func changeStampMode() {
        self.output.setDrawingMode(.doodleToolTypeStamp)
    }
    
    func tapUndoIcon() {
        self.output.undo()
    }
    
    func tapRedoIcon() {
        self.output.redo()
    }
    
    func tapPenColorIcon() {
        self.output.showPenColorSettingView()
    }

    func tappedPenColorPickerPositiveButton(_ colorPicker: DoodleColorPicker) {
        let selectedColor = colorPicker.color
        PSUserDefault.sharedInstance.setStringValue((selectedColor?.hexString!)!, key: PSUserDefault.Keys.penColorHexString)
        self.output.setPenColorState(selectedColor!)
    }
    
    func tapPhotoFilterIcon(_ loadImage: UIImage, canvasIcon: CanvasIconList, filtersArrayNumber: Int?) {
        self.output.showPhotoFilterView(loadImage, canvasIcon: canvasIcon, filtersArrayNumber: filtersArrayNumber)
    }

    func setPhotoFilter(_ filtersArrayNumber: Int) {
        self.output.changeCanvsPhotoImage(filtersArrayNumber)
    }

    func setNonPhotoFilter() {
        self.output.nonChangeCanvasPhotoImage()
    }
    
    func tapDeleteIcon() {
        self.output.showDeleteConfirmView()
    }

    func tappedDeletePositiveButton() {
        self.output.deleteCanvas()
    }
    
    func tapSaveIcon() {
        self.output.showSaveConfirmView()
    }

    func tapSaveButton(_ drawingView: UIView) {
        self.output.closeSaveDialog()
        PSPhotoManager.sharedInstance.Authorization { (completion: Bool) -> Void in
            if completion {
                PSPhotoManager.sharedInstance.createAlbum(albumName: "Palette Studio", targetView: drawingView)
            } else {
            }
        }
    }
    
    func tapShareIcon() {
        self.output.showShareConfirmView()
    }

    func tappedTwitterShareButton(_ drawingView: UIView) {
        composeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        composeView.setInitialText("Twitter Test from Swift")
        composeView.add(PSUtil.getScreenCapture(targetView: drawingView))
   
        self.output.showTwitterView(composeView)
    }

    func tappedFacebookShareButton(_ drawingView: UIView) {
        composeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        composeView.setInitialText("Facebook Test")
        composeView.add(PSUtil.getScreenCapture(targetView: drawingView))

        self.output.showFacebookView(composeView)
    }

    func tappedLineShareButton(_ drawingView: UIView) {
        let pastBoard: UIPasteboard = UIPasteboard.general
        pastBoard.setData(UIImageJPEGRepresentation(PSUtil.getScreenCapture(targetView: drawingView), 1.0)!, forPasteboardType: "public.png")
        let lineUrlString: String = String(format: "line://msg/image/%@", pastBoard.name as CVarArg)
        
        self.output.showLine(lineUrlString)
    }
}
