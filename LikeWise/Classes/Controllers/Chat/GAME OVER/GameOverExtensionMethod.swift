//
//  GameOverExtensionMethod.swift
//  LikeWise
//
//  Created by cst on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SocketIO


extension GameOverViewController{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    internal func initialSetUp(){
        
        lblHeaderTitle.font = ConstantFonts.SubmitButtonFont
        lblHeaderTitle.textColor = AppColor.whiteColor
        lblHeaderTitle.text = ConstantTexts.GameOverLT
        
        
        
        
        lblMatchTitle.font = ConstantFonts.TextFieldFont
        lblMatchTitle.textColor = AppColor.textColor
        lblMatchTitle.text = ConstantTexts.MatchForThisGameLT
        
        lblNamePlayer1.font = ConstantFonts.TextFieldFont
        lblNamePlayer1.textColor = AppColor.textColor
        CustomMethods.shared.provideCornerRadiusTo(self.imgPlayer1, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        imgPlayer1.contentMode = .scaleAspectFill
        
        
        CustomMethods.shared.provideCornerRadiusTo(self.imgPlayer2, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        imgPlayer2.contentMode = .scaleAspectFill
        
        lblPlayer2.font = ConstantFonts.TextFieldFont
        lblPlayer2.textColor = AppColor.textColor
        
        
        lblSpendCoin.font = ConstantFonts.TextFieldFont
        lblSpendCoin.textColor = AppColor.themeColorDark
        
        
        
        lblCoinLeftTitle.font = ConstantFonts.TextFieldFont
        lblCoinLeftTitle.textColor = AppColor.whiteColor
        lblCoinLeftTitle.text = "\(ConstantTexts.CoinLeftLT)"
        
        lblStatusOfGame.font = ConstantFonts.TextFieldFont
        lblStatusOfGame.textColor = AppColor.textColor
        lblStatusOfGame.text = ConstantTexts.StatsForThisGameLT
        
        
        tblView.register(nib: SettingsTableViewCell.className)
        tblView.tableFooterView = UIView()
        
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.matchOfGameView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.spendCoinView, 22.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.getCoinView, 22.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.statusView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        
        lblProgPer.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblProgPer.textColor = AppColor.textColor
        
        
        // MARK: - init and setup DYPieChartView
        pieChartView.startAngle = -.pi / 2
        pieChartView.clockwise = true
        pieChartView.lineWidth = 5
        
        pieChartView.sectorColors = [
            AppColor.themeColorDark,
            AppColor.placeholderColor
        ]
        
        
        socket = socketManager.defaultSocket
        checkSocketConnection()
        socketHandling()
        
    }
    
    
    
    
    
    //TODO: api for createRoomtApi
    internal func gameOvertApi(){
        
        let realm = try! Realm()
        var token = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        let headers = ["authorization":token,
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        userModel.room_id = self.room_id
        CustomMethods.shared.showLoaderPresent(view: self.view)
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.gameOver, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            if let responseDict = response.resultDict{
                print(responseDict)
                if self.settingsModelArray.count > 0{
                    self.settingsModelArray.removeAll()
                }
                if let LikeWisePersantege = responseDict.value(forKey: "LikeWisePersantege") as? Double{
                    
                    let likeWisePer = Double(LikeWisePersantege)/100.0
                    
                    self.pieChartView.animate(toScaleValues: [NSNumber(value: likeWisePer),NSNumber(value: 1.0 - likeWisePer)], duration: 2)
                    
                    self.lblProgPer.text = "\(Int(round(LikeWisePersantege)))\(ConstantTexts.PerLT)"
                }
                
                if let TotalMessage = responseDict.value(forKey: "TotalMessage") as? Int{
                    self.settingsModelArray.append(SettingsDataModel(title: ConstantTexts.MatchedEntriesLT, subtitle: "\(TotalMessage)\(ConstantTexts.PerLT)", isSelected: true, isHidden: true))
                }
                
                if let TotalMatch = responseDict.value(forKey: "TotalMatch") as? Int{
                    self.settingsModelArray.append(SettingsDataModel(title: ConstantTexts.MatchedWordsLT, subtitle: "\(TotalMatch)\(ConstantTexts.PerLT)", isSelected: true, isHidden: true))
                }
                
                
                if let followerDetailArray = responseDict.value(forKey: "followerDetail") as? NSArray{
                    
                    if followerDetailArray.count > 0{
                        
                        if let followerDetail = followerDetailArray[0] as? NSDictionary{
                            
                            if let pointMax = followerDetail.value(forKey: "pointMax") as? Int{
                                
                                // *** Create instance of `NSMutableParagraphStyle`
                                let paragraphStyle = NSMutableParagraphStyle()
                                
                                // *** set LineSpacing property in points ***
                                paragraphStyle.lineSpacing = 0 // Whatever line spacing you want in points
                                self.lblPointsTitle.numberOfLines = 0
                                var  myMutableStringNew = NSMutableAttributedString()
                                myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(pointMax)", font:  AppFont.bold.size(AppFontName.SegoeUI, size: 30), AppColor.whiteColor))
                                myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.PointsLT)", font:  AppFont.semibold.size(AppFontName.SegoeUI, size: 12), AppColor.whiteColor))
                                
                                // *** Apply attribute to string ***
                                myMutableStringNew.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableStringNew.length))
                                paragraphStyle.alignment = .center
                                self.lblPointsTitle.attributedText = myMutableStringNew
                                
                            }
                            
                            
                            if let sumStreaks = followerDetail.value(forKey: "sumStreaks") as? Int{
                                self.settingsModelArray.append(SettingsDataModel(title: ConstantTexts.StreaksLT, subtitle: "\(ConstantTexts.PlusLT)\(sumStreaks)\(ConstantTexts.PerLT)", isSelected: true, isHidden: true))
                            }
                            
                        }
                        
                    }
                }
                
                if let Unicity = responseDict.value(forKey: "Unicity") as? Int{
                    self.settingsModelArray.append(SettingsDataModel(title: ConstantTexts.UnicilyLT, subtitle: "\(Unicity)\(ConstantTexts.PerLT)", isSelected: true, isHidden: true))
                }
                
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
                
                
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


extension GameOverViewController{
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
    
    internal func emitFirstTime(){
        
        //TODO: Emit for first time
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            if self.forFirstTimeOnly{
                self.forFirstTimeOnly = false
            }
            
        }
        
        
    }
    
    
    internal func socketHandling() {
        
        emitFirstTime()
        spendCoinCallBack()
        
    }
    
    
    internal func spendCoins(){
        let realm = try! Realm()
        var userId = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                userId = user._id
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        CustomMethods.shared.showLoaderPresent(view: self.view)
        self.socket.emit("coin_dedicated", ["_id": userId])
    }
    
    
    
    
    internal func spendCoinCallBack(){
        
        
        //TODO: Get callback for notification list
        socket.on("coin_dedicated") { (data, ack) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print("coin_dedicated")
            print(data)
            
            if let listArray = data as? NSArray{
                
                if listArray.count > 0{
                    if let listDictArray = listArray[0] as? NSDictionary{
                        if let senderId = listDictArray.value(forKey: "senderId") as? String{
                            print(senderId)
                        }
                        
                        if let coins = listDictArray.value(forKey: "coins") as? Int{
                            do{
                                try self.realm.write {
                                    if let user = self.realm.objects(UserDataModel.self).first{
                                        user.coins = Double(coins)
                                        CustomMethods.shared.setupButton(self.btnCoinleft, AppColor.whiteColor, AppColor.clearColor, ConstantFonts.TextFieldFont, "\(Int(round(user.coins)))")
                                         let vc = AppStoryboard.chat.instantiateViewController(withIdentifier: ChatHistoryVC.className) as! ChatHistoryVC
                                        vc.room_id = self.room_id
                                        vc.reciever_id = self.reciever_id
                                        self.navigationController?.pushViewController(vc, animated: true)
                                        
                                    }
                                }
                            }catch{
                                print("Error in saving data :- \(error.localizedDescription)")
                            }
                        }
                        
                        
                    }
                }
                
            }
            
            
            
            
        }
    }
    
    
    
    
    
}
