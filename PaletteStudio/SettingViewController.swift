//
//  SettingViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/21.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

enum CellMenu: Int {
    case account = 0
    case push
    case inquiry
    case terms
    case privacy
    case version
}

enum SettingCellType {
    case normal
    case toggle
}

class SettingRowObject: NSObject {
    var title: String?
    var type: SettingCellType?
    
    init(rowTitle title: String?, type: SettingCellType?) {
        super.init()
        self.title = title
        self.type = type
    }
}

class SettingViewController: BaseViewController, SettingViewInterface {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: SettingModuleInterface!
    var settingDataSource: [SettingRowObject] = []
    let navigationTitle = "設定"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        self.setNavigationBar()
        self.resisterSettingCell()
        self.createSettingData()
        self.tableView.tableFooterView = UIView()
        self.tableView.isScrollEnabled = false
    }
    
    fileprivate func createSettingData() {
        settingDataSource = [
            SettingRowObject(rowTitle: "アカウント設定", type: SettingCellType.normal),
            SettingRowObject(rowTitle: "プッシュ通知", type: SettingCellType.toggle),
            SettingRowObject(rowTitle: "お問い合わせ", type: SettingCellType.normal),
            SettingRowObject(rowTitle: "利用規約", type: SettingCellType.normal),
            SettingRowObject(rowTitle: "プライバシーポリシー", type: SettingCellType.normal)
        ]
    }
    
    private func configNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = navigationTitle.localized()
        self.navigationItem.hidesBackButton = true
    }
    
    private func setNavigationBar() {
        self.addLeftBarButtonWithImage(UIImage(named:"ContainerMenu")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func resisterSettingCell() {
        self.tableView.register( UINib(nibName: SettingTableViewCell.Constant.name, bundle: nil), forCellReuseIdentifier: SettingTableViewCell.Constant.identifier)
        self.tableView.register( UINib(nibName: SettingVersionTableViewCell.Constant.name, bundle: nil), forCellReuseIdentifier: SettingVersionTableViewCell.Constant.identifier)
        self.tableView.register( UINib(nibName: SettingPushTableViewCell.Constant.name, bundle: nil), forCellReuseIdentifier: SettingPushTableViewCell.Constant.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menu: CellMenu = CellMenu(rawValue: indexPath.row)!
        switch menu {
        case .account, .inquiry, .terms, .privacy:
            let  cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.Constant.identifier, for: indexPath) as! SettingTableViewCell
            
            cell.title.text = self.settingDataSource[indexPath.row].title
            
            return cell
        case .push:
            let  cell = tableView.dequeueReusableCell(withIdentifier: SettingPushTableViewCell.Constant.identifier, for: indexPath) as! SettingPushTableViewCell
            
            cell.title.text = self.settingDataSource[indexPath.row].title
            
            return cell

            
        case .version:
            let  cell = tableView.dequeueReusableCell(withIdentifier: SettingVersionTableViewCell.Constant.identifier, for: indexPath) as! SettingVersionTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
