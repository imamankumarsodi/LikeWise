//
//  InviteSentViewController.swift
//  LikeWise
//
//  Created by cst on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import SocketIO

class InviteSentViewController: BaseViewController {
    @IBOutlet weak var btnNavRef: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var lblHeadingRef: UILabel!
    
    //MARK: - Variables for socket
    internal let socketManager = SocketManager(socketURL: URL(string: "http://18.224.114.141:8001")!, config: ["log": true])
    internal var socket: SocketIOClient!
    internal var forFirstTimeOnly = true
    internal var userModel = UserModel()
    
    
    var game_id = String()
    var receiver_id = String()
    var type = String()
    var languangeCode = String()
    
    internal var timer:Timer?
    var timerCount = 90
    var selectedFriend = CountryDataModelCollec(__v: String(), _id: String(), coinStatus: String(), dob: String(), email: String(), jwtToken: String(), languageCode: String(), name: String(), notificationStatus: String(), profilePic: String(), status: String(), totalPoints: String(), username: String(), type: String(), country: String(), defaultLangCode: String(), nationalit: String(), state: String(), aboutus: String(), city: String(), interest: String(), gender: String(), password: String(), descriptionUser: String(), socialId: String(), isSelected: Bool(), coins: String())
    override func viewDidLoad() {
        super.viewDidLoad()
        print(receiver_id)
        print(game_id)
        initialSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socketDisconnect()
        timerCount = 90
        timer?.invalidate()
        timer = nil
    }
 
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func chatFordwarrdAction(_ sender: Any) {
        
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: TimeNotFoundViewController.className) as! TimeNotFoundViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func onTimerFires()
    {
        timerCount -= 1
        if timerCount > 0{
            
            let myMutableString = NSMutableAttributedString()
           
            myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(selectedFriend.name)\n", font: ConstantFonts.TextFieldFont, AppColor.textColor))
            
            myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.HasLT, font: ConstantFonts.TextFieldFont, AppColor.textColor))
            myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:"\(timerCount)", font: ConstantFonts.TextFieldFont, AppColor.errorColor))
            
            myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.SecondsleftLT, font: ConstantFonts.TextFieldFont, AppColor.textColor))
            infoLbl.attributedText = myMutableString
            
        }else{
            timerCount = 90
            timer?.invalidate()
            timer = nil
            
            let myMutableString = NSMutableAttributedString()
                      
                       myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(selectedFriend.name)\n", font: ConstantFonts.TextFieldFont, AppColor.textColor))
                       
                       myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.HasLT, font: ConstantFonts.TextFieldFont, AppColor.textColor))
                       myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:"\("0")", font: ConstantFonts.TextFieldFont, AppColor.errorColor))
                       
                       myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.SecondsleftLT, font: ConstantFonts.TextFieldFont, AppColor.textColor))
                       infoLbl.attributedText = myMutableString
            
            
            kAppDelegate.checkAutoLogin()

        }
        
    }
    
    
}
