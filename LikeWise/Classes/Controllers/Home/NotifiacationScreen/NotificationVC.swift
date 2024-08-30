//
//  NotificationVC.swift
//  LikeWise
//
//  Created by Aman Kumar on 27/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import SocketIO
class NotificationVC: BaseViewController {

    
    //MARK: - IBOutlet
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var viewSeprator: UIView!
    @IBOutlet weak var tblNoti: UITableView!
    @IBOutlet weak var viewBG: UIView!
    
    internal var notificationList = [NotificationDataModel]()
   
    //MARK: - Variables for socket
    internal let socketManager = SocketManager(socketURL: URL(string: "http://18.224.114.141:8001")!, config: ["log": true])
    internal var socket: SocketIOClient!
    internal var forFirstTimeOnly = true
    internal var userModel = UserModel()
    var vc = UIViewController()
    var isComing = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CustomMethods.shared.screenName = String()
        socketDisconnect()
    }

    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        if isComing{
            kAppDelegate.checkAutoLogin()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func btnAcceptTapped(_ sender: UIButton) {
        accept_rejectSocket("accept", sender.tag)
    }
    
    @objc func btnRejectTapped(_ sender: UIButton) {
        accept_rejectSocket("reject", sender.tag)
    }

}
