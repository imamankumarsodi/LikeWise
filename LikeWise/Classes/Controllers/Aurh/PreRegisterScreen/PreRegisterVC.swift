//
//  PreRegisterVC.swift
//  LikeWise
//
//  Created by Aman Kumar on 16/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class PreRegisterVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgBackgroud: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewFaceBook: UIView!
    @IBOutlet weak var viewMail: UIView!
    @IBOutlet weak var viewGuest: UIView!
    
    @IBOutlet weak var viewFacebookContainer: UIView!
    @IBOutlet weak var btnFbRef: UIButton!
    @IBOutlet weak var btnEmailRef: UIButton!
    @IBOutlet weak var btnGustRef: UIButton!
    @IBOutlet weak var lblFacebookInstruction: UILabel!
    
    @IBOutlet weak var emailInstruction: UILabel!
    //MARK: - Variables
    internal var isPasswordShown = Bool()
    internal var isComing = ""
    
    
    var fbEmailId = String()
    var FbUseremail = String()
    var fbUserName = String()
    var fbUserProfileImg = String()
    var fbSocialId = String()
    var fbprofileImg = String()
    
    internal var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        setupNavigation()
    }
    
    //MARK: - Actons
    
    @available(iOS 13.0, *)
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @available(iOS 13.0, *)
    @IBAction func btnChoiceTapped(_ sender: UIButton) {
        if sender.tag == 0{
            UserDefaults.standard.set(false, forKey: "IS_GUEST")
            if Connect.networkConnected(){
                FBLoginSetup()
            }else{
                //HIDE LOADER
                HHelper.showAlert("There is no Internet connection.")
                return
            }
           // kAppDelegate.openDrawer()
        }else if sender.tag == 1{
             UserDefaults.standard.set(false, forKey: "IS_GUEST")
            let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
           /* let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: SelectLanguagesVC.className) as! SelectLanguagesVC
            self.navigationController?.pushViewController(vc, animated: false) */
        }
    }
    
    @available(iOS 13.0, *)
    @IBAction func btnChoseLanguagesTapped(_ sender: UIButton) {
        let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: SelectLanguagesVC.className) as! SelectLanguagesVC
        vc.isComing = "GUEST"
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

