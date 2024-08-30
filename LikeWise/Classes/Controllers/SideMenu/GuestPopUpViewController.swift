//
//  GuestPopUpViewController.swift
//  LikeWise
//
//  Created by Aman Kumar on 05/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class GuestPopUpViewController: BaseViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.emailBtn, 22.0, AppColor.faceBookColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.facebookBtn, 22.0, AppColor.emailColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:ConstantTexts.PleaseLoginFirstLT, font:  ConstantFonts.TitleForgotFont, AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\n\(ConstantTexts.ContinueWithFacebookLT)", font: AppFont.light.size(AppFontName.SegoeUI, size: 14.0), AppColor.textColor))
        
        headingLbl.numberOfLines = 0
        headingLbl.attributedText = myMutableString
        
        CustomMethods.shared.provideCornerRadiusTo(self.mainView, 20,[.layerMinXMinYCorner,.layerMaxXMinYCorner])
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func facebookAction(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
            let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: PreRegisterVC.className) as! PreRegisterVC
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = false
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nav
        }
        
        
    }
    
    @IBAction func emailAction(_ sender: Any) {
        
        self.dismiss(animated: true) {
            let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = false
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nav
        }
        
        
    }
    
}
