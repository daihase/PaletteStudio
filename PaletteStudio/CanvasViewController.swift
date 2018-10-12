//
//  CanvasViewController.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2015/09/30.
//  Copyright (c) 2015年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import Social
import LSDialogViewController
import Photos

class CanvasViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    var doodleDrawingView: DoodleDrawingView!
    var containerView: UIView!
    @IBOutlet weak var iconScrollView: UIScrollView!
    var toastView: CanvasZoomToastView!
    var presenter: CanvasModuleInterface!
    var iconList: CanvasIconList?
    var loadImage: UIImage!
    var canvasPhotoImage: UIImageView!
    var filtersArrayNumber: Int?
    var whiteMask: UIView!
    @IBOutlet weak var iconScrollViewheight: NSLayoutConstraint!
    var drawingPenType: PenType!
    let scrollViewTag: Int = 1
    var zoomNow: CGFloat = 1.0
    let zoomMin: CGFloat = 1.0
    let zoomMax: CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
        self.setNavigationBar()
        self.setupScrollView()
        self.createUI()
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false
        self.slideMenuController()?.removeLeftGestures()

        NVActivityIndicatorViewManager.sharedInstance.startLoadingIndicator(view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let viewControllers = self.navigationController?.viewControllers {
            var existsSelfInViewControllers = true
            for viewController in viewControllers {
                if viewController == self {
                    existsSelfInViewControllers = false

                    break
                }
            }
            
            if existsSelfInViewControllers {
                self.slideMenuController()?.addLeftGestures()
            }
        }
        super.viewWillDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if self.whiteMask.isDescendant(of: self.scrollView) {
            NVActivityIndicatorViewManager.sharedInstance.stopLoadingIndicator()
            self.whiteMask.backgroundColor = UIColor.white
            UIView.animate(withDuration: 0.8, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
                self.whiteMask.alpha = 0.0
                
                }, completion: { (finished) -> Void in
                    self.whiteMask.removeFromSuperview()
            })
        }
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "Palette Studio"
    }
    
    private func configure() {
        self.view.backgroundColor = PSColor.canvasBackgroundColor()
        self.containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.loadImage.size.width, height: self.loadImage.size.height))
        self.canvasPhotoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.loadImage.size.width, height: self.loadImage.size.height))
        self.canvasPhotoImage.image = self.loadImage
        self.doodleDrawingView = DoodleDrawingView(frame: CGRect(x: 0, y: 0, width: self.loadImage.size.width, height: self.loadImage.size.height))
        self.doodleDrawingView.backgroundColor = UIColor.white
        self.containerView.addSubview(self.canvasPhotoImage)
        self.containerView.addSubview(self.doodleDrawingView)
        self.scrollView.addSubview(self.containerView)
        self.containerView.center.x = self.view.bounds.size.width / 2
        self.containerView.center.y = (self.view.bounds.size.height / 2) - (self.navigationController?.navigationBar.frame.height)!
        self.whiteMask = UIView(frame: CGRect(x: 0, y: 0, width: self.loadImage.size.width, height: self.loadImage.size.height))
        whiteMask.backgroundColor = PSColor.canvasBackgroundColor()
        self.scrollView.addSubview(self.whiteMask)
        whiteMask.center.x = self.view.bounds.size.width / 2
        whiteMask.center.y = (self.view.bounds.size.height / 2) - (self.navigationController?.navigationBar.frame.height)!
        self.drawingPenType = PenType.normal
        self.doodleDrawingView.drawintPenType = self.drawingPenType
        
        if let penWidth = PSUserDefault.sharedInstance.floatValueFromUserDefault(PSUserDefault.Keys.penThickness) {
            self.doodleDrawingView.lineWidth = CGFloat(penWidth)
        }

        if let eraserWidth = PSUserDefault.sharedInstance.floatValueFromUserDefault(PSUserDefault.Keys.eraserThickness) {
            self.doodleDrawingView.lineWidthEraser = CGFloat(eraserWidth)
        }

        if let transparency = PSUserDefault.sharedInstance.floatValueFromUserDefault(PSUserDefault.Keys.penTransparency) {
            self.doodleDrawingView.lineAlpha = CGFloat(transparency)
        }

        if let penColorHexString = PSUserDefault.sharedInstance.valueFromUserDefault(key: PSUserDefault.Keys.penColorHexString) as? String{
            let penColor = UIColor(hexString: penColorHexString, alpha: 1)
            self.doodleDrawingView.lineColor = penColor
        }
    }
    

    func createUI() {
        iconList = CanvasIconList.instanceFromNib(self, presentView: self.view, drawingView: self.doodleDrawingView)
        self.iconScrollViewheight.constant = iconList!.frame.height
        self.view.layoutIfNeeded()
        iconScrollView.contentSize = iconList!.frame.size
        iconScrollView.addSubview(iconList!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CanvasViewController: UIScrollViewDelegate {
    func setupScrollView() {
        self.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal
        self.scrollView.bounces = false
        self.scrollView.minimumZoomScale = zoomMin
        self.scrollView.maximumZoomScale = zoomMax
        self.scrollView.tag = scrollViewTag
        self.scrollView.delegate = self
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.doodleDrawingView.pinch()
        self.toastView = CanvasZoomToastView.instanceFromNib()
        self.toastView.addToView(view: self.view)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if self.scrollView.tag == scrollViewTag {
            return self.containerView
        }else{
            return nil
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let zoomParamString = String(describing: scrollView.zoomScale * 100)
        let zoomParam = zoomParamString.substring(to: zoomParamString.index(zoomParamString.startIndex, offsetBy: 5)) + "%"
        self.toastView.setZoomParam(zoomParamString: zoomParam)
        let view = scrollView.subviews[0] as UIView
        var zoomViewRect = view.frame
        zoomViewRect.origin = CGPoint.zero
        let scrollSize = CGSize(width: scrollView.bounds.size.width - scrollView.contentInset.left - scrollView.contentInset.right, height: scrollView.bounds.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom)
        
        if zoomViewRect.size.width < scrollSize.width {
            zoomViewRect.origin.x = (scrollSize.width - zoomViewRect.size.width) / 2.0
        }
        
        if zoomViewRect.size.height < scrollSize.height {
        zoomViewRect.origin.y = (scrollSize.height - zoomViewRect.size.height) / 2.0
        }

        view.frame = zoomViewRect
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.toastView.removeToView()
    }
}

extension CanvasViewController: CanvasIconListInterface {
    func closeDialogView() {
        self.dismissDialogViewController(LSAnimationPattern.zoomInOut)
    }
    
    func tappedPenSettingView() {
        self.presenter.tapPenIcon()
    }

    func changePenMode() {
        self.presenter.changePenMode()
    }

    func tappedPenPositiveButton(_ lineWidth: Float, lineAlpha: Float, penType: PenType) {
        self.drawingPenType = penType
        self.presenter.tappedPenPositiveButton(lineWidth, lineAlpha: lineAlpha)
    }

    func tappedEraserSettingView() {
        self.presenter.tapEraserIcon()
    }

    func changeEraserMode() {
        self.presenter.changeEraserMode()
    }

    func tappedEraserPositiveButton(_ lineWidth: Float) {
        self.presenter.tappedEraserPositiveButton(lineWidth)
    }

    func tappedUndoIcon() {
        self.presenter.tapUndoIcon()
    }

    func tappedRedoIcon() {
        self.presenter.tapRedoIcon()
    }

    func tappedStampIcon() {
        self.presenter.tapStampIcon(self.iconList)
    }

    func changeStampMode() {
        self.presenter.changeStampMode()
    }

    func tappedPenColorSettingView() {
        self.presenter.tapPenColorIcon()
    }

    func tappedPenColorPickerPositiveButton(_ colorPicker: DoodleColorPicker) {
        self.presenter.tappedPenColorPickerPositiveButton(colorPicker)
    }

    func tappedPhotoFilterIcon() {
        NVActivityIndicatorViewManager.sharedInstance.startLoadingIndicator(view: self.scrollView)
        self.presenter.tapPhotoFilterIcon(self.loadImage, canvasIcon: self.iconList!, filtersArrayNumber: self.filtersArrayNumber)
    }

    func setPhotoFilter(_ filtersArrayNumber: Int) {
        self.filtersArrayNumber = filtersArrayNumber
        self.presenter.setPhotoFilter(self.filtersArrayNumber!)
    }

    func setNonPhotoFilter() {
        self.presenter.setNonPhotoFilter()
    }
    
    func tappedDeleteConfirmView() {
        self.presenter.tapDeleteIcon()
    }

    func tappedDeletePositiveButton() {
        self.presenter.tappedDeletePositiveButton()
    }
    
    func tappedShareConfirmView() {
        self.presenter.tapShareIcon()
    }

    func tappedTwitterShareButton() {
        self.presenter.tappedTwitterShareButton(self.containerView)
    }

    func tappedFacebookShareButton() {
        self.presenter.tappedFacebookShareButton(self.containerView)
    }

    func tappedLineShareButton() {
        self.presenter.tappedLineShareButton(self.containerView)
    }
    
    func tappedSaveConfirmView() {
        self.presenter.tapSaveIcon()
    }

    func tappedSaveButton() {
        self.scrollView.zoomScale = 1.0
        self.presenter.tapSaveButton(self.containerView)
    }
}

extension CanvasViewController: CanvasViewInterface {
    func setDrawingMode(_ drawTool: DoodleToolType) {
        self.doodleDrawingView.drawTool = drawTool
    }

    func showPenSettingView() {
        let penSettingViewController = PenSettingViewController(nibName: "PenSettingView", bundle: nil)
        penSettingViewController.drawingView = self.doodleDrawingView
        penSettingViewController.delegate = self.iconList
        penSettingViewController.penType = self.drawingPenType
        self.presentDialogViewController(penSettingViewController, animationPattern: .zoomInOut, dismissButtonEnabled: false, completion: {() -> Void in })
    }

    func setPenState(_ lineWidth: Float, lineAlpha: Float) {
        self.doodleDrawingView.lineWidth = CGFloat(lineWidth)
        self.doodleDrawingView.lineAlpha = CGFloat(lineAlpha)
        self.closeDialogView()
    }
    
    func showEraserSettingView() {
        let eraserSettingViewController = EraserSettingViewController(nibName: "EraserSettingView", bundle: nil)
        eraserSettingViewController.drawingView = self.doodleDrawingView
        eraserSettingViewController.delegate = self.iconList
        self.presentDialogViewController(eraserSettingViewController, animationPattern: .zoomInOut,  dismissButtonEnabled: false, completion: {() -> Void in })
    }

    func setEraserState(_ lineWidth: Float) {
        doodleDrawingView?.lineWidthEraser = CGFloat(lineWidth)
        self.closeDialogView()
    }
    
    func showStampView() {
        let presenter = StampPresenter()
        let interactor = StampInteractor()
        let stampContainerViewController = StoryboardBuilder.sharedInstance.stampContainerViewController()
        stampContainerViewController.stampHandler = presenter
        stampContainerViewController.delegate = iconList
        presenter.view = stampContainerViewController
        presenter.interactor = interactor
        interactor.output = presenter
        stampContainerViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(stampContainerViewController, animated: true, completion: nil)

    }
    
    func undo() {
        self.doodleDrawingView.undoLatestStep()
    }
    
    func redo() {
        self.doodleDrawingView.redoLatestStep()
    }

    func showPenColorSettingView() {
        let penColorPickerViewController = PenColorPickerViewController(nibName: "PenColorPickerView", bundle: nil)
        penColorPickerViewController.delegate = self.iconList
        self.presentDialogViewController(penColorPickerViewController, animationPattern: .zoomInOut, dismissButtonEnabled: false, completion: {() -> Void in })
    }

    func setPenColorState(_ penColor: UIColor) {
        self.doodleDrawingView?.lineColor = penColor
        self.closeDialogView()
    }
    
    func changeCanvasPhotoImage(_ filtersArrayNumber: Int) {
        self.canvasPhotoImage.image = self.loadImage
        self.canvasPhotoImage.image = PhotoFilterManager.setPhotoFilter(number: filtersArrayNumber, targetImageView: self.canvasPhotoImage)
    }
    
    func nonChangeCanvasPhotoImage() {
        self.canvasPhotoImage.image = self.loadImage
    }
    
    func showDeleteConfirmView() {
        let deleteConfirmViewController = DeleteConfirmViewController(nibName: "DeleteConfirmView", bundle: nil)
        deleteConfirmViewController.delegate = self.iconList
        self.presentDialogViewController(deleteConfirmViewController, animationPattern: .zoomInOut, dismissButtonEnabled: false, completion: {() -> Void in})
    }
    
    func deleteCanvas() {
        self.doodleDrawingView.clear()
        self.closeDialogView()
    }
    
    func showSaveConfirmView() {
        let saveConfirmViewController = SaveConfirmViewController(nibName: "SaveConfirmView", bundle: nil)
        saveConfirmViewController.delegate = self.iconList
        self.presentDialogViewController(saveConfirmViewController, animationPattern: .zoomInOut, dismissButtonEnabled: false, completion: {() -> Void in})
    }
    func closeSaveDialog() {
        self.closeDialogView()
    }
    
    func showShareConfirmView() {
        let shareConfirmViewController = ShareConfirmViewController(nibName: "ShareConfirmView", bundle: nil)
        shareConfirmViewController.delegate =  self.iconList
        self.presentDialogViewController(shareConfirmViewController, animationPattern: .zoomInOut, dismissButtonEnabled: false, completion: {() -> Void in})
    }

    func showTwitterView(_ composeView: SLComposeViewController) {
        self.closeDialogView()
        self.present(composeView, animated: true, completion: nil)
    }

    func showFacebookView(_ composeView: SLComposeViewController) {
        self.closeDialogView()
        self.present(composeView, animated: true, completion: nil)
    }

    func showLine(_ urlString: String) {
        self.closeDialogView()
        UIApplication.shared.openURL(NSURL(string: urlString) as! URL)
    }
}
