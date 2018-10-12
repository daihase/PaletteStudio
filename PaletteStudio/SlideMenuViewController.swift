//
//  SlideMenuViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/12.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit
import Photos
import PhotoCropEditor

enum LeftMenu: Int {
    case home = 0
    case camera
    case gallery
    case starList
    case setting
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

protocol SlideMenuViewControllerDelegate {
    func showContainerViewController()
    func showSettingViewController()
    func showStarListViewController()
    func showCanvasViewController(_ image: UIImage)
}

class SlideMenuViewController: UIViewController, LeftMenuProtocol {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var name: AttributeLabel!
    var delegate: SlideMenuViewControllerDelegate!
    var mainViewController: UIViewController!
    var containerViewController: UIViewController!
    var settingViewController: UIViewController!
    var canvasViewController: UIViewController!
    var titleArray = ["ホーム","カメラ","ファイル","スター一覧","設定"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createViewController()
        self.resisterSettingsCell()
        self.tableView.tableFooterView = UIView()
        self.tableView.isScrollEnabled = false
    }
    
    func createViewController() {
        self.containerViewController = StoryboardBuilder.sharedInstance.containerViewController()
        _ = StoryboardBuilder.sharedInstance.canvasViewController()
        
        let settingViewController = StoryboardBuilder.sharedInstance.settingViewController()
        self.settingViewController = UINavigationController(rootViewController: settingViewController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SlideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func resisterSettingsCell() {
        self.tableView.register( UINib(nibName: SlideMenuTableViewCell.Constant.name, bundle: nil), forCellReuseIdentifier: SlideMenuTableViewCell.Constant.identifier)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SlideMenuTableViewCell.Constant.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SlideMenuTableViewCell.Constant.identifier, for: indexPath) as! SlideMenuTableViewCell
        
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.icon.image = UIImage(named: "SlideMenuHome")
            cell.title.text = titleArray[0].localized()
            break
        case 1:
            cell.icon.image = UIImage(named: "SlideMenuCamera")
            cell.title.text = titleArray[1].localized()
            break
        case 2:
            cell.icon.image = UIImage(named: "SlideMenuGallery")
            cell.title.text = titleArray[2].localized()
            break
        case 3:
            cell.icon.image = UIImage(named: "SlideMenuStarList")
            cell.title.text = titleArray[3].localized()
            break
        case 4:
            cell.icon.image = UIImage(named: "SlideMenuSetting")
            cell.title.text = titleArray[4].localized()
            break
        default:
            break
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .home:
            self.delegate.showContainerViewController()
        case .camera:
            self.slideMenuController()?.closeLeft()
            self.showCanvasWithCamera()
        case .gallery:
            self.slideMenuController()?.closeLeft()
            self.showCanvasWithGallery()
        case .starList:
           self.delegate.showStarListViewController()
        case .setting:
            self.delegate.showSettingViewController()
        }
    }
}

// MARK: UIImagePickerControllerDelegate
extension SlideMenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showCanvasWithCamera() {
        let imagePickerController: UIImagePickerController = UIImagePickerController();
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func showCanvasWithGallery() {
        let imagePickerController: UIImagePickerController = UIImagePickerController();
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        dismiss(animated: true) { [unowned self] in
            let controller = CropViewController()
            controller.delegate = self
            controller.image = image
            
            let navController = UINavigationController(rootViewController: controller)
            let title = UILabel(frame: CGRect.zero)
            title.text = "Crop".localized()
            title.font = UIFont.boldSystemFont(ofSize: 17)
            title.textColor = UIColor.black
            title.sizeToFit()
            
            controller.navigationItem.titleView = title
            self.present(navController, animated: true, completion: nil)
        }
    }

    func cannotShowUIImagePickerController() {
        print("カメラ・ギャラリーの取得に失敗しました")
    }
    
    func showSettingViewController() {
    }
}

extension SlideMenuViewController: CropViewControllerDelegate {
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage) {
    }
    
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
        
        controller.dismiss(animated: true, completion: nil)
        
        let resizeImage = image.resize(sourceImage: image, scaledToWidth: UIScreen.main.bounds.size.width, scaledToHeight: UIScreen.main.bounds.size.height)
        
        self.delegate.showCanvasViewController(resizeImage)
        
    }
    
    func cropViewControllerDidCancel(_ controller: CropViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
