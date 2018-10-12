//
//  CanvasPresenter.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/08.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import Social

class CanvasPresenter: CanvasModuleInterface {
    var view: CanvasViewInterface!
    var interactor: CanvasInteractor!
    var wireframe: CanvasWireframe!
    
    func tapPenIcon() {
        self.interactor.tapPenIcon()
    }

    func changePenMode() {
        self.interactor.changePenMode()
    }

    func tappedPenPositiveButton(_ lineWidth: Float, lineAlpha: Float) {
        self.interactor.tappedPenPositiveButton(lineWidth, lineAlpha: lineAlpha)
    }
    func tapEraserIcon() {
        self.interactor.tapEraserIcon()
    }

    func changeEraserMode() {
        self.interactor.changeEraserMode()
    }

    func tappedEraserPositiveButton(_ lineWidthEraser: Float) {
        self.interactor.tappedEraserPositiveButton(lineWidthEraser)
    }
    
    func tapStampIcon(_ canvasIcon: CanvasIconList?) {
        self.interactor.tapStampIcon(canvasIcon)
    }
    
    func changeStampMode() {
        self.interactor.changeStampMode()
    }
    
    func tapUndoIcon() {
        self.interactor.tapUndoIcon()
    }
    
    func tapRedoIcon() {
        self.interactor.tapRedoIcon()
    }
    
    func tapPenColorIcon() {
        self.interactor.tapPenColorIcon()
    }
    
    func tappedPenColorPickerPositiveButton(_ colorPicker: DoodleColorPicker) {
        self.interactor.tappedPenColorPickerPositiveButton(colorPicker)
    }
    
    func tapPhotoFilterIcon(_ loadImage: UIImage, canvasIcon : CanvasIconList, filtersArrayNumber: Int?) {
        self.interactor.tapPhotoFilterIcon(loadImage, canvasIcon: canvasIcon, filtersArrayNumber: filtersArrayNumber)
    }

    func setPhotoFilter(_ filtersArrayNumber: Int) {
       self.interactor.setPhotoFilter(filtersArrayNumber)
    }

    func setNonPhotoFilter() {
        self.interactor.setNonPhotoFilter()
    }

    func tapDeleteIcon() {
        self.interactor.tapDeleteIcon()
    }

    func tappedDeletePositiveButton() {
        self.interactor.tappedDeletePositiveButton()
    }
    
    func tapSaveIcon() {
        self.interactor.tapSaveIcon()
    }

    func tapSaveButton(_ drawingView: UIView) {
        self.interactor.tapSaveButton(drawingView)
    }
    
    func tapShareIcon() {
        self.interactor.tapShareIcon()
    }

    func tappedTwitterShareButton(_ drawingView: UIView) {
        self.interactor.tappedTwitterShareButton(drawingView)
    }

    func tappedFacebookShareButton(_ drawingView: UIView) {
        self.interactor.tappedFacebookShareButton(drawingView)
    }

    func tappedLineShareButton(_ drawingView: UIView) {
        self.interactor.tappedLineShareButton(drawingView)
    }
}

extension CanvasPresenter: CanvasInteractorOutput {
    func setDrawingMode(_ drawTool: DoodleToolType) {
        self.view.setDrawingMode(drawTool)
    }
    
    func showPenSettingView() {
        self.view.showPenSettingView()
    }

    func setPenState(_ lineWidth: Float, lineAlpha: Float) {
        self.view.setPenState(lineWidth, lineAlpha: lineAlpha)
    }
    
    func showEraserSettingView() {
        self.view.showEraserSettingView()
    }

    func setEraserState(_ lineWidthEraser: Float) {
        self.view.setEraserState(lineWidthEraser)
    }

    func undo() {
        self.view.undo()
    }
    
    func redo() {
        self.view.redo()
    }
    
    func showStampView(_ canvasIcon: CanvasIconList?) {
        self.wireframe.canvasIconList = canvasIcon
        self.wireframe.presentStampInterfaceForCanvas()
    }
    
    func showPenColorSettingView() {
        self.view.showPenColorSettingView()
    }

    func setPenColorState(_ penColor: UIColor) {
        self.view.setPenColorState(penColor)
    }
    
    func showPhotoFilterView(_ loadImage: UIImage, canvasIcon: CanvasIconList, filtersArrayNumber: Int?) {
        self.wireframe.loadImage = loadImage
        self.wireframe.canvasIconList = canvasIcon
        self.wireframe.filtersArrayNumber = filtersArrayNumber
        self.wireframe.presentPhotoFilterInterfaceForCanvas()
    }

    func changeCanvsPhotoImage(_ filtersArrayNumber: Int) {
        self.view.changeCanvasPhotoImage(filtersArrayNumber)
    }

    func nonChangeCanvasPhotoImage() {
        self.view.nonChangeCanvasPhotoImage()
    }
    
    func showDeleteConfirmView() {
        self.view.showDeleteConfirmView()
    }
    
    func deleteCanvas() {
        self.view.deleteCanvas()
    }
    
    func showSaveConfirmView() {
        self.view.showSaveConfirmView()
    }

    func closeSaveDialog() {
        self.view.closeSaveDialog()
    }
    
    func showShareConfirmView() {
        self.view.showShareConfirmView()
    }

    func showTwitterView(_ composeView: SLComposeViewController) {
        self.view.showTwitterView(composeView)
    }

    func showFacebookView(_ composeView: SLComposeViewController) {
        self.view.showFacebookView(composeView)
    }

    func showLine(_ urlString: String) {
        self.view.showLine(urlString)
    }
}
