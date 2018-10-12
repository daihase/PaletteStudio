//
//  CanvasInteractorIO.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/08.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import Social

protocol CanvasInteractorInput {
    func tapPenIcon()
    func tappedPenPositiveButton(_ lineWidth: Float, lineAlpha: Float)
    func changePenMode()
    func tapEraserIcon()
    func changeEraserMode()
    func tappedEraserPositiveButton(_ lineWidth: Float)
    func tapUndoIcon()
    func tapRedoIcon()
    func tapStampIcon(_ canvasIcon: CanvasIconList?)
    func changeStampMode()
    func tapPenColorIcon()
    func tapPhotoFilterIcon(_ image: UIImage, canvasIcon: CanvasIconList, filtersArrayNumber: Int?)
    func setPhotoFilter(_ filtersArrayNumber: Int)
    func setNonPhotoFilter()
    func tapDeleteIcon()
    func tappedDeletePositiveButton()
    func tapSaveIcon()
    func tapSaveButton(_ view: UIView)
    func tapShareIcon()
    func tappedTwitterShareButton(_ view: UIView)
    func tappedFacebookShareButton(_ view: UIView)
    func tappedLineShareButton(_ view: UIView)
}

protocol CanvasInteractorOutput {
    func setDrawingMode(_ drawTool: DoodleToolType)
    func showPenSettingView()
    func setPenColorState(_ penColor: UIColor)
    func setPenState(_ lineWidth: Float, lineAlpha: Float)
    func showEraserSettingView()
    func setEraserState(_ lineWidth: Float)
    func showStampView(_ canvasIcon: CanvasIconList?)
    func undo()
    func redo()
    func showPenColorSettingView()
    func showPhotoFilterView(_ loadImage: UIImage, canvasIcon: CanvasIconList, filtersArrayNumber: Int?)
    func changeCanvsPhotoImage(_ filtersArrayNumber: Int)
    func nonChangeCanvasPhotoImage()
    func showDeleteConfirmView()
    func deleteCanvas()
    func showSaveConfirmView()
    func closeSaveDialog()
    func showShareConfirmView()
    func showTwitterView(_ view: SLComposeViewController)
    func showFacebookView(_ view: SLComposeViewController)
    func showLine(_ urlString: String)
}
