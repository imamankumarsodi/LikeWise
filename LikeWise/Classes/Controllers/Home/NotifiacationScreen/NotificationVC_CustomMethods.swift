//
//  NotificationVC_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 27/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import SocketIO
import RealmSwift
import Alamofire


//MARK: - Extension Custom methods
extension NotificationVC{
    
    //TODO: Initial setup method
    internal func initialSetup(){
        CustomMethods.shared.screenName = NotificationVC.className
        CustomMethods.shared.provideCornerRadiusTo(self.viewBG, 20,[.layerMinXMinYCorner,.layerMaxXMinYCorner])
        lblHeading.font = ConstantFonts.SubmitButtonFont
        lblHeading.textColor = AppColor.textColor
        lblHeading.text = ConstantTexts.notificationLT
        self.viewSeprator.backgroundColor = AppColor.placeholderColor
        
        tblNoti.registerMultiple(nibs: [NotificationTableViewCell.className,NotificationCell_Simple.className])
        tblNoti.hideEmptyCells()
        tblNoti.separatorStyle = .none
        tblNoti.backgroundColor = AppColor.clearColor
        
        socket = socketManager.defaultSocket
        checkSocketConnection()
        socketHandling()
        
        kAppDelegate.callBack = { [weak self] in
            self?.socketHandling()
        }
        
        
        
        
        
        
    }
    
    
}


//MARK: - Socket Handling

extension NotificationVC{
    
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
    
    internal func emitFirstTime(){
        
        //TODO: Emit for first time
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            if self.forFirstTimeOnly{
                self.forFirstTimeOnly = false
                let realm = try! Realm()
                var userId = String()
                do{
                    if let user = realm.objects(UserDataModel.self).first{
                        userId = user._id
                        print(userId)
                    }
                }catch{
                    print("Error in saving data :- \(error.localizedDescription)")
                }
                CustomMethods.shared.showLoaderPresent(view: self.view)
                self.socket.emit("Notification_list", ["_id": userId])
            }
            
        }
        
        
        //TODO: Get callback for notification list
        socket.on("Notification_list") { (data, ack) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print("Notification list")
            print(data)
            if self.notificationList.count > 0{
                self.notificationList.removeAll()
            }
            if let listArray = data as? NSArray{
                
                if listArray.count > 0{
                    if let listDictArray = listArray[0] as? NSDictionary{
                        print(listDictArray)
                        if let listNewArray = listDictArray.value(forKey: "list") as? NSArray{
                            
                            for item in listNewArray{
                                if let dataDict = item as? NSDictionary{
                                    let MorereciselyItem = NotificationDataModel(name: String(), description: String(), __v: String(), _id: String(), gameId: String(), profilePic: String(), createdAt: String(), userId: String(), receiverId: String(), type: String(), status: String(), startDate: Date(),endDate: Date())
                                    
                                    
                                    if let name = dataDict.value(forKey: "fullName") as? String{
                                        MorereciselyItem.name = name
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
                                    
                                    if let gameId = dataDict.value(forKey: "gameId") as? String{
                                        MorereciselyItem.gameId = gameId
                                    }
                                    
                                    if let profilePic = dataDict.value(forKey: "profilePic") as? String{
                                        MorereciselyItem.profilePic = profilePic
                                    }
                                    
                                    if let userId = dataDict.value(forKey: "userId") as? String{
                                        MorereciselyItem.userId = userId
                                    }
                                    
                                    
                                    if let receiverId = dataDict.value(forKey: "receiverId") as? String{
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
                                    self.notificationList.append(MorereciselyItem)
                                    
                                }
                            }
                        }
                    }
                }
                
                
                self.tblNoti.reloadData()
                
            }
            
        }
        
    }
    
    
    internal func socketHandling() {
        
        emitFirstTime()
        
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
    
    
    internal func accept_rejectSocket(_ eventName: String, _ index:Int){
        let realm = try! Realm()
        var userId = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                userId = user._id
                
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        //"sender_id":"5eabbae2faf8d0201ded32ac","receiver_id":"5ead175cd46a724b7e678904","game_id":"5eaff2db262edf4c2a181b41","read_status":true,"createdAt":"2020-05-04T10:48:16.832Z","status":true,"type":"2"}
        
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        self.socket.emit(eventName, ["sender_id": userId,"receiver_id":notificationList[index].userId,"game_id":notificationList[index].gameId,"_id":notificationList[index]._id,"read_status":true,"status":true,"type":notificationList[index].type])
        
        
        
        
        //TODO: Get callback for notification list
        socket.on(eventName) { (data, ack) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print("event name")
            print(data)
            
            if eventName == "accept"{
                self.roomCreateSocket(index)
            }else{
                print("Do nothing...")
                self.notificationList[index].status = "4"
                self.tblNoti.reloadData()
            }
            
            
            
        }
        
        
    }
    
    internal func roomCreateSocket(_ index:Int){
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
        
        userModel.sender_id = userId
        userModel.receiver_id = notificationList[index].userId
        userModel.game_id = notificationList[index].gameId
        self.userModel.room_status = true
        
        
        let headers:HTTPHeaders = ["Content-Type":"application/json","authorization":token]
        
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.roomCreate, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            
            if let dataDict = response.resultDict as? NSDictionary{
                
                if let room_id = dataDict.value(forKey: "room_id") as? String{
                    print(room_id)
                    self.dismiss(animated: true) {
                        
                        let viewController = AppStoryboard.chat.instantiateViewController(withIdentifier: ChatVC.className) as! ChatVC
                        
                        // viewController.isComingLives = true
                        viewController.room_id = room_id
                        
                        if self.self.notificationList[index].type == "2"{
                            if let receiver_id = response.resultDict?.value(forKey: "sender_id") as? String{
                                print(receiver_id)
                                viewController.receiver_id = receiver_id
                            }
                            viewController.item = self.notificationList[index]
                        }else{
                            
                            if let receiver_id = response.resultDict?.value(forKey: "receiver_id") as? String{
                                print(receiver_id)
                                viewController.receiver_id = receiver_id
                            }
                            
                            if let sender_id = response.resultDict?.value(forKey: "sender_id") as? String{
                                self.notificationList[index].userId = sender_id
                            }
                            
                            viewController.item = self.notificationList[index]
                            
                        }
                        
                        
                        
                        
                        
                        let navigationController = UINavigationController(rootViewController: viewController)
                        navigationController.navigationBar.isHidden = true
                        APPLICATION.keyWindow?.rootViewController = navigationController
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
    
    
    
    /*  internal func roomCreateSocketForCreate(_ item:NotificationDataModel){
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
     
     userModel.sender_id = userId
     userModel.receiver_id = item.receiverId
     userModel.game_id = item.gameId
     self.userModel.room_status = true
     
     let headers:HTTPHeaders = ["Content-Type":"application/json","authorization":token]
     
     
     SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.roomCreate, header: headers).done{(response) -> Void  in
     CustomMethods.shared.hideLoaderPresent(view: self.view)
     print(response)
     
     if let dataDict = response.resultDict as? NSDictionary{
     
     if let room_id = dataDict.value(forKey: "room_id") as? String{
     
     self.dismiss(animated: true) {
     
     let viewController = AppStoryboard.chat.instantiateViewController(withIdentifier: ChatVC.className) as! ChatVC
     
     // viewController.isComingLives = true
     
     if let receiver_id = response.resultDict?.value(forKey: "receiver_id") as? String{
     print(receiver_id)
     viewController.receiver_id = receiver_id
     }
     
     viewController.room_id = room_id
     viewController.item = item
     
     let navigationController = UINavigationController(rootViewController: viewController)
     navigationController.navigationBar.isHidden = true
     APPLICATION.keyWindow?.rootViewController = navigationController
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
     
     
     } */
    
    
    /*  internal func acceptInvite(){
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
     MorereciselyItem.name = name
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
     MorereciselyItem.profilePic = profilePic
     }
     
     if let userId = dataDict.value(forKey: "sender_id") as? String{
     MorereciselyItem.userId = userId
     }
     
     
     if let receiverId = dataDict.value(forKey: "receiver_id") as? String{
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
     } */
}

