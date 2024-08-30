//
//  AllScreenVC.swift
//  LikeWise
//
//  Created by Deepti Sharma on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class AllScreenVC: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblAllFriends: UITableView!
    
    //MARK: - Variable
    
    
    
    var callBackData: ((_ count: Int)->())?
    internal var userModel = UserModel()
    
    internal var tempArrayCount = [FriendsCommanDataModel]()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.whiteColor
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    
    @objc func reloadTable(_ notification: Notification){
        if (UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool) != nil{
            if let isGuest = UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool{
                if isGuest{
                    print("do nothing...")
                }else{
                    allFriendsApi()
                }
            }else{
                allFriendsApi()
            }
        }
        
        
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if (UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool) != nil{
            if let isGuest = UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool{
                if isGuest{
                    print("do nothing...")
                }else{
                    allFriendsApi()
                }
            }else{
                allFriendsApi()
            }
        }
        
        
        refreshControl.endRefreshing()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
