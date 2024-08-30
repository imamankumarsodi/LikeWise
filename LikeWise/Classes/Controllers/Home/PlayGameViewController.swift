//
//  PlayGameViewController.swift
//  LikeWise
//
//  Created by Aman Kumar on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import RealmSwift

class PlayGameViewController: BaseViewController {
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblSelectLangTitle: UILabel!
    @IBOutlet weak var lblSelectModeTitle: UILabel!

    @IBOutlet weak var liveImg: UIImageView!
    @IBOutlet weak var timerImg: UIImageView!
    @IBOutlet weak var langCV: UICollectionView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var modeView: UIView!
    @IBOutlet weak var liveView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var goBtn: UIButton!
    
    @IBOutlet weak var lblTimeLeft: UILabel!
    @IBOutlet weak var lblLifeLeft: UILabel!

    internal var sideNAme = -1
    internal var type = String()
    internal var CountryDataModelCollecArr = [CountryDataModelCollec]()
    internal let realm = try! Realm()
    internal var userModel = UserModel()
    
    internal var RandomImagesModelArray = [RandomImagesModel]()
    internal var CountryDataModelCollecArr_Objective = [Objective]()
    internal var PlayGameUserModel_Array = [PlayGameUserModel]()
    var defaultLang = String()
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    @IBAction func goBnAction(_ sender: Any) {
        validation()
        
      /*  if type == "1"{
            let vc = AppStoryboard.home.instantiateViewController(withIdentifier: InviteSentViewController.className) as! InviteSentViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            let vc = AppStoryboard.home.instantiateViewController(withIdentifier: LiveInviteSentViewController.className) as! LiveInviteSentViewController
            self.navigationController?.pushViewController(vc, animated: false)
        } */
    }
    
 
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func liveBtnAction(_ sender: Any) {
        type = "2"
        self.liveView.backgroundColor = AppColor.themeColorLight
        self.timeView.backgroundColor = AppColor.whiteColor
        liveImg.image = UIImage(named: "life_s")
        timerImg.image = UIImage(named: "timeUN")
        
    }
    @IBAction func timerBtnAction(_ sender: Any) {
        type = "1"
        self.timeView.backgroundColor = AppColor.themeColorLight
        self.liveView.backgroundColor = AppColor.whiteColor
        
        liveImg.image = UIImage(named: "life_un")
        timerImg.image = UIImage(named: "timeNew")
    }
}
