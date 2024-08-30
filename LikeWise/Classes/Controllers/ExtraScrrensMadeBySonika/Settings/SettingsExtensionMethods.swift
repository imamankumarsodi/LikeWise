//
//  SettingsExtensionMethods.swift
//  LikeWise
//
//  Created by cst on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Alamofire

extension SettingsViewController{
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    internal func initialSetUp(){
        CustomMethods.shared.provideShadowAndCornerRadius(self.tblSettings, 15.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        tblSettings.register(nib: SettingsTableViewCell.className)
        
        
        let realm = try! Realm()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
                if user.notificationStatus == "0" {
                    notificationStatus = false
                    settingsModelArray.append(SettingsDataModel(title: ConstantTexts.notificationLT, subtitle: String(), isSelected: false, isHidden: false))
                }else{
                    notificationStatus = true
                    settingsModelArray.append(SettingsDataModel(title: ConstantTexts.notificationLT, subtitle: String(), isSelected: true, isHidden: false))
                }
                
            }
            
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        settingsModelArray.append(SettingsDataModel(title: ConstantTexts.soundsLT, subtitle: String(), isSelected: false, isHidden: false))
        settingsModelArray.append(SettingsDataModel(title: ConstantTexts.vibeLT, subtitle: String(), isSelected: false, isHidden: false))
        settingsModelArray.append(SettingsDataModel(title: ConstantTexts.privacyAndPolicyLT, subtitle: String(), isSelected: false, isHidden: true))
        settingsModelArray.append(SettingsDataModel(title: ConstantTexts.logoutLT, subtitle: String(), isSelected: false, isHidden: true))
        settingsModelArray.append(SettingsDataModel(title: ConstantTexts.delAccountLT, subtitle: String(), isSelected: false, isHidden: true))
        
        
        tblSettings.separatorStyle = .none
        tblSettings.isScrollEnabled = false
        
        tblSettings.reloadData()
    }
    
    
    //TODO: api for sign up
    internal func changeNotificationStatusApi(){
        let headers = ["authorization":token,
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.notificationUpdate, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            self.notificationStatus = !self.notificationStatus
            
            let realm = try! Realm()
            do{
                try realm.write {
                    if let user = realm.objects(UserDataModel.self).first{
                        user.notificationStatus  = self.notificationStatus ? "1" : "0"

                    }
                }
            }catch{
                print("Error in saving data :- \(error.localizedDescription)")
            }
            
            
            
            if let message = response.message{
                HHelper.showAlert(message)
            }
            
        }.catch { (error) in
            
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            let nsError = error as NSError
            if let message = nsError.userInfo["errorMessage"] as? String{
                if message == "Unauthorised user"{
                    _ = SweetAlert().showAlert(APP_NAME, subTitle: message, style: AlertStyle.error, buttonTitle: ConstantTexts.okBT, action: { (okButton) in
                        super.deleteUserAuto {
                            UIApplication.shared.applicationIconBadgeNumber = 0
                            let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
                            let navController = UINavigationController(rootViewController: vc)
                            navController.navigationBar.isHidden = true
                            kAppDelegate.window?.rootViewController = navController
                            kAppDelegate.window?.makeKeyAndVisible()
                        }
                    })
                }else{
                    HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
                }
            }
            
        }
        
    }
    
    
}
