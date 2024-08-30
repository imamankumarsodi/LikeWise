//
//  SideMenuVC.swift
//  LikeWise
//
//  Created by Mobulous on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import RealmSwift

class SideMenuVC: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
   

    
    // MARK: - Variables
 //   let headerView = Bundle.main.loadNibNamed(SideMenuHeaderView.className, owner: self, options: nil)?.first as! SideMenuHeaderView
    var menuArray = [ConstantTexts.MyGamesLT,ConstantTexts.LeaderBoardLT,ConstantTexts.GetMoreCoinsLT,ConstantTexts.shareAppLT,ConstantTexts.settingsLT,ConstantTexts.FAQLT,ConstantTexts.FeedbackLT]
    internal var isComing = Bool()
    var menuImageArray : [UIImage] = [
        UIImage(named: "games")!,
        UIImage(named: "leader_board")!,
        UIImage(named: "coins-1")!,
        UIImage(named: "share")!,
        UIImage(named: "settings")!,
        UIImage(named: "faq")!,
        UIImage(named: "feedback")!
    ]
    
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initiallizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.transparentNavigation()
        super.addColorToNavigationBarAndSafeArea(color: AppColor.clearColor)
    }
  
    @IBAction func btnProfileTapped(_ sender: UIButton) {
        
        newProfile = true
        kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
        
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: MyProfileVC.className) as! MyProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}

