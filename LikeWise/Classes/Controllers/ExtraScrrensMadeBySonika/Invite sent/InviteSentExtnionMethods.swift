//
//  InviteSentExtnionMethods.swift
//  LikeWise
//
//  Created by cst on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import SocketIO
import RealmSwift
import Alamofire

extension InviteSentViewController{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    internal func initialSetUp(){
        
        lblHeadingRef.font = ConstantFonts.SubmitButtonFont
        lblHeadingRef.textColor = AppColor.whiteColor
        lblHeadingRef.text = ConstantTexts.PartnerFoundLT
        
        let myMutableString = NSMutableAttributedString()
        
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(selectedFriend.name)\n", font: ConstantFonts.TextFieldFont, AppColor.textColor))
        
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.HasLT, font: ConstantFonts.TextFieldFont, AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:"\(90)", font: ConstantFonts.TextFieldFont, AppColor.errorColor))
        
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.SecondsleftLT, font: ConstantFonts.TextFieldFont, AppColor.textColor))
        infoLbl.attributedText = myMutableString
        
        imgProfile.sd_setImage(with: URL(string: selectedFriend.profilePic), placeholderImage: UIImage(named: "default_pic"))
        
        
        CustomMethods.shared.provideCornerRadiusTo(imgProfile, 20, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        CustomMethods.shared.provideCornerBorderTo(imgProfile, 2, AppColor.whiteColor)
        
        btnNavRef.isHidden = true
        
        socket = socketManager.defaultSocket
        checkSocketConnection()
        
        socketHandling()
        
    }
    
}


//MARK: - Socket Handling

extension InviteSentViewController{
    
    internal func checkSocketConnection(){
        let socketConnectionStatus = socket.status
        switch socketConnectionStatus {
        case SocketIOStatus.connected:
            print("socket connected")
            
        case SocketIOStatus.connecting:
            print("socket connecting")
            
        case SocketIOStatus.disconnected:
            print("socket disconnected")
            socket.connect()
            
        case SocketIOStatus.notConnected:
            print("socket not connected")
            socket.connect()
            
        }
    }
    
    internal func socketDisconnect(){
          let socketConnectionStatus = socket.status
          switch socketConnectionStatus {
          case SocketIOStatus.connected:
              print("socket connected")
              socket.disconnect()
              
          case SocketIOStatus.connecting:
              print("socket connecting")
              socket.disconnect()
              
          case SocketIOStatus.disconnected:
              print("socket disconnected")
              
              
          case SocketIOStatus.notConnected:
              print("socket not connected")
              
              
          }
      }
    
    internal func socketHandling() {
        acceptInvite()
    }
    
    internal func acceptInvite(){
        //TODO: Get callback for notification list
        socket.on("accept") { (data, ack) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print("Accept Invite")
            // accept_rejectSocket("accept", sender.tag)
            print(data)
            
            if let listArray = data as? NSArray{
                if listArray.count > 0{
                    if let listDictArray = listArray[0] as? NSDictionary{
                        print(listDictArray)
                        if let dataDict = listDictArray.value(forKey: "dataTosave") as? NSDictionary{
                            let MorereciselyItem = NotificationDataModel(name: String(), description: String(), __v: String(), _id: String(), gameId: String(), profilePic: String(), createdAt: String(), userId: String(), receiverId: String(), type: String(), status: String(), startDate: Date(),endDate: Date())
                            
                            
                            if let name = dataDict.value(forKey: "fullName") as? String{
                                MorereciselyItem.name = self.selectedFriend.name
                            }
                            
                            if let description = dataDict.value(forKey: "description") as? String{
                                MorereciselyItem.description = description
                            }
                            
                            
                            if let __v = dataDict.value(forKey: "__v") as? String{
                                MorereciselyItem.__v = __v
                            }
                            
                            if let _id = dataDict.value(forKey: "_id") as? String{
                                MorereciselyItem._id = _id
                            }
                            
                            if let gameId = dataDict.value(forKey: "game_id") as? String{
                                MorereciselyItem.gameId = gameId
                            }
                            
                            if let profilePic = dataDict.value(forKey: "profilePic") as? String{
                                MorereciselyItem.profilePic = self.selectedFriend.profilePic
                            }
                            
                            if let userId = dataDict.value(forKey: "receiver_id") as? String{
                                print(userId)
                                MorereciselyItem.userId = userId
                            }
                            
                            
                            if let receiverId = dataDict.value(forKey: "sender_id") as? String{
                                print(receiverId)
                                MorereciselyItem.receiverId = receiverId
                            }
                            
                            
                            if let createdAt = dataDict.value(forKey: "createdAt") as? String{
                                MorereciselyItem.createdAt = createdAt
                            }
                            
                            if let type = dataDict.value(forKey: "type") as? String{
                                MorereciselyItem.type = type
                            }
                            
                            if let status = dataDict.value(forKey: "status") as? String{
                                MorereciselyItem.status = status
                            }
                            
                            self.roomCreateSocketForCreate(MorereciselyItem)
                        }
                    }
                }
            }
        }
        
        
        
        
        //TODO: Get callback for notification list
          socket.on("reject") { (data, ack) in
              CustomMethods.shared.hideLoaderPresent(view: self.view)
            kAppDelegate.checkAutoLogin()
          }
    }
    
    internal func roomCreateSocketForCreate(_ item:NotificationDataModel){
        let realm = try! Realm()
        var userId = String()
        var token = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                userId = user._id
                token = user.jwtToken
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        CustomMethods.shared.showLoaderPresent(view: self.view)
        
        userModel.sender_id = self.receiver_id
        userModel.receiver_id = userId
        userModel.game_id = item.gameId
        self.userModel.room_status = true
        
        let headers:HTTPHeaders = ["Content-Type":"application/json","authorization":token]
        
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.roomCreate, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            
            if let dataDict = response.resultDict as? NSDictionary{
                
                if let room_id = dataDict.value(forKey: "room_id") as? String{
                    
                    self.timerCount = 90
                    self.timer?.invalidate()
                    self.timer = nil
                    
                    let viewController = AppStoryboard.chat.instantiateViewController(withIdentifier: ChatVC.className) as! ChatVC
                    
                    // viewController.isComingLives = true
                    item.name = self.selectedFriend.name
                    item.profilePic = self.selectedFriend.profilePic
                    print(self.selectedFriend.name)
                    print(self.selectedFriend.profilePic)
                    viewController.room_id = room_id
                    
                    viewController.item = item
                    viewController.receiver_id = self.receiver_id
                
                    
                    let navigationController = UINavigationController(rootViewController: viewController)
                    navigationController.navigationBar.isHidden = true
                    APPLICATION.keyWindow?.rootViewController = navigationController
                    
                    
                    
                    
              
                    
                    
                    
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
