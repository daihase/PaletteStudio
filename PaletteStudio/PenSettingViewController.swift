//
//  PenSettingViewController.swift
//  DoodleMaker
//
//  Created by daihase on 2016/05/24.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol PenSettingViewControllerDelegate {
    func tappedPenPositiveButton(_ lineWidth: Float, lineAlpha: Float, penType: PenType)
    func tappedPenNegativeButton()
}

class PenSettingViewController: BaseViewController {
    @IBOutlet weak var doodleDrawingSubView: DoodleDrawingSubView!
    @IBOutlet weak var positiveLabel: AttributeLabel!
    @IBOutlet weak var negativeLabel: AttributeLabel!
    @IBOutlet weak var thicknessSlider: CustomSlider!
    @IBOutlet weak var transparencySlider: CustomSlider!
    @IBOutlet weak var subDialogArea: UIImageView!
    @IBOutlet weak var penNormalImage: UIImageView!
    @IBOutlet weak var penBlurImage: UIImageView!
    @IBOutlet weak var penNeonImage: UIImageView!
    var delegate: PenSettingViewControllerDelegate?
    var drawingView: DoodleDrawingView?
    var penType: PenType!
    let penNormalImageTag = 1
    let penBlurImageTag = 2
    let penNeonImageTag = 3
    let okString = "OK"
    let returnString = "Return"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabel()
        self.setupView()
    }
    
    fileprivate func setupLabel() {
        self.doodleDrawingSubView.lineWidth = (self.drawingView?.lineWidth)!
        self.doodleDrawingSubView.lineAlpha = (self.drawingView?.lineAlpha)!
        self.doodleDrawingSubView.drawTool = DoodleSubToolType.doodleSubToolTypePen
        self.positiveLabel.fontName = DoodleFont.constants.roundedMplusName
        self.negativeLabel.fontName = DoodleFont.constants.roundedMplusName
        self.positiveLabel.minFontSize = 16
        self.negativeLabel.minFontSize = 16
        self.positiveLabel.setAttributeText(text: self.okString.localized())
        self.negativeLabel.setAttributeText(text: self.returnString.localized())
    }
    
    fileprivate func setupView() {
        if let type = self.penType {
            self.changePenType(type: type)
        }

        self.penNormalImage.isUserInteractionEnabled = true
        self.penNormalImage.tag = penNormalImageTag
        self.penBlurImage.isUserInteractionEnabled = true
        self.penBlurImage.tag = penBlurImageTag
        self.penNeonImage.isUserInteractionEnabled = true
        self.penNeonImage.tag = penNeonImageTag
        self.subDialogArea.layer.borderColor = PSColor.subDialogViewBorderColor().cgColor
        self.subDialogArea.layer.cornerRadius = 8
        self.subDialogArea.layer.masksToBounds = true
        self.subDialogArea.layer.borderWidth = 3.5
        self.subDialogArea.backgroundColor = PSColor.subDialogViewBackgroundColor()
        self.thicknessSlider.value = Float((self.drawingView?.lineWidth)!)
        self.thicknessSlider.markColor = UIColor(white:0, alpha:0.1)
        self.thicknessSlider.markPositions = [10,20,30,40,50,60,70,80,90,100]
        self.thicknessSlider.markWidth = 1.0;
        self.thicknessSlider.selectedBarColor = UIColor(red: 226/255.0, green: 154/255.0, blue: 0/255.0, alpha:1.0)
        self.thicknessSlider.unselectedBarColor = UIColor.darkGray
        self.thicknessSlider.addTarget(self, action: #selector(PenSettingViewController.thicknessSliderChanged(_:)), for: UIControlEvents.valueChanged)
        self.transparencySlider.value = Float((self.drawingView?.lineAlpha)!)
        self.transparencySlider.markColor = UIColor(white:0, alpha:0.1)
        self.transparencySlider.markPositions = [10,20,30,40,50,60,70,80,90,100]
        self.transparencySlider.markWidth = 1.0;
        self.transparencySlider.selectedBarColor = UIColor(red: 240/255.0, green: 164/255.0, blue: 0/255.0, alpha:1.0)
        self.transparencySlider.unselectedBarColor = UIColor.darkGray
        self.transparencySlider.addTarget(self, action: #selector(PenSettingViewController.transparencySliderChanged(_:)), for: UIControlEvents.valueChanged)
        
        self.view.bounds.size.width = UIScreen.main.bounds.width
    }
    
    func thicknessSliderChanged(_ sender: UISlider) {
        self.doodleDrawingSubView.setPenThicknessParameter(sender.value)
    }
    
    func transparencySliderChanged(_ sender: UISlider) {
        self.doodleDrawingSubView.setTransparencyParameter(sender.value)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            switch tag {
            case penNormalImageTag:
                self.penType = PenType.normal
            case penBlurImageTag:
                self.penType = PenType.blur
            case penNeonImageTag:
                self.penType = PenType.neon
            default:
                break
            }
        }
        self.changePenType(type: self.penType)
    }
    
    private func changePenType(type: PenType) {
        switch type {
        case .normal:
            self.penNormalImage.image = UIImage(named: "PenModeNormalHover")
            self.penBlurImage.image = UIImage(named: "PenModeBlur")
            self.penNeonImage.image = UIImage(named: "PenModeNeon")
            break
        case .blur:
            self.penNormalImage.image = UIImage(named: "PenModeNormal")
            self.penBlurImage.image = UIImage(named: "PenModeBlurHover")
            self.penNeonImage.image = UIImage(named: "PenModeNeon")
            break
        case .neon:
            self.penNormalImage.image = UIImage(named: "PenModeNormal")
            self.penBlurImage.image = UIImage(named: "PenModeBlur")
            self.penNeonImage.image = UIImage(named: "PenModeNeonHover")
            break
        }
    }
    
    @IBAction func tapPositiveButton(_ sender: AnyObject) {
        self.drawingView?.drawintPenType = self.penType
        self.delegate?.tappedPenPositiveButton(self.thicknessSlider.value, lineAlpha: self.transparencySlider.value, penType: self.penType)
    }
    
    @IBAction func tapNegativeButton(_ sender: AnyObject) {
        self.delegate?.tappedPenNegativeButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
