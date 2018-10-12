//
//  DMStoryboardBuilder.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/02/24.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StoryboardBuilder: NSObject {
    var tutorialStoryboard: UIStoryboard!
    var mainStoryboard: UIStoryboard!
    var stampStoryboard: UIStoryboard!
    
    static var sharedInstance: StoryboardBuilder = {
        return StoryboardBuilder()
    }()
    
    fileprivate override init() {
        super.init()
        self.tutorialStoryboard = StoryboardBuilder.createTutorialStoryboard()
        self.mainStoryboard = StoryboardBuilder.createMainStoryboard()
        self.stampStoryboard = StoryboardBuilder.createStampStoryboard()
    }
    
    class func storyboardWithIdentifier(identifier:String) -> UIStoryboard {
        return UIStoryboard(name: identifier, bundle: Bundle.main)
    }
    
    class func createTutorialStoryboard() -> UIStoryboard {
        return storyboardWithIdentifier(identifier: "Tutorial")
    }

    class func createMainStoryboard() -> UIStoryboard {
        return storyboardWithIdentifier(identifier: "Main")
    }
    
    class func createStampStoryboard() -> UIStoryboard {
        return storyboardWithIdentifier(identifier: "Stamp")
    }
    
    func tutorialViewController() -> TutorialViewController {
        return tutorialStoryboard.instantiateViewController(withIdentifier: "TutorialViewController")
            as! TutorialViewController
    }

    func firstTutorialViewController() -> FirstTutorialViewController {
        return tutorialStoryboard.instantiateViewController(withIdentifier: "FirstTutorialViewController")
            as! FirstTutorialViewController
    }
    
    func secondTutorialViewController() -> SecondTutorialViewController {
        return tutorialStoryboard.instantiateViewController(withIdentifier: "SecondTutorialViewController")
            as! SecondTutorialViewController
    }
    
    func thirdTutorialViewController() -> ThirdTutorialViewController {
        return tutorialStoryboard.instantiateViewController(withIdentifier: "ThirdTutorialViewController")
            as! ThirdTutorialViewController
    }
    
    func fourthTutorialViewController() -> FourthTutorialViewController {
        return tutorialStoryboard.instantiateViewController(withIdentifier: "FourthTutorialViewController")
            as! FourthTutorialViewController
    }

    func loginViewController() -> LoginViewController {
        return
            tutorialStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    func signupViewController() -> SignupViewController {
        return
            tutorialStoryboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
    }
    
    func reissueViewController() -> ReissueViewController {
        return
            tutorialStoryboard.instantiateViewController(withIdentifier: "ReissueViewController") as! ReissueViewController
    }
    
    func containerViewController() -> ContainerViewController {
        return
            mainStoryboard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
    }

    func slideMenuViewController() -> SlideMenuViewController {
        return
            mainStoryboard.instantiateViewController(withIdentifier: "SlideMenuViewController") as! SlideMenuViewController
    }
    
    func starListViewController() -> StarListViewController {
        return
            mainStoryboard.instantiateViewController(withIdentifier: "StarListViewController") as! StarListViewController
    }
    
    func settingViewController() -> SettingViewController {
        return
            mainStoryboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
    }
    
    func canvasViewController() -> CanvasViewController {
        return
            mainStoryboard.instantiateViewController(withIdentifier: "CanvasViewController") as!
        CanvasViewController
    }
    
    func stampContainerViewController() -> StampContainerViewController {
        return
            stampStoryboard.instantiateViewController(withIdentifier: "StampContainerViewController") as!
        StampContainerViewController
    }
    
    func photoFilterViewController() -> PhotoFilterViewController {
        return
            mainStoryboard.instantiateViewController(withIdentifier: "PhotoFilterViewController") as!
        PhotoFilterViewController
    }
}
