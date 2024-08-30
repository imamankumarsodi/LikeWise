//
//  RegisterVC.swift
//  LikeWise
//
//  Created by Aman Kumar on 16/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class RegisterVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgBackgroud: UIImageView!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var dotView: UIView!
    
    
    @IBOutlet weak var btnLoginRef: UIButton!
    @IBOutlet weak var viewLoginUL: UIView!
    
    @IBOutlet weak var btnRegisterRef: UIButton!
    @IBOutlet weak var viewRegisterUL: UIView!
    
    @IBOutlet weak var viewFullName: UIView!
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var viewMail: UIView!
    @IBOutlet weak var txtMail: UITextField!
    
    @IBOutlet weak var viewUserName: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLoginNewRef: UIButton!
    
    @IBOutlet weak var btnEyeRef: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: - Variables
    internal var isPasswordShown = Bool()
    internal var userModel = UserModel()
    internal var withName = [String]()
    internal var fileName = [String]()
    internal var mimeType = [String]()
    internal var profileImageArr = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    //MARK: - Actons
    
    @IBAction func btnShowPasswordTapped(_ sender: UIButton) {
        txtPassword.isSecureTextEntry = isPasswordShown ? true : false
        let image = isPasswordShown ? #imageLiteral(resourceName: "eye_un") :#imageLiteral(resourceName: "eye_s")
        btnEyeRef.setImage(image, for: .normal)
        isPasswordShown = !isPasswordShown
    }
    
   
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
      let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func REGISTER_ACTION(_ sender: Any) {
        setupVAlidations()
        
    }
    
    
    @available(iOS 13.0, *)
    @IBAction func btnFBTapped(_ sender: UIButton) {
       
            UserDefaults.standard.set(false, forKey: "IS_GUEST")
            if Connect.networkConnected(){
                FBLoginSetup()
            }else{
                //HIDE LOADER
                HHelper.showAlert("There is no Internet connection.")
                return
            }
           // kAppDelegate.openDrawer()
        
    }
    
    
    @IBAction func btnGuestTapped(_ sender: UIButton) {
           let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: SelectLanguagesVC.className) as! SelectLanguagesVC
           vc.isComing = "GUEST"
           self.navigationController?.pushViewController(vc, animated: false)
       }

}

