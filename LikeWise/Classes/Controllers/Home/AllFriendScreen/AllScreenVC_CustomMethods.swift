//
//  AllScreenVC_CustomMethods.swift
//  LikeWise
//
//  Created by Deepti Sharma on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


//MARK: - Extension Custom methods
extension AllScreenVC{
    
   
    
    
    //TODO: Initial setup method
    internal func initialSetup(){
       
        tblAllFriends.hideEmptyCells()
        tblAllFriends.separatorStyle = .none
        tblAllFriends.backgroundColor = AppColor.clearColor
        tblAllFriends.register(nib: AllFriendsTableViewCell.className)
        self.tblAllFriends.addSubview(self.refreshControl)
        self.tblAllFriends.dataSource = self
        self.tblAllFriends.delegate = self
        self.tblAllFriends.reloadData()
        NotificationCenter.default.addObserver(self,selector:#selector(CompletedVC.reloadTable(_:)),name:NSNotification.Name(rawValue: "TBL_RELOAD"),object: nil)
        
        if let isGuest = UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool{
            if isGuest{
                print("do nothing...")
            }else{
                allFriendsApi()
            }
        }else{
             allFriendsApi()
        }
        
        
        
    }
    
    
    
    
    //TODO: api for sign up
    internal func allFriendsApi(){
        
        let realm = try! Realm()
        var token = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        userModel.gameType = "3"
        let headers = [ "authorization":token,
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.myMatch, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            if self.tempArrayCount.count > 0{
                self.tempArrayCount.removeAll()
            }
            if let dataArray = response.resultArray{
                for item in dataArray{
                    if let itemDict = item as? NSDictionary{
                        let modelItem = FriendsCommanDataModel(room_id: String(), sender_id: String(), game_id: String(), profilePic: String(), receiver_id: String(), name: String(), createdAt: String(), user_type: Int(), key: String(), PointTotalMatchPersantege: Double(), count: Int())
                        
                        if let detailsDict = itemDict.value(forKey: "details") as? NSDictionary{
                            if let PointTotalMatchPersantege = detailsDict.value(forKey: "PointTotalMatchPersantege") as? Double{
                                modelItem.PointTotalMatchPersantege = PointTotalMatchPersantege
                            }
                            
                            if let count = detailsDict.value(forKey: "count") as? Int{
                                modelItem.count = count
                            }
                            
                        }
                        
                        if let room_id = itemDict.value(forKey: "room_id") as? String{
                            modelItem.room_id = room_id
                        }
                        
                        if let sender_id = itemDict.value(forKey: "sender_id") as? String{
                            modelItem.sender_id = sender_id
                        }
                        
                        if let game_id = itemDict.value(forKey: "game_id") as? String{
                            modelItem.game_id = game_id
                        }
                        
                        if let profilePic = itemDict.value(forKey: "profilePic") as? String{
                            modelItem.profilePic = profilePic
                        }
                        
                        if let receiver_id = itemDict.value(forKey: "receiver_id") as? String{
                            modelItem.receiver_id = receiver_id
                        }
                        
                        if let name = itemDict.value(forKey: "name") as? String{
                            modelItem.name = name
                        }
                        
                        if let createdAt = itemDict.value(forKey: "createdAt") as? String{
                            modelItem.createdAt = createdAt
                        }
                        
                        if let user_type = itemDict.value(forKey: "user_type") as? Int{
                            modelItem.user_type = user_type
                        }
                        
                        if let key = itemDict.value(forKey: "key") as? String{
                            modelItem.key = key
                        }
                        self.tempArrayCount.append(modelItem)
                    }
                    
                }
                
               
            }
            
            
            
           self.tblAllFriends.reloadData()
           
            
        }.catch { (error) in
            
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            
            let nsError = error as NSError
            if let message = nsError.userInfo["errorMessage"] as? String{
                if message == "Unauthorised user"{
                    _ = SweetAlert().showAlert(APP_NAME, subTitle: message, style: AlertStyle.error, buttonTitle: ConstantTexts.okBT, action: { (okButton) in
                        super.deleteUserAuto {
                            UIApplication.shared.applicationIconBadgeNumber = 0
                            let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
                            self.navigationController?.pushViewController(vc, animated: true)
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

