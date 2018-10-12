//
//  CanvasViewInterface.swift
//  DoodleMaker
//
//  Created by daihase on 2016/09/15.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import Social

protocol CanvasViewInterface: class {
    func setDrawingMode(_ drawTool: DoodleToolType)
    func showPenSettingView()
    func setPenState(_ lineWidth: Float, lineAlpha: Float)
    func showEraserSettingView()
    func setEraserState(_ lineWidth: Float)
    func showStampView()
    func undo()
    func redo()
    func showPenColorSettingView()
    func setPenColorState(_ penColor: UIColor)
    func changeCanvasPhotoImage(_ filtersArrayNumber: Int)
    func nonChangeCanvasPhotoImage()
    func showDeleteConfirmView()
    func deleteCanvas()
    func closeSaveDialog()
    func showSaveConfirmView()
    func showShareConfirmView()
    func showTwitterView(_ view: SLComposeViewController)
    func showFacebookView(_ view: SLComposeViewController)
    func showLine(_ urlString: String)
}
