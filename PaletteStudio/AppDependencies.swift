//
//  AppDependencies.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/02/24.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies: NSObject {
    var tutorialWireframe: TutorialWireframe!
    var containerWireframe: ContainerWireframe!
    
    override init() {
        let rootWireframe = RootWireframe()
        self.tutorialWireframe = TutorialWireframe()
        self.tutorialWireframe.rootWireframe = rootWireframe
        self.containerWireframe = ContainerWireframe()
        self.containerWireframe.rootWireframe = rootWireframe
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        if let _ = PSUserDefault.sharedInstance.valueFromUserDefault(key: PSUserDefault.Keys.user_id) {
            self.containerWireframe.presentContainerInterfaceFromWindow(window)
        } else {
        self.containerWireframe.presentContainerInterfaceFromWindow(window)
        }
    }
}
