//
//  CompletedVC_CustomMethods.swift
//  LikeWise
//
//  Created by Deepti Sharma on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


//MARK: - Extension Custom methods
extension CompletedVC{
    
    
    
    
    //TODO: Initial setup method
    internal func initialSetup(){
        
        tblAllFriends.hideEmptyCells()
        tblAllFriends.separatorStyle = .none
        tblAllFriends.backgroundColor = AppColor.clearColor
        tblAllFriends.registerMultiple(nibs: [Current_TableViewCell.className,AllFriendsTableViewCell.className])
        self.tblAllFriends.addSubview(self.refreshControl)
        NotificationCenter.default.addObserver(self,selector:#selector(CompletedVC.reloadTable(_:)),name:NSNotification.Name(rawValue: "TBL_RELOAD"),object: nil)
        
        if let isGuest = UserDefaults.standard.value(forKey: "IS_GUEST") as? Bool{
            chatUserListCurrentApi(false)
        }
    }
    
    
    
    
    //TODO: api for sign up
    internal func chatUserListCurrentApi(_ status:Bool){
        
        let realm = try! Realm()
        var token = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        self.userModel.statusBool = status
        let headers = ["authorization":token,
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.chatUserList, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            if self.tempArrayCount.count > 0{
                self.tempArrayCount.removeAll()
            }
            if let dataArray = response.resultArray as? NSArray{
                for item in dataArray{
                    if let itemDict = item as? NSDictionary{
                        let modelItem = CurrentGameDataModel(_id: String(), description: String(), createdAt: String(), current_card: Int(), game_id: String(), lang_id: String(), lang_code: String(), lang_description: String(), lang_language: String(), lang_picture: String(), lang_status: Int(), lives: Int(), mode: Int(), morePreciselys: String(), name: String(), objectives: String(), LikeWisePersantege: Int(), PointTotalMatchPersantege: Int(), TotalMatch: Int(), profilePic: String(), receiver_id: String(), room_id: String(), sender_id: String(), user_type: Int(), common_game: "0")
                        
                        
                        
                        if let _id = itemDict.value(forKey: "_id") as? String{
                            modelItem._id = _id
                        }
                        
                        
                        if let description = itemDict.value(forKey: "description") as? String{
                            modelItem.description = description
                        }
                        
                        if let createdAt = itemDict.value(forKey: "createdAt") as? String{
                            modelItem.createdAt = createdAt
                        }
                        
                        if let current_card = itemDict.value(forKey: "current_card") as? String{
                            modelItem.current_card = Int(current_card) as? Int ?? 0
                        }
                        
                        if let current_card = itemDict.value(forKey: "current_card") as? Int{
                            modelItem.current_card = current_card
                        }
                        
                        if let game_id = itemDict.value(forKey: "game_id") as? String{
                            modelItem.game_id = game_id
                        }
                        
                        
                        if let languageDetails = itemDict.value(forKey: "languageDetails") as? NSDictionary{
                            if let _id = languageDetails.value(forKey: "_id") as? String{
                                modelItem.lang_id = _id
                            }
                            
                            if let code = languageDetails.value(forKey: "code") as? String{
                                modelItem.lang_code = code
                            }
                            
                            if let description = languageDetails.value(forKey: "description") as? String{
                                modelItem.lang_description = description
                            }
                            
                            if let language = languageDetails.value(forKey: "language") as? String{
                                modelItem.lang_language = language
                            }
                            
                            if let picture = languageDetails.value(forKey: "picture") as? String{
                                modelItem.lang_picture = picture
                            }
                            
                            if let status = languageDetails.value(forKey: "status") as? String{
                                modelItem.lang_status = Int(status) as? Int ?? 0
                            }
                            
                            if let status = languageDetails.value(forKey: "status") as? Int{
                                modelItem.lang_status = status
                            }
                            
                        }
                        
                        
                        if let lives = itemDict.value(forKey: "lives") as? String{
                            modelItem.lives = Int(lives) as? Int ?? 0
                        }
                        
                        if let lives = itemDict.value(forKey: "lives") as? Int{
                            modelItem.lives = lives
                        }
                        
                        if let mode = itemDict.value(forKey: "mode") as? String{
                            modelItem.mode = Int(mode) as? Int ?? 0
                        }
                        
                        if let mode = itemDict.value(forKey: "mode") as? Int{
                            modelItem.mode = mode
                        }
                        
                        
                        if let morePreciselys = itemDict.value(forKey: "morePreciselys") as? String{
                            modelItem.morePreciselys = morePreciselys
                        }
                        
                        if let name = itemDict.value(forKey: "name") as? String{
                            modelItem.name = name
                        }
                        
                        if let objectives = itemDict.value(forKey: "objectives") as? String{
                            modelItem.objectives = objectives
                        }
                        
                        if let pointDetails = itemDict.value(forKey: "pointDetails") as? NSDictionary{
                            if let LikeWisePersantege = pointDetails.value(forKey: "LikeWisePersantege") as? String{
                                modelItem.LikeWisePersantege = Int(LikeWisePersantege) as? Int ?? 0
                            }
                            
                            if let LikeWisePersantege = pointDetails.value(forKey: "LikeWisePersantege") as? Int{
                                modelItem.LikeWisePersantege = LikeWisePersantege
                            }
                            
                            if let PointTotalMatchPersantege = pointDetails.value(forKey: "PointTotalMatchPersantege") as? String{
                                modelItem.PointTotalMatchPersantege = Int(PointTotalMatchPersantege) as? Int ?? 0
                            }
                            
                            if let PointTotalMatchPersantege = pointDetails.value(forKey: "PointTotalMatchPersantege") as? Int{
                                modelItem.PointTotalMatchPersantege = PointTotalMatchPersantege
                            }
                            
                            if let TotalMatch = pointDetails.value(forKey: "TotalMatch") as? String{
                                modelItem.TotalMatch = Int(TotalMatch) as? Int ?? 0
                            }
                            
                            if let TotalMatch = pointDetails.value(forKey: "TotalMatch") as? Int{
                                modelItem.TotalMatch = TotalMatch
                            }
                            
                        }
                        
                        
                        if let profilePic = itemDict.value(forKey: "profilePic") as? String{
                            modelItem.profilePic = profilePic
                        }
                        
                        
                        if let receiver_id = itemDict.value(forKey: "receiver_id") as? String{
                            modelItem.receiver_id = receiver_id
                        }
                        
                        
                        if let room_id = itemDict.value(forKey: "room_id") as? String{
                            modelItem.room_id = room_id
                        }
                        
                        if let sender_id = itemDict.value(forKey: "sender_id") as? String{
                            modelItem.sender_id = sender_id
                        }
                        
                        if let user_type = itemDict.value(forKey: "user_type") as? String{
                            modelItem.user_type = Int(user_type) as? Int ?? 0
                        }
                        
                        if let user_type = itemDict.value(forKey: "user_type") as? Int{
                            modelItem.user_type = user_type
                        }
                        
                        if let common_game = itemDict.value(forKey: "common_game") as? String{
                            modelItem.common_game = common_game
                        }
                        
                        self.tempArrayCount.append(modelItem)
                        
                        print(itemDict)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.tblAllFriends.reloadData()
            }
            
            
            
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
        
        userModel.gameType = "2"
        let headers = ["authorization":token,
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
                        self.tempArrayCount2.append(modelItem)
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
