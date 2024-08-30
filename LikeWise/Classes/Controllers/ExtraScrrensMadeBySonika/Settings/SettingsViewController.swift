//
//  SettingsViewController.swift
//  LikeWise
//
//  Created by cst on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit


class SettingsViewController: BaseViewController {

    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    @IBOutlet weak var tblSettings: UITableView!
    @IBOutlet weak var lblHeadings: UILabel!
    
    internal var settingsModelArray = [SettingsDataModel]()
    internal var token = String()
    internal var notificationStatus = Bool()
    internal var userModel = UserModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        heightTableView.constant = tblSettings.contentSize.height
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSwitchTappd(_ sender: UISwitch) {
        changeNotificationStatusApi()
    }

    
}
