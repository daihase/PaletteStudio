//
//  ModeSelectViewController.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/02/29.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import Photos

class ContainerViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ContainerViewInterface {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: ContainerModuleInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        self.setNavigationBar()
    }
    
    private func configNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Palette Studio"
        self.navigationItem.hidesBackButton = true
    }
    
    private func setNavigationBar() {
        self.addLeftBarButtonWithImage(UIImage(named:"ContainerMenu")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ContainerViewController: UICollectionViewDataSource {
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContainerCollectionViewCell.Constant.name, for: indexPath) as! ContainerCollectionViewCell
        
        return cell
    }
}

extension ContainerViewController: SlideMenuViewControllerDelegate {
    func showContainerViewController() {
        self.presenter!.showContainer()
    }
    
    func showCanvasViewController(_ image: UIImage) {
        self.presenter!.showCanvas(image)
    }
    
    func showStarListViewController() {
        self.presenter!.showStarListViewController()
    }
    
    func showSettingViewController() {
        self.presenter!.showSettingViewController()
    }
}
