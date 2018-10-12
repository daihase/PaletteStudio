//
//  CanvasViewInterface.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/08.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//
// ****** ViewControllerが継承するView周りのProtocol. ******

import UIKit

protocol CanvasIconListInterface {
    func tappedPenSettingView()
    func tappedPenPositiveButton(_ lineWidth: Float, lineAlpha: Float, penType: PenType)
    func closeDialogView()
    func changePenMode()
    func tappedEraserSettingView()
    func changeEraserMode()
    func tappedEraserPositiveButton(_ lineWidth: Float)
    func tappedUndoIcon()
    func tappedRedoIcon()
    func tappedStampIcon()
    func changeStampMode()
    func tappedPenColorSettingView()
    func tappedPenColorPickerPositiveButton(_ colorPicker: DoodleColorPicker)
    func tappedPhotoFilterIcon()
    func setPhotoFilter(_ filtersArrayNumber: Int)
    func setNonPhotoFilter()
    func tappedDeleteConfirmView()
    func tappedDeletePositiveButton()
    func tappedSaveConfirmView()
    func tappedSaveButton()
    func tappedShareConfirmView()
    func tappedTwitterShareButton()
    func tappedFacebookShareButton()
    func tappedLineShareButton()
}
