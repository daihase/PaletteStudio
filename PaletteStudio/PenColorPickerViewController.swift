//
//  PenColorPickerViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/06/21.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol PenColorPickerViewControllerDelegate {
    func tappedPenColorPickerPositiveButton(_ colorPicker: DoodleColorPicker)
    func tappedPenColorPickerNegativeButton()
}

class PenColorPickerViewController: BaseViewController {
    @IBOutlet weak var positiveLabel: AttributeLabel!
    @IBOutlet weak var subDialogArea: UIImageView!
    @IBOutlet weak var negativeLabel: AttributeLabel!
    @IBOutlet weak var doodleColorPicker: DoodleColorPicker!
    var selectedColor: UIColor!
    var delegate: PenColorPickerViewControllerDelegate?
    let okString = "OK"
    let returnString = "Return"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupLabel()
    }
    
    override func viewDidLayoutSubviews() {
        self.doodleColorPicker.setColorPicker(selectedColor)
    }
    
    func setupLabel() {
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
        self.view.bounds.size.width = UIScreen.main.bounds.width
        if let hex = PSUserDefault.sharedInstance.valueFromUserDefault(key: PSUserDefault.Keys.penColorHexString) as? String {
            self.selectedColor = UIColor(hexString: hex, alpha: 1)
        } else {
            self.selectedColor = UIColor.red
        }
        
        self.view.bounds.size.width = UIScreen.main.bounds.width
    }

    @IBAction func tapPositiveButton(_ sender: AnyObject) {
        self.delegate?.tappedPenColorPickerPositiveButton(self.doodleColorPicker)
    }
    
    @IBAction func tapNegativeButton(_ sender: AnyObject) {
        self.delegate?.tappedPenColorPickerNegativeButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
