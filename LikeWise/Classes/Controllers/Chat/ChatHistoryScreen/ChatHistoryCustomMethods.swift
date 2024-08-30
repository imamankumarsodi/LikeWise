//
//  ChatHistoryCustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 05/05/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift
extension ChatHistoryVC{
    
    internal func initialSetup(){
        
        lblPoints.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblPoints.textColor = AppColor.whiteColor
        
        CustomMethods.shared.provideCornerRadiusTo(self.viewPointBG, self.viewPointBG.frame.size.height/2,[.layerMinXMinYCorner,.layerMinXMaxYCorner])
        viewPointBG.backgroundColor = AppColor.themeColorDark
        viewPointBG.alpha = 0.80
        
        lblUserName.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblUserName.textColor = AppColor.whiteColor
        
        CustomMethods.shared.provideCornerRadiusTo(self.imgUser, 10,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerBorderTo(self.imgUser, 2, AppColor.whiteColor)
        
        collectionLife.register(nib: ChatHistoryCollectionViewCell.className)
        collectionLife.backgroundColor = AppColor.clearColor
        getUserData()
        
    }
    
    
    func getUserData(){
        do{
            if let user = realm.objects(UserDataModel.self).first{
                CustomMethods.shared.setupButton(btnCoinCountRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), " \(Int(round(user.coins)))")
                
                lblPoints.text = (user.totalPoints == Double()) ? "0" : "\(Int(round(user.totalPoints)))"
               // lblUserName.text = "  \(user.name)"
                
               // imgUser.sd_setImage(with: URL(string: user.profilePic), placeholderImage: UIImage(named: "profile_pic"))
                
                chatDataApi()
                
            }
            
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }
    
    
    
    
    internal func chatDataApi(){
        
        var token = String()
        var sender_id = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
                sender_id = user._id
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        let headers = ["authorization":token,
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        userModel.room_id = self.room_id
        userModel.sender_id = sender_id
        userModel.receiver_id = reciever_id
        
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.chatData, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            if self.ParentMessageDataModeForShowArray.count > 0{
                self.ParentMessageDataModeForShowArray.removeAll()
            }
            
            if let resDict = response.resultDict{
                
                if let receiver_details = resDict.value(forKey: "receiver_details") as? NSDictionary{
                    if let name = receiver_details.value(forKey: "name") as? String{
                        self.lblUserName.text = "  \(name)"
                                     
                    }
                    
                    if let profilePic = receiver_details.value(forKey: "profilePic") as? String{
                        self.imgUser.sd_setImage(with: URL(string: profilePic), placeholderImage: UIImage(named: "profile_pic"))
                    }
                    
                }
                
                
                if let userDetails = resDict.value(forKey: "userDetails") as? NSDictionary{
                    
                    
                    if let languageCode = resDict.value(forKey: "code") as? String{
                        CustomMethods.shared.setupButton(self.btnCountryDetailRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), " \(languageCode)")
                        
                    }

                    
                    if let picture = userDetails.value(forKey: "picture") as? String{
                        
                        DispatchQueue.global(qos: .background).async {
                            do
                            {
                                let data = try Data.init(contentsOf: URL.init(string:picture)!)
                                DispatchQueue.main.async {
                                    if let image = UIImage(data: data){
                                        
                                        self.btnCountryDetailRef.setImage(CustomMethods.resizeImage(image: image, targetSize: CGSize(width: 30, height: 30)).rounded(with: AppColor.whiteColor, width: 2), for: .normal)
                                        
                                    }
                                    
                                }
                            }
                            catch {
                                // error
                            }
                        }
                        
                        
                    }
                }
                
                
                
                if let dataArray = resDict.value(forKey: "chatData") as? NSArray{
                    for item in dataArray{
                        if let listDictArray = item as? NSDictionary{
                            print(listDictArray)
                            
                            
                            
                            let MorereciselyItem = MessageDataModeForShow(_id: String(), image: String(), game_id: String(), languageCode: String(), createdAt: String(), message: String(), message_Encrypted: String(), read_status: String(), userId: String(), receiver_id: String(), room_id: String(), sender_id: String(), status: String(), type: String(), isMatched: Bool(), isEncryped: true, isMe: Bool(), pointId: Double(), score: Double(), point: Double(), bonus: Double(), streaks: Double(), all_matched: 1.0, wordCount: Int(), card: Int())
                            
                            
                            
                            if let _id = listDictArray.value(forKey: "_id") as? String{
                                MorereciselyItem._id = _id
                            }
                            
                            if let image = listDictArray.value(forKey: "Image") as? String{
                                MorereciselyItem.image = image
                            }
                            
                            if let game_id = listDictArray.value(forKey: "game_id") as? String{
                                MorereciselyItem.game_id = game_id
                            }
                            
                            if let languageCode = listDictArray.value(forKey: "languageCode") as? String{
                                MorereciselyItem.languageCode = languageCode
                            }
                            
                            
                            if let createdAt = listDictArray.value(forKey: "createdAt") as? String{
                                MorereciselyItem.createdAt = createdAt
                            }
                            
                            if let pointId = listDictArray.value(forKey: "pointId") as? String{
                                MorereciselyItem.pointId = Double(pointId) ?? 0.0
                            }
                            
                            
                            if let pointId = listDictArray.value(forKey: "pointId") as? Double{
                                MorereciselyItem.pointId = Double(pointId) ?? 0.0
                            }
                            
                            
                            if let score = listDictArray.value(forKey: "score") as? String{
                                MorereciselyItem.score = Double(score) ?? 0.0
                            }
                            
                            
                            if let score = listDictArray.value(forKey: "score") as? Double{
                                MorereciselyItem.score = Double(score) ?? 0.0
                            }
                            
                            if let point = listDictArray.value(forKey: "point") as? String{
                                MorereciselyItem.point = Double(point) ?? 0.0
                            }
                            
                            
                            if let point = listDictArray.value(forKey: "point") as? Double{
                                MorereciselyItem.point = Double(point) ?? 0.0
                            }
                            
                            if let bonus = listDictArray.value(forKey: "bonus") as? String{
                                MorereciselyItem.bonus = Double(bonus) ?? 0.0
                            }
                            
                            
                            if let bonus = listDictArray.value(forKey: "bonus") as? Double{
                                MorereciselyItem.bonus = Double(bonus) ?? 0.0
                            }
                            
                            
                            if let streaks = listDictArray.value(forKey: "streaks") as? String{
                                MorereciselyItem.streaks = Double(streaks) ?? 0.0
                            }
                            
                            
                            if let streaks = listDictArray.value(forKey: "streaks") as? Double{
                                MorereciselyItem.streaks = Double(streaks) ?? 0.0
                            }
                            
                            
                            if let all_matched = listDictArray.value(forKey: "all_matched") as? String{
                                MorereciselyItem.all_matched = Double(all_matched) ?? 0.0
                            }
                            
                            
                            if let all_matched = listDictArray.value(forKey: "all_matched") as? Double{
                                MorereciselyItem.all_matched = Double(all_matched) ?? 0.0
                            }
                            
                            
                            
                            if let card = listDictArray.value(forKey: "card") as? String{
                                MorereciselyItem.card = Int(card) ?? 0
                            }
                            
                            if let card = listDictArray.value(forKey: "card") as? Int{
                                MorereciselyItem.card = card
                            }
                            
                            
                            if let isMatched = listDictArray.value(forKey: "isMatched") as? String{
                                
                                if isMatched == "0"{
                                    MorereciselyItem.isMatched = false
                                }else{
                                   MorereciselyItem.isMatched = true
                                }
                                
                                
                                
                            }
                            
                            if let isMatched = listDictArray.value(forKey: "isMatched") as? Int{
                                
                                if isMatched == 0{
                                    MorereciselyItem.isMatched = false
                                }else{
                                   MorereciselyItem.isMatched = true
                                }
                                
                                
                                
                            }
                            
                            if let isMatched = listDictArray.value(forKey: "isMatched") as? Bool{
                                MorereciselyItem.isMatched = isMatched
                                 
                            }
                            
                            
                            
                            let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
                            let components = MorereciselyItem.message.components(separatedBy: chararacterSet)
                            let words = components.filter { !$0.isEmpty }
                            
                            MorereciselyItem.wordCount = words.count
                            
                            
                            if let message = listDictArray.value(forKey: "message") as? String{
                                MorereciselyItem.message = message
                                MorereciselyItem.message_Encrypted = message
                            }
                            
                            if let read_status = listDictArray.value(forKey: "read_status") as? String{
                                MorereciselyItem.read_status = read_status
                            }
                            
                            if let read_status = listDictArray.value(forKey: "read_status") as? Int{
                                MorereciselyItem.read_status = "\(read_status)"
                            }
                            
                            if let receiver_id = listDictArray.value(forKey: "receiver_id") as? String{
                                print(receiver_id)
                                MorereciselyItem.receiver_id = receiver_id
                            }
                            
                            if let room_id = listDictArray.value(forKey: "room_id") as? String{
                                MorereciselyItem.room_id = room_id
                            }
                            
                            if let sender_id = listDictArray.value(forKey: "sender_id") as? String{
                                print(sender_id)
                                MorereciselyItem.sender_id = sender_id
                                MorereciselyItem.userId = sender_id
                            }
                            
                            if let status = listDictArray.value(forKey: "status") as? String{
                                MorereciselyItem.status = status
                            }
                            
                            if let status = listDictArray.value(forKey: "status") as? Int{
                                MorereciselyItem.status = "\(status)"
                            }
                            
                            if let type = listDictArray.value(forKey: "type") as? String{
                                MorereciselyItem.type = type
                            }
                            
                            if let type = listDictArray.value(forKey: "type") as? Int{
                                MorereciselyItem.type = "\(type)"
                            }
                            
                            if sender_id == MorereciselyItem.sender_id{
                                MorereciselyItem.isMe = true
                            }
                            
                            
                            if let read_status = listDictArray.value(forKey: "read_status") as? Int{
                                MorereciselyItem.read_status = "\(read_status)"
                            }
                            
                            if let receiver_id = listDictArray.value(forKey: "receiver_id") as? String{
                                print(receiver_id)
                                MorereciselyItem.receiver_id = receiver_id
                            }
                            
                            
                         
                            if self.ParentMessageDataModeForShowArray.count == 0{
                            
                                let p_dataItem = ParentMessageDataModeForShow(Image: MorereciselyItem.image, card: MorereciselyItem.card, MessageDataModeForShowArray: [MessageDataModeForShow]())
                                p_dataItem.MessageDataModeForShowArray.append(MorereciselyItem)
                                self.ParentMessageDataModeForShowArray.append(p_dataItem)
                            }else{
                                
                                var flag = Bool()
                                
                                for i in 0..<self.ParentMessageDataModeForShowArray.count{
                                    
                                    if MorereciselyItem.card == self.ParentMessageDataModeForShowArray[i].card{
                                        
                                        flag = true
                                        self.ParentMessageDataModeForShowArray[i].MessageDataModeForShowArray.append(MorereciselyItem)
                                        
                                        break
                                        
                                    }
                                }
                                
                                if flag == false{
                                    
                                    let p_dataItem = ParentMessageDataModeForShow(Image: MorereciselyItem.image, card: MorereciselyItem.card, MessageDataModeForShowArray: [MessageDataModeForShow]())
                                    p_dataItem.MessageDataModeForShowArray.append(MorereciselyItem)
                                    self.ParentMessageDataModeForShowArray.append(p_dataItem)
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionLife.dataSource = self
                        self.collectionLife.delegate = self
                        self.collectionLife.reloadData()
                    }
                    
                }
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
