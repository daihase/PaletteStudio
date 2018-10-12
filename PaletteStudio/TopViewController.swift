//
//  ViewController.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2015/05/11.
//  Copyright (c) 2015年 Libra Studio, Inc. All rights reserved.
//
/*
import UIKit

class TopViewController: BaseViewController {
    
    var presenter: TopModuleInterface!
    var topEventHandler: TopPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        // ジェスチャー生成.
        self.presenter.setupView()
    }
    
    private func configNavigationBar() {
        // NavigationBarを隠す.
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        
        // 背景画像.
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "TopBackground")?.draw(in: self.view.bounds)
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TopViewController: TopViewInterface {
    func setupedView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TopViewController.tapGesture(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // 画面をタップすると処理開始.
    func tapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        // Mode画面へ.
        self.presenter.showContainerFromTop()
        //topWireFrame.sharedInstance.pushModeSelectViewController()
    }
}*/

