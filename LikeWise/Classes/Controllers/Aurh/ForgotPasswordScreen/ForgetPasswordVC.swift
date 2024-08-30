//
//  ForgetPasswordVC.swift
//  LikeWise
//
//  Created by Aman Kumar on 16/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class ForgetPasswordVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewContent: UIView!
   
    @IBOutlet weak var viewMail: UIView!
    @IBOutlet weak var txtMail: UITextField!
  
    @IBOutlet weak var btnLoginNewRef: UIButton!
    
    @IBOutlet weak var lblHeading: UILabel!
    
    //MARK: - Variables
    internal var isPasswordShown = Bool()
    internal var userModel = UserModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
        
    }
    
    
     //MARK: - Actons
       
    @IBAction func btnDismissRef(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 13.0, *)
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
       setupVAlidations()
    }
    
}
