//
//  PSPhotoManager.swift
//  PaletteStudio
//
//  Created by daihase on 2016/09/20.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import Photos

public enum PhotoLibraryState {
    case authorized
    case denied
    case notDetermined
    case restricted
}

class PSPhotoManager {
    private init(){}
    static let sharedInstance = PSPhotoManager ()

    func Authorization( completion: @escaping (Bool) -> Void)  {
        
        PHPhotoLibrary.requestAuthorization { (status) -> Void in
            print("------ Photo Gallery Access ------")
            switch(status){
            case .authorized:
                print("Authorized")
                completion(true)
            case .denied:
                print("Denied")
                completion(false)
            case .notDetermined:
                print("NotDetermined")
                completion(false)
            case .restricted:
                print("Restricted")
                completion(false)
            }
        }
    }
    
    func createAlbum(albumName: String, targetView: UIView) -> Void {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        if collection.firstObject != nil {
            print("[\(albumName)] already exist")
            self.saveCanvasToAlbum(targetView)
        }else{
            PHPhotoLibrary.shared().performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName.localized())
                }, completionHandler: { (isSuccess, error) in
                    if isSuccess == true {
                        print("Success!")
                        self.saveCanvasToAlbum(targetView)
                    }
                    else{
                        print("error occured")
                    }
            })
        }
    }
    
    func saveCanvasToAlbum(_ targetView: UIView) {
        let albumTitle = "Palette Studio".localized()
        var theAlbum: PHAssetCollection?
        let result = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: nil)
        result.enumerateObjects({(object, index, stop) in
            
            if object.localizedTitle == albumTitle {
                theAlbum = object
            }
        })
        
        let captureImage = PSUtil.getScreenCapture(targetView: targetView)

        if let anAlbum = theAlbum {
            PHPhotoLibrary.shared().performChanges({
                let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: captureImage)
                _ = assetChangeRequest.placeholderForCreatedAsset
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: anAlbum)
                let fastEnumeration = NSArray(array: [assetChangeRequest.placeholderForCreatedAsset!] as [PHObjectPlaceholder])
                
                albumChangeRequest!.addAssets(fastEnumeration)
                }, completionHandler: nil)
        }
    }
}

