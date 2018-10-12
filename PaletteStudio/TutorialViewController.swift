//
//  TutorialViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/27.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    var startButtonText = "Start"
    var loginButtonText = "Login"
    var currentIndex: Int!
    var pageViewController: UIPageViewController?
    var presenter: TutorialModuleInterface!
    var pageViewControllers: [UIViewController] = []
    var firstTutorialViewController: FirstTutorialViewController!
    var secondTutorialViewController: SecondTutorialViewController!
    var thirdTutorialViewController: ThirdTutorialViewController!
    var fourthTutorialViewController: FourthTutorialViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.configure()
    }
    
    func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func configure() {
        self.startButton.setTitle(self.startButtonText, for: .normal)
        self.startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16 * PSUtil.scaleRatioWithScreenWidth())
        self.startButton.setBackgroundImage(PSUtil.createColorImageFromUIColor(color: PSColor.companyColor()), for: .normal)
        self.startButton.setBackgroundImage(PSUtil.createColorImageFromUIColor(color: PSColor.buttonHighlightCompanyColor()), for: .highlighted)
        
        self.loginButton.setTitle(self.loginButtonText, for: .normal)
        self.startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16 * PSUtil.scaleRatioWithScreenWidth())
        self.loginButton.setBackgroundImage(PSUtil.createColorImageFromUIColor(color: PSColor.companyColor()), for: .normal)
        self.loginButton.setBackgroundImage(PSUtil.createColorImageFromUIColor(color: PSColor.buttonHighlightCompanyColor()), for: .highlighted)
        
        self.firstTutorialViewController = StoryboardBuilder.sharedInstance.firstTutorialViewController()
        self.secondTutorialViewController = StoryboardBuilder.sharedInstance.secondTutorialViewController()
        self.thirdTutorialViewController = StoryboardBuilder.sharedInstance.thirdTutorialViewController()
        self.fourthTutorialViewController = StoryboardBuilder.sharedInstance.fourthTutorialViewController()
        pageViewControllers = [firstTutorialViewController,secondTutorialViewController,thirdTutorialViewController, fourthTutorialViewController]
        self.pageViewController = childViewControllers[0] as? UIPageViewController
        self.pageViewController!.dataSource = self
        self.pageViewController!.delegate = self
        self.pageViewController!.setViewControllers([pageViewControllers[0]], direction: .forward, animated: false, completion: nil)
    
        (self.pageViewController as! TutorialPageViewController).currentIndex = 0
        
    }
    
    @IBAction func tapSignupButton(_ sender: AnyObject) {
        self.presenter.tapSignupButton()
    }
    
    @IBAction func tapLoginButton(_ sender: AnyObject) {
       self.presenter.tapLoginButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TutorialViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if let currentViewController = pageViewController.viewControllers?[0] as? FirstTutorialViewController {
            self.pageControl.currentPage = currentViewController.currentIndex
        } else if let currentViewController = pageViewController.viewControllers?[0] as? SecondTutorialViewController {
            self.pageControl.currentPage = currentViewController.currentIndex
        } else if let currentViewController = pageViewController.viewControllers?[0] as? ThirdTutorialViewController {
            self.pageControl.currentPage = currentViewController.currentIndex
        } else {
            self.pageControl.currentPage = self.fourthTutorialViewController.currentIndex
        }
    }
    
    func pageViewController(_ pageViewController:
        UIPageViewController, viewControllerBefore viewController:UIViewController) -> UIViewController? {
        let index = pageViewControllers.index(of: viewController)
        (self.pageViewController as! TutorialPageViewController).currentIndex = index
        if index == 0 {
            self.currentIndex = 0
            return nil
        } else {
            self.currentIndex = index! - 1
            return pageViewControllers[index!-1]
        }
    }
    
    func pageViewController(_ pageViewController:
        UIPageViewController, viewControllerAfter viewController: UIViewController) ->
        UIViewController? {
            let index = pageViewControllers.index(of: viewController)
            (self.pageViewController as! TutorialPageViewController).currentIndex = index
            if index == pageViewControllers.count-1 {
                self.currentIndex = 3
                return nil
            } else {
                self.currentIndex = index! + 1
                return pageViewControllers[index!+1]
            }
           
    }
}

extension TutorialViewController: TutorialViewInterface {}
