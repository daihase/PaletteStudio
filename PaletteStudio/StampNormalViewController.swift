//
//  StampNormalViewController.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class StampNormalViewController: BaseViewController {
    let index = 0
    var stampHandler: StampPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    fileprivate func setupView() {
          self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension StampNormalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampNormalCell", for: indexPath)
        let data: String = StampNormalManager.sharedInstance.data[(indexPath as NSIndexPath).row]
        let stampImage = cell.contentView.viewWithTag(1) as! UIImageView
        stampImage.image = UIImage(named: data)
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StampNormalManager.sharedInstance.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.stampHandler?.selectStampIcon(stampData: (stampType: StampType.normal, indexPath: indexPath))
    }
}
