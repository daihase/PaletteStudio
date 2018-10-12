//
//  CanvusIconList.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/03/09.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import LSDialogViewController

// 押したアイコンボタンを判定するためのEnum.
enum IconButtonType: Int {
    case pen = 1,
    eraser,
    stamp
}

class CanvasIconList: UIView {
    var delegate: CanvasIconListInterface?
    var presentView: UIView?
    var drawingView: DoodleDrawingView?
    @IBOutlet weak var eraserButton: UIButton!
    @IBOutlet weak var penButton: UIButton!
    @IBOutlet weak var stampButton: UIButton!
    
    class func instanceFromNib(_ delegate:CanvasIconListInterface?, presentView: UIView, drawingView: DoodleDrawingView) -> CanvasIconList {
        let canvasIconList : CanvasIconList = UINib(
            nibName:"CanvasIconList",
            bundle:Bundle.main
            ).instantiate(withOwner: self, options: nil)[0] as! CanvasIconList
        
        canvasIconList.delegate = delegate
        canvasIconList.presentView = presentView
        canvasIconList.drawingView = drawingView
        
        return canvasIconList
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.penButton.tag = IconButtonType.pen.rawValue
        self.eraserButton.tag = IconButtonType.eraser.rawValue
        self.penButton.setImage(UIImage(named: "PenHover"), for: UIControlState())
    }
    
    @IBAction func tapPenButton(_ sender: AnyObject) {
            self.changeDrawingMode(sender)
    }
    
    @IBAction func tapEraserButton(_ sender: AnyObject) {
            self.changeDrawingMode(sender)
    }
    
    @IBAction func tapStampButton(_ sender: AnyObject) {
        self.delegate?.tappedStampIcon()
    }
    
    @IBAction func tapUndoButton(_ sender: AnyObject) {
        self.delegate?.tappedUndoIcon()
    }
    
    @IBAction func tapRedoButton(_ sender: AnyObject) {
        self.delegate?.tappedRedoIcon()
    }
    
    @IBAction func tapPenColorButton(_ sender: AnyObject) {
        self.delegate?.tappedPenColorSettingView()
    }
    
    @IBAction func tapPhotoFilterButton(_ sender: AnyObject) {
        self.delegate?.tappedPhotoFilterIcon()
    }
    
    @IBAction func tapDeleteButton(_ sender: AnyObject) {
        self.delegate?.tappedDeleteConfirmView()
    }
    
    @IBAction func tapSaveButton(_ sender: AnyObject) {
     self.delegate?.tappedSaveConfirmView()
    }
    
    @IBAction func tapShareButton(_ sender: AnyObject) {
        self.delegate?.tappedShareConfirmView()
    }
    
    func changeDrawingMode(_ sender: AnyObject) {
        let modeType = sender.tag
        
        switch self.drawingView!.drawTool {
        case .doodleToolTypePen:
            if modeType == IconButtonType.pen.rawValue {
                self.delegate?.tappedPenSettingView()
            } else {
                self.eraserButton.setImage(UIImage(named: "EraserHover"), for: UIControlState())
                self.penButton.setImage(UIImage(named: "Pen"), for: UIControlState())
                self.delegate?.changeEraserMode()
            }
            
        case .doodleToolTypeEraser:
            if modeType == IconButtonType.eraser.rawValue {
                self.delegate?.tappedEraserSettingView()
            } else {
                self.penButton.setImage(UIImage(named: "PenHover"), for: UIControlState())
                self.eraserButton.setImage(UIImage(named: "Eraser"), for: UIControlState())
                self.stampButton.setImage(UIImage(named: "Stamp"), for: UIControlState())
                self.delegate?.changePenMode()
            }
        case .doodleToolTypeStamp:
            if modeType == IconButtonType.pen.rawValue {
                self.penButton.setImage(UIImage(named: "PenHover"), for: UIControlState())
                self.eraserButton.setImage(UIImage(named: "Eraser"), for: UIControlState())
                self.stampButton.setImage(UIImage(named: "Stamp"), for: UIControlState())
                self.delegate?.changePenMode()
            } else {
                self.eraserButton.setImage(UIImage(named: "EraserHover"), for: UIControlState())
                self.penButton.setImage(UIImage(named: "Pen"), for: UIControlState())
                self.stampButton.setImage(UIImage(named: "Stamp"), for: UIControlState())
                self.delegate?.changeEraserMode()
            }
        default:
            break
        }
    }
}

extension CanvasIconList: DeleteConfirmViewControllerDelegate {
    func tappedDeletePositiveButton() {
        self.delegate?.tappedDeletePositiveButton()
    }
    
    func tappedDeleteNegativeButton() {
        self.delegate?.closeDialogView()
    }
}

extension CanvasIconList: SaveConfirmViewControllerDelegate {
    func tappedSaveButton() {
        self.delegate?.tappedSaveButton()
    }
    
    func tappedSaveReturnButton() {
        self.delegate?.closeDialogView()
    }
}

extension CanvasIconList: PenSettingViewControllerDelegate {
    func tappedPenPositiveButton(_ lineWidth: Float, lineAlpha: Float, penType: PenType) {
        self.delegate?.tappedPenPositiveButton(lineWidth, lineAlpha: lineAlpha, penType: penType)
    }
    
    func tappedPenNegativeButton() {
        self.delegate?.closeDialogView()
    }
}

extension CanvasIconList: EraserSettingViewControllerDelegate {
    func tappedEraserPositiveButton(_ lineWidth: Float) {
        self.delegate?.tappedEraserPositiveButton(lineWidth)
    }
    
    func tappedEraserNegativeButton() {
        self.delegate?.closeDialogView()
    }
}

extension CanvasIconList: PenColorPickerViewControllerDelegate {
    func tappedPenColorPickerPositiveButton(_ colorPicker: DoodleColorPicker) {
        self.delegate?.tappedPenColorPickerPositiveButton(colorPicker)
    }
    
    func tappedPenColorPickerNegativeButton() {
        self.delegate?.closeDialogView()
    }
}

extension CanvasIconList: StampContainerViewControllerDelegate {
    func tappedStampIcon(_ stampImage: UIImage) {
        
        self.drawingView?.stampImage = stampImage
        self.stampButton.tag = IconButtonType.stamp.rawValue
        self.penButton.setImage(UIImage(named: "Pen"), for: UIControlState())
        self.eraserButton.setImage(UIImage(named: "Eraser"), for:
            UIControlState())
        self.stampButton.setImage(UIImage(named: "StampHover"), for: UIControlState())
        self.delegate?.changeStampMode()
    }
}

extension CanvasIconList: PhotoFilterViewControllerDelegate {
    func setPhotoFilter(_ filtersArrayNumber: Int) {
        self.delegate?.setPhotoFilter(filtersArrayNumber)
    }
    
    func setNonPhotoFilter() {
        self.delegate?.setNonPhotoFilter()
    }
}

extension CanvasIconList: ShareConfirmViewControllerDelegate {
    func tappedTwitterShareButton() {
        self.delegate?.tappedTwitterShareButton()
    }
    
    func tappedFacebookShareButton() {
        self.delegate?.tappedFacebookShareButton()
    }

    func tappedLineShareButton() {
        self.delegate?.tappedLineShareButton()
    }
    
    func tappedShareReturnButton() {
        self.delegate?.closeDialogView()
    }
}
