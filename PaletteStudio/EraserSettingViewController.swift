//
//  EraserSettingViewController.swift
//  DoodleMaker
//
//  Created by daihase on 2016/05/24.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol EraserSettingViewControllerDelegate {
    func tappedEraserPositiveButton(_ lineWidth: Float)
    func tappedEraserNegativeButton()
}

class EraserSettingViewController: BaseViewController {
    @IBOutlet weak var positiveLabel: AttributeLabel!
    @IBOutlet weak var negativeLabel: AttributeLabel!
    @IBOutlet weak var thicknessSlider: CustomSlider!
    @IBOutlet weak var subDialogArea: UIImageView!
    @IBOutlet weak var doodleDrawingSubView: DoodleDrawingSubView!
    var delegate: EraserSettingViewControllerDelegate?
    var drawingView: DoodleDrawingView?
    let okString = "OK"
    let returnString = "Return"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLabel()
        self.setupView()
    }

    fileprivate func setupLabel() {
        self.doodleDrawingSubView.lineWidthEraser = (self.drawingView?.lineWidthEraser)!
        self.doodleDrawingSubView.drawTool = DoodleSubToolType.doodleSubToolTypeEraser
        self.positiveLabel.fontName = DoodleFont.constants.roundedMplusName
        self.negativeLabel.fontName = DoodleFont.constants.roundedMplusName
        self.positiveLabel.minFontSize = 16
        self.negativeLabel.minFontSize = 16
        self.positiveLabel.setAttributeText(text: self.okString.localized())
        self.negativeLabel.setAttributeText(text: self.returnString.localized())
    }
    
    fileprivate func setupView() {
        self.subDialogArea.layer.borderColor = PSColor.subDialogViewBorderColor().cgColor
        self.subDialogArea.layer.cornerRadius = 8
        self.subDialogArea.layer.masksToBounds = true
        self.subDialogArea.layer.borderWidth = 3.5
        self.subDialogArea.backgroundColor = PSColor.subDialogViewBackgroundColor()
        self.thicknessSlider.value = Float((self.drawingView?.lineWidthEraser)!)
        self.thicknessSlider.markColor = UIColor(white:0, alpha:0.1)
        self.thicknessSlider.markPositions = [10,20,30,40,50,60,70,80,90,100]
        self.thicknessSlider.markWidth = 1.0;
        self.thicknessSlider.selectedBarColor = UIColor(red: 226/255.0, green: 154/255.0, blue: 0/255.0, alpha:1.0)
        self.thicknessSlider.unselectedBarColor = UIColor.darkGray
        self.thicknessSlider.addTarget(self, action: #selector(EraserSettingViewController.thicknessSliderChanged(_:)), for: UIControlEvents.valueChanged)
        self.view.bounds.size.width = UIScreen.main.bounds.width
    }
    
    func thicknessSliderChanged(_ sender: UISlider) {
        self.doodleDrawingSubView.setEraserThicknessParameter(sender.value)
    }
    
    @IBAction func tapPositiveButton(_ sender: AnyObject) {
        self.delegate?.tappedEraserPositiveButton(self.thicknessSlider.value)
    }
    
    @IBAction func tapNegativeButton(_ sender: AnyObject) {
        self.delegate?.tappedEraserNegativeButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
