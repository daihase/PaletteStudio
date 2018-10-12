//
//  StampPageViewController.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol StampPageViewControllerDelegate: class {
    func scrolledPageView(_ index: IndexPath)
}

class StampPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pages = [UIViewController]()
    weak var stampPageViewControllerDelegate: StampPageViewControllerDelegate?
    var stampHandler: StampPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        let stampNormalViewController: StampNormalViewController! = storyboard?.instantiateViewController(withIdentifier: "StampNormalViewController") as? StampNormalViewController
        
        stampNormalViewController.stampHandler = stampHandler

        let stampFontViewController: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "StampFontViewController")
        let stampAnimalViewController: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "StampAnimalViewController")
        let stampVehicleViewController: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "StampVehicleViewController")
        let stampFaceViewController: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "StampFaceViewController")
        
        pages.append(stampNormalViewController)
        pages.append(stampFontViewController)
        pages.append(stampAnimalViewController)
        pages.append(stampVehicleViewController)
        pages.append(stampFaceViewController)
    
        setViewControllers([stampNormalViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var currentPageIndex = 0

        if let prevVC = viewController as? StampNormalViewController {
            currentPageIndex = prevVC.index
        } else if let prevVC = viewController as? StampFontViewController {
            currentPageIndex = prevVC.index
        } else if let prevVC = viewController as? StampAnimalViewController {
            currentPageIndex = prevVC.index
        } else if let prevVC = viewController as? StampVehicleViewController {
            currentPageIndex = prevVC.index
        } else if let prevVC = viewController as? StampFaceViewController {
            currentPageIndex = prevVC.index
        }
        
        let previousIndex = (currentPageIndex - 1) % pages.count
        
        if previousIndex < 0 {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currentPageIndex = 0
        
        if let nextVC = viewController as? StampNormalViewController {
            currentPageIndex = nextVC.index
        } else if let nextVC = viewController as? StampFontViewController {
            currentPageIndex = nextVC.index
        } else if let nextVC = viewController as? StampAnimalViewController {
            currentPageIndex = nextVC.index
        } else if let nextVC = viewController as? StampVehicleViewController {
            currentPageIndex = nextVC.index
        } else if let nextVC = viewController as? StampFaceViewController {
            currentPageIndex = nextVC.index
        }
        
        let nextIndex = abs((currentPageIndex + 1) % pages.count)
        
        if nextIndex < 1 {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        var currentPageIndex = 0
        
        if let currentViewController = pageViewController.viewControllers?.last as? StampNormalViewController {
            currentPageIndex = currentViewController.index
        } else if let currentViewController = pageViewController.viewControllers?.last as? StampFontViewController {
            currentPageIndex = currentViewController.index
        } else if let currentViewController = pageViewController.viewControllers?.last as? StampAnimalViewController {
            currentPageIndex = currentViewController.index
        } else if let currentViewController = pageViewController.viewControllers?.last as? StampVehicleViewController {
            currentPageIndex = currentViewController.index
        } else if let currentViewController = pageViewController.viewControllers?.last as? StampFaceViewController {
            currentPageIndex = currentViewController.index
        }
        
        let indexPath = IndexPath(item: currentPageIndex, section: 0)
        self.stampPageViewControllerDelegate?.scrolledPageView(indexPath)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
