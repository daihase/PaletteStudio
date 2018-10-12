//
//  CanvasModuleViewInterface.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/15.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol CanvasModuleInterface: class {
    func tapPenIcon()
    func changePenMode()
    func tappedPenPositiveButton(_ lineWidth: Float, lineAlpha: Float)
    func tapEraserIcon()
    func changeEraserMode()
    func tappedEraserPositiveButton(_ lineWidthEraser: Float)
    func tapUndoIcon()
    func tapRedoIcon()
    func tapStampIcon(_ canvasIcon: CanvasIconList?)
    func changeStampMode()
    func tapPenColorIcon()
    func tappedPenColorPickerPositiveButton(_ colorPicker: DoodleColorPicker)
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
