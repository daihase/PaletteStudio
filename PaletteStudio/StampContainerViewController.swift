//
//  StampViewController.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/05.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol StampContainerViewControllerDelegate {
    func tappedStampIcon(_ stampImage: UIImage)
}

class StampContainerViewController: BaseViewController, StampIconViewControllerDelegate {
    var stampHandler: StampPresenter?
    var stampIconViewController: StampIconViewController?
    var stampPageViewController: StampPageViewController?
    var delegate: StampContainerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapBackButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? StampIconViewController , segue.identifier == "embedStampIconViewController" {
            stampIconViewController = vc
            stampIconViewController?.delegate = self
        } else if let vc = segue.destination as? StampPageViewController , segue.identifier == "embedStampPageViewController" {
            stampPageViewController = vc
            stampPageViewController?.stampPageViewControllerDelegate = self
            stampPageViewController?.stampHandler = self.stampHandler
        }
    }
    
    func stampIconViewController(_ viewController: StampIconViewController, at index: Int) {
        var currentIndex = 0
        
        if let currentPageVC = stampPageViewController?.viewControllers?.first as?StampNormalViewController {
            currentIndex = currentPageVC.index
        } else if let currentPageVC = stampPageViewController?.viewControllers?.first as? StampFontViewController {
            currentIndex = currentPageVC.index
        } else if let currentPageVC = stampPageViewController?.viewControllers?.first as? StampAnimalViewController {
            currentIndex = currentPageVC.index
        } else if let currentPageVC = stampPageViewController?.viewControllers?.first as? StampVehicleViewController {
            currentIndex = currentPageVC.index
        } else if let currentPageVC = stampPageViewController?.viewControllers?.first as? StampFaceViewController {
            currentIndex = currentPageVC.index
        }
        
        if currentIndex == index {
            return
        }
        
        let direction :UIPageViewControllerNavigationDirection = currentIndex < index ? .forward : .reverse
        
        switch index {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "StampNormalViewController") as! StampNormalViewController
            vc.stampHandler = self.stampHandler
            stampPageViewController?.setViewControllers([vc], direction: direction, animated: true) { _ in }
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "StampFontViewController") as! StampFontViewController
            stampPageViewController?.setViewControllers([vc], direction: direction, animated: true) { _ in }
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "StampAnimalViewController") as! StampAnimalViewController
            stampPageViewController?.setViewControllers([vc], direction: direction, animated: true) { _ in }
        case 3:
            let vc = storyboard?.instantiateViewController(withIdentifier: "StampVehicleViewController") as! StampVehicleViewController
            stampPageViewController?.setViewControllers([vc], direction: direction, animated: true) { _ in }
        case 4:
            let vc = storyboard?.instantiateViewController(withIdentifier: "StampFaceViewController") as! StampFaceViewController
            stampPageViewController?.setViewControllers([vc], direction: direction, animated: true) { _ in }
        default:
            return
        }
    }
}


extension StampContainerViewController: StampViewInterface {
    func closeStampDialogView(_ stampImage: UIImage) {
        self.dismiss(animated: true, completion: {})
        self.delegate?.tappedStampIcon(stampImage)
    }
}

extension StampContainerViewController: StampPageViewControllerDelegate {
    func scrolledPageView(_ index: IndexPath) {
        self.stampIconViewController?.focusCell(index)
    }
}
