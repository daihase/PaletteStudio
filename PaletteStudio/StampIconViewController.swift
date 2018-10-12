//
//  StampIconViewController.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2016/04/07.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

protocol StampIconViewControllerDelegate: class {
    func stampIconViewController(_ viewController: StampIconViewController, at index: Int)
}

class StampIconViewController: UICollectionViewController {
    weak var delegate: StampIconViewControllerDelegate?
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampIconCollectionViewCell", for: indexPath) as! StampIconCollectionViewCell
        let data = StampIconModelManager.sharedInstance.data[(indexPath as NSIndexPath).row]
        let active = ((indexPath as NSIndexPath).row == self.selectedIndex)
        cell.configure(data.image, active: active)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.focusCell(indexPath)
        
        delegate?.stampIconViewController(self, at: (indexPath as NSIndexPath).row)
    }
    
    func focusCell(_ indexPath: IndexPath) {
        if let previousCell = collectionView?.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) as? StampIconCollectionViewCell {
            previousCell.focusCell(false)
        }

        if let nextCell = collectionView?.cellForItem(at: indexPath) as? StampIconCollectionViewCell {
            nextCell.focusCell(true)
        }
        
        selectedIndex = (indexPath as NSIndexPath).row
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
