//
//  PreRegisterVC_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 16/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire


//MARK: - Extension Custom methods
extension PreRegisterVC{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.addColorToNavigationBarAndSafeArea(color: AppColor.clearColor)
        super.setupNavigationBarTitle(ConstantTexts.empty, leftBarButtonsType: [.empty], rightBarButtonsType: [.empty])
        CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
    }
    
    
    //TODO: Initial setup method
    internal func initialSetup(){
        imgBackgroud.image = AppImages.bgImage
        
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.viewFacebookContainer, 20.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.viewContent, 20.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(viewFaceBook, viewFaceBook.frame.size.height/2, AppColor.clearColor, 0, 0, 0, 10, 0, AppColor.clearColor)
        viewFaceBook.backgroundColor = AppColor.faceBookColor
        CustomMethods.shared.setupButton(btnFbRef, AppColor.whiteColor, AppColor.clearColor, ConstantFonts.TitleNewFont, "   \(ConstantTexts.fbBT)")
        
        CustomMethods.shared.provideShadowAndCornerRadius(viewMail, viewMail.frame.size.height/2, AppColor.clearColor, 0, 0, 0, 10, 0, AppColor.clearColor)
        viewMail.backgroundColor = AppColor.emailColor
        CustomMethods.shared.setupButton(btnEmailRef, AppColor.whiteColor, AppColor.clearColor, ConstantFonts.TitleNewFont, "   \(ConstantTexts.emailOnlyPH)")
        
        CustomMethods.shared.provideShadowAndCornerRadius(viewGuest, viewGuest.frame.size.height/2, AppColor.clearColor, 0, 0, 0, 10, 0, AppColor.clearColor)
        viewGuest.backgroundColor = AppColor.guestColor
        CustomMethods.shared.setupButton(btnGustRef, AppColor.whiteColor, AppColor.clearColor, ConstantFonts.TitleNewFont,"    \(ConstantTexts.playGuestBT)")
        
        lblFacebookInstruction.font = ConstantFonts.TitleNewFont
        lblFacebookInstruction.textColor = AppColor.textColor
        lblFacebookInstruction.text = ConstantTexts.ContinueWithFBLT
        
        emailInstruction.font = ConstantFonts.TitleNewFont
        emailInstruction.textColor = AppColor.textColor
        emailInstruction.text = ConstantTexts.ContinueWithLimitedLT
        
    }
    
}

extension PreRegisterVC{
    //TODO: Login methods for sign in facebook
    func FBLoginSetup()
    {
        
        
        let fbloginManager:LoginManager = LoginManager()
        if Connect.networkConnected(){
            
            //SHOW LOADER
            
            // CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            fbloginManager.logIn(permissions: ["email","public_profile"], from: self) { (result, error) in
                print(result)
                if error != nil{
                    //HIDE LOADER
                    CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
                    print("Get an error\(error?.localizedDescription)")
                }else{
                    //HIDE LOADER
                    CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
                    
                    self.getFbData()
                    fbloginManager.logOut()
                }
            }
        }else{
            //HIDE LOADER
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            HHelper.showAlert("There is no internet Connection.")
        }
    }
    
    func getFbData()
    {
        
        if Connect.networkConnected(){
            //SHOW LOADER
            
            //  CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            if (AccessToken.current != nil){
                GraphRequest(graphPath: "me", parameters: ["fields": "id ,name , first_name , last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) in
                    
                    if error != nil{
                        //HIDE LOADER
                        CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
                        
                        print("Get error\(error?.localizedDescription)")
                    }
                    else{
                        //HIDE LOADER
                        CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
                        
                        if let dataDict = result as? [String : AnyObject]{
                            print(dataDict)
                            
                            
                           
                            
                            guard let socialID = dataDict["id"] as? String else {
                                print("No socialID")
                                return
                            }
                            guard let first_name = dataDict["first_name"] as? String else {
                                print("No first_name")
                                return
                            }
                            guard let last_name = dataDict["last_name"] as? String else {
                                print("No last_name")
                                return
                            }
                            guard let name = dataDict["name"] as? String else {
                                print("No name")
                                return
                            }
                            let email = dataDict["email"] as? String ?? ""
                            
                            var profilePicR = String()
                            
                            if let pictureDict = dataDict["picture"] as? [String:AnyObject]{
                                if let pictureData = pictureDict["data"] as? [String:AnyObject]{
                                    guard let url = pictureData["url"] as? String else {
                                        print("No url")
                                        return
                                    }
                                    profilePicR = url
                                }
                            }
                            
                            self.userModel.socialId = socialID
                            self.userModel.socialType = "facebook"
                            self.userModel.email = email
                            self.userModel.profilePic = profilePicR
                            self.userModel.mobileNumber = String()
                            self.userModel.name = name
                            self.userModel.deviceType = ConstantTexts.deviceType
                            if let devieToken = UserDefaults.standard.value(forKey: "deviceToken") as? String{
                                self.userModel.deviceToken = devieToken
                            }
                            self.userModel.type = "1"
                            self.checkSocialLoginApi()
                        }
                        
                    }
                })
            }
        }else{
            //HIDE LOADER
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            HHelper.showAlert("There is no internet Connection.")
        }
    }
    
    
    
    func checkSocialLoginApi(){
        
        let headers:HTTPHeaders = [
            "Content-Type":"application/json",
            "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.checkSocalId, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            if let message = response.message as? String{
                if message == "User does not exist"{
                    let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: SelectLanguagesVC.className) as! SelectLanguagesVC
                    vc.userModel = self.userModel
                    vc.isComing = "SOCIAL"
                    self.navigationController?.pushViewController(vc, animated: false)
                }else{
                    
                    if let dataDict = response.resultDict as? NSDictionary{
                        let userData = UserDataModel()
                        if let __v = dataDict.value(forKey: "__v") as? String{
                            userData.__v = __v
                        }
                        
                        if let _id = dataDict.value(forKey: "_id") as? String{
                            userData._id = _id
                        }
                        
                        if let coinStatus = dataDict.value(forKey: "coinStatus") as? String{
                            userData.coinStatus = Double(coinStatus) ?? 0.0
                        }
                        
                        if let coinStatus = dataDict.value(forKey: "coinStatus") as? Double{
                            userData.coinStatus = Double(coinStatus) ?? 0.0
                        }
                        
                        if let coins = dataDict.value(forKey: "coins") as? String{
                            userData.coins = Double(coins) ?? 0.0
                        }
                        
                        if let coins = dataDict.value(forKey: "coins") as? Double{
                            userData.coins = Double(coins) ?? 0.0
                        }
                        
                        if let coins = dataDict.value(forKey: "coins") as? Int{
                            userData.coins = Double(coins) ?? 0.0
                        }
                                       
                        if let dob = dataDict.value(forKey: "dob") as? String{
                            userData.dob = dob
                        }
                        
                        if let email = dataDict.value(forKey: "email") as? String{
                            userData.email = email
                        }
                        
                        if let jwtToken = dataDict.value(forKey: "jwtToken") as? String{
                            userData.jwtToken = jwtToken
                        }
                        
                        if let name = dataDict.value(forKey: "name") as? String{
                            userData.name = name
                        }
                        
                        if let notificationStatus = dataDict.value(forKey: "notification") as? String{
                            userData.notificationStatus = notificationStatus
                        }
                        
                        if let notificationStatus = dataDict.value(forKey: "notification") as? Int{
                            userData.notificationStatus = "\(notificationStatus)"
                        }
                        
                        if let profilePic = dataDict.value(forKey: "profilePic") as? String{
                            userData.profilePic = profilePic
                        }
                        
                        if let status = dataDict.value(forKey: "status") as? String{
                            userData.status = status
                        }
                        
                        if let totalPoints = dataDict.value(forKey: "totalPoints") as? String{
                            userData.totalPoints = Double(totalPoints) ?? 0.0
                        }
                        
                        if let totalPoints = dataDict.value(forKey: "totalPoints") as? Double{
                            userData.totalPoints = Double(totalPoints) ?? 0.0
                        }
                        
                        if let username = dataDict.value(forKey: "username") as? String{
                            userData.username = username
                        }
                        
                        if let type = dataDict.value(forKey: "type") as? String{
                            userData.type = type
                        }
                        
                        if let languageCode = dataDict.value(forKey: "languageCode") as? NSArray{
                            let string = languageCode.componentsJoined(by: ",")
                            userData.languageCode = string
                        }
                        
                        if let state = dataDict.value(forKey: "state") as? String{
                            userData.state = state
                        }
                        
                        if let country = dataDict.value(forKey: "country") as? String{
                            userData.country = country
                        }
                        
                        if let defaultLangCode = dataDict.value(forKey: "defaultLangCode") as? String{
                            userData.defaultLangCode = defaultLangCode
                        }
                        
                        if let interest1 = dataDict.value(forKey: "interest1") as? String{
                            userData.interest1 = interest1
                        }
                        
                        if let interest2 = dataDict.value(forKey: "interest2") as? String{
                            userData.interest2 = interest2
                        }
                        
                        if let interest3 = dataDict.value(forKey: "interest3") as? String{
                            userData.interest3 = interest3
                        }
                        
                        if let nationalit = dataDict.value(forKey: "nationalit") as? String{
                            userData.nationalit = nationalit
                        }
                        
                        if let aboutus = dataDict.value(forKey: "aboutus") as? String{
                            userData.aboutus = aboutus
                        }
                        
                        if let city = dataDict.value(forKey: "city") as? String{
                            userData.city = city
                        }
                        
                        if let interest = dataDict.value(forKey: "interest") as? String{
                            userData.interest = interest
                        }
                        
                        if let gender = dataDict.value(forKey: "gender") as? String{
                            userData.gender = gender
                        }
                        
                        if let password = dataDict.value(forKey: "password") as? String{
                            userData.password = password
                        }
                        
                        
                        CustomMethods.shared.saveUserData(item: userData, callBack: {
                            kAppDelegate.openDrawer()
                        })
                        
                        
                    }
                }
            }
            
            
        }.catch { (error) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            let nsError = error as NSError
            if let error = nsError.userInfo["errorMessage"] as? String{
                HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
            }
        }
        
    }
    
    
}
