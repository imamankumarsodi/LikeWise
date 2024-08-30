//
//  LeaderBoardVC.swift
//  LikeWise
//
//  Created by Aman Kumar on 27/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import DYPieChartView
import RealmSwift

class LeaderBoardVC: BaseViewController {
    
    @IBOutlet weak var pieChartView: DYPieChartView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblView_leader: UITableView!
    
    @IBOutlet weak var percentageLbl: UILabel!
    
    
    
    @IBOutlet weak var uperView: cardView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgFB: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblGameCount: UILabel!
    @IBOutlet weak var lblTimings: UILabel!
    
    //MARK: - Variable
    internal let realm = try! Realm()
    internal var userModel = UserModel()
    internal var leaderBoardArray = [LeaderBoardDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    
    @IBAction func profileMoveAction(_ sender: Any) {
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: MyProfileVC.className) as! MyProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
