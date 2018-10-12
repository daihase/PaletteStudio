//
//  PhotoFilterViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/25.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol PhotoFilterViewControllerDelegate {
    func setPhotoFilter(_ filtersArrayNumber: Int)
    func setNonPhotoFilter()
}

class PhotoFilterViewController: BaseViewController, PhotoFilterViewInterface {
    var presenter: PhotoFilterModuleInterface!
    var loadImage: UIImage!
    var filterButton: UIButton?
    var filterButtonImage: UIImageView?
    var resizeLoadImage: UIImage!
    var delegate: PhotoFilterViewControllerDelegate!
    let navigationTitle = "Filter"
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var scrollView: PhotoFilterScrollView!
    var filterButtonTag = 0
    var catTag = 0
    var choosenCategory = 0
    var filtersArrayNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        self.configure()
        self.setupFiltersThumbnail()
        self.setupLoadImageFilter()
        
        NVActivityIndicatorViewManager.sharedInstance.stopLoadingIndicator()
    }
    
    private func configure() {
        self.view.backgroundColor = PSColor.canvasBackgroundColor()
        self.scrollView.Delegate = self
        self.originalImage.image = self.loadImage
        let copyLoadImage = self.loadImage.copy() as? UIImage
        self.resizeLoadImage = copyLoadImage!.resize(sourceImage: copyLoadImage!, scaledToWidth: 100, scaledToHeight: 100)
        self.scrollView.indicatorStyle = UIScrollViewIndicatorStyle.white
    }
    
    private func configNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = navigationTitle.localized()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(tapCancelButton(sender:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(tapDoneButton(sender:)))
        self.navigationItem.setLeftBarButton(cancelButton, animated: true)
        self.navigationItem.setRightBarButton(doneButton, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    
    func tapCancelButton(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tapDoneButton(sender: UIBarButtonItem) {
        if let number = self.filtersArrayNumber {
            if number == 0 {
                self.delegate.setNonPhotoFilter()
            } else {
                self.delegate.setPhotoFilter(self.filtersArrayNumber!)
            }
        }
        self.dismiss(animated: true, completion: {(_) -> Void in})
    }
    
    func setupFiltersThumbnail() {
        var xCoord: CGFloat = 20
        let yCoord: CGFloat = 20
        let buttonWidth:CGFloat = 100
        let buttonHeight: CGFloat = 100
        let gapBetweenButtons: CGFloat = 10
        var filtersCount = 0
        
        for i in 0 ..< filtersArray.count {
            filtersCount = i
            self.filterButtonTag = filtersCount
            let filterNameStr = "\(filterNamesArray[filtersCount])"
            self.filterButtonImage = UIImageView(frame: CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight))
            self.filterButtonImage?.tag = self.filterButtonTag
            self.filterButtonImage?.image = self.resizeLoadImage
            self.filterButtonImage?.contentMode = UIViewContentMode.scaleAspectFill
            self.filterButtonImage?.clipsToBounds = true
            self.filterButtonImage?.isUserInteractionEnabled = true
            let filterLabel = AttributeLabel(frame: CGRect(x: 0, y: self.filterButtonImage!.frame.size.height - 20, width: buttonWidth, height: 20))
            filterLabel.minFontSize = 10
            filterLabel.backgroundColor = PSColor.companyColor()
            filterLabel.textColor = UIColor.white
            filterLabel.textAlignment = .center
            filterLabel.fontName = DoodleFont.constants.roundedMplusName
            filterLabel.setAttributeText(text: filterNameStr.localized())
            self.filterButtonImage?.addSubview(filterLabel)
            
            xCoord +=  buttonWidth + gapBetweenButtons

            self.scrollView.addSubview(self.filterButtonImage!)
            self.setFilterToButtonImage(self.filterButtonImage!)
        }
        
        self.scrollView.contentSize = CGSize(width: buttonWidth * CGFloat(filtersCount+6), height: yCoord)
    }
    
    func setupLoadImageFilter() {
        if let filterNumber = self.filtersArrayNumber {
            self.originalImage.isHidden = true
            self.filterImage.image = originalImage.image
            self.filterImage.image = PhotoFilterManager.setPhotoFilter(number: filterNumber, targetImageView: self.filterImage)
        }
    }
    
    func filterButtonImageTapped(tagNumber: Int) {
        self.originalImage.isHidden = false
        self.filterImage.image = originalImage.image
        
        if tagNumber == 0 {
            self.filterImage.image = originalImage.image
        } else {
            self.originalImage.isHidden = true
            self.filterImage.image =  PhotoFilterManager.setPhotoFilter(number: tagNumber, targetImageView: self.filterImage)
        }

        self.filtersArrayNumber = tagNumber
    }
    
    func setFilterToButtonImage(_ filterButtonImage: UIImageView) {
        if filterButtonImage.tag == 0 {
            self.filterButtonImage?.image = self.loadImage
        } else {
            self.filterButtonImage?.image =  PhotoFilterManager.setPhotoFilter(number: filterButtonImage.tag, targetImageView: filterButtonImage)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PhotoFilterViewController: PhotoFilterScrollViewDelegate {
    func tapFilterButtonImage(touchNumber: Int) {
        self.filterButtonImageTapped(tagNumber: touchNumber)
    }
}
