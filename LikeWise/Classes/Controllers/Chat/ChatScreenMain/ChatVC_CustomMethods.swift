//
//  ChatVC_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 21/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import FSPagerView
import UIKit
import Alamofire
import RealmSwift
import SocketIO
extension ChatVC{
    internal func initialSetup(){
        fsPager_view.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        fsPager_view.transformer = FSPagerViewTransformer(type: .cubic)
        fsPager_view.dataSource = self
        fsPager_view.delegate = self
        fsPager_view.backgroundColor = AppColor.placeholderColor
        fsPager_view.isUserInteractionEnabled = false
        // fsPager_view.automaticSlidingInterval = 2.0
        fsPager_view.isInfinite = true
        
        tblChat.backgroundColor = AppColor.clearColor
        
        lblPoints.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblPoints.textColor = AppColor.whiteColor
        
        CustomMethods.shared.provideCornerRadiusTo(self.viewPointBG, self.viewPointBG.frame.size.height/2,[.layerMinXMinYCorner,.layerMinXMaxYCorner])
        viewPointBG.backgroundColor = AppColor.themeColorDark
        viewPointBG.alpha = 0.80
        
        lblUserName.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblUserName.textColor = AppColor.whiteColor
        
        CustomMethods.shared.provideCornerRadiusTo(self.imgUser, 10,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerBorderTo(self.imgUser, 2, AppColor.whiteColor)
        
        CustomMethods.shared.provideCornerRadiusTo(self.btnInstructionRef, self.btnInstructionRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        btnInstructionRef.backgroundColor = AppColor.whiteColor
        btnInstructionRef.alpha = 0.80
        
        CustomMethods.shared.provideCornerRadiusTo(self.viewPass, self.viewPass.frame.size.height/2,[.layerMinXMinYCorner,.layerMinXMaxYCorner])
        viewPass.backgroundColor = AppColor.whiteColor
        viewPass.alpha = 0.80
        
        lblPass.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0)
        lblPass.textColor = AppColor.textColor
        
        CustomMethods.shared.provideCornerRadiusTo(self.viewDescription, 10,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        viewDescription.backgroundColor = AppColor.whiteColor
        viewDescription.alpha = 0.80
        
        
        
        btnCloseInstructionRef.backgroundColor = AppColor.whiteColor
        CustomMethods.shared.provideCornerRadiusTo(self.btnCloseInstructionRef, self.btnCloseInstructionRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        //For floating view
        
        /*   panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
         viewDescription.isUserInteractionEnabled = true
         viewDescription.addGestureRecognizer(panGesture) */
        
        
        viewMssg.backgroundColor = AppColor.clearColor
        viewMssg.alpha = 0.80
        
        CustomMethods.shared.provideCornerRadiusTo(self.txtMessage, self.txtMessage.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        txtMessage.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        txtMessage.textColor = AppColor.whiteColor
        txtMessage.placeholder = ConstantTexts.messagePH
        txtMessage.placeHolderColor = AppColor.whiteColor
        txtMessage.keyboardType = .default
        txtMessage.backgroundColor = AppColor.chatTfColor
        txtMessage.delegate = self
        
        tblChat.separatorStyle = .none
        tblChat.tableFooterView = UIView()
        tblChat.registerMultiple(nibs: [OpponentMessageCell.className,MyMessageTableViewCell.className])
        
        viewTiming.backgroundColor = AppColor.processColor
        viewTiming.alpha = 0.80
        
        lblTimings.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblTimings.textColor = AppColor.whiteColor
        collectionLife.register(nib: LifeCollectionViewCell.className)
        
        //  isComingLives = true
        
        collectionLife.backgroundColor = AppColor.clearColor
        lblDescription.numberOfLines = 0
        tblTop.constant = viewDescription.frame.size.height + 20
        stopTypingLoader()
        self.viewCeleb.isHidden = true
        self.viewCeleb.backgroundColor = AppColor.clearColor
        self.viewCoin.isHidden = true
        self.viewCoin.backgroundColor = AppColor.clearColor
        hideFieldsOfChangePass()
        
        
        
        
        getUserData()
        
        
        
        
    }
    
    
    
    
    
    
    //TODO: Methods for timer
    internal func stopTimer(){
        heightTimer.constant = 0
        progressCount = 90
        trailingTimer.constant = MAIN_SCREEN_WIDTH
        timer?.invalidate()
        timer = nil
    }
    
    
    
    
    internal func initateTimer(){
        collectionLife.isHidden = true
        lblTimings.isHidden = false
        trailingTimer.constant = 0
        heightTimer.constant = 20
        viewTiming.isHidden = false
        unitSize = MAIN_SCREEN_WIDTH / 90
        
    }
    
    
    //TODO: Methods for Life
    internal func initateLife(){
        
        collectionLife.isHidden = false
        lblTimings.isHidden = true
        collectionLife.reloadData()
        trailingTimer.constant = 0
        heightTimer.constant = 20
        viewTiming.isHidden = false
        unitSize = MAIN_SCREEN_WIDTH / 8
        
        updateLife()
        
    }
    
    
    internal func updateLife(){
        if lifeCount > 0{
            trailingTimer.constant = CGFloat(8-lifeCount) * unitSize
            if lifeCount > 4{
                viewTiming.backgroundColor = AppColor.processColor
            }else if lifeCount <= 4 && lifeCount > 1{
                viewTiming.backgroundColor = AppColor.emailColor
            }else{
                viewTiming.backgroundColor = AppColor.errorColor
            }
        }else{
            stopLife()
        }
        
    }
    
    internal func stopLife(){
        heightTimer.constant = 0
        lifeCount = 0
        trailingTimer.constant = MAIN_SCREEN_WIDTH
    }
    
    
    
    internal func setupValidations(){
        if txtMessage.text!.trimmingCharacters(in: .whitespaces) == "" {
            print("Do nothing...")
            return
        }
        
        if isDuplicate(message: txtMessage.text!.trimmingCharacters(in: .whitespaces)){
            shakeTextField()
        }else{
            
            let type = isComingLives ? "2" : "1"
            sendMessageSocket("message", "\(cardIndex)", item.gameId, room_id, item.userId, txtMessage.text!.trimmingCharacters(in: .whitespaces), type, String(), String(), String(), String(), Bool(), String(), self.languageCode)
        }
        
        
    }
    
    
    internal func isDuplicate(message:String)->Bool{
        var isDuplicate = Bool()
        for index in 0..<self.messages.count{
            
            if(message.caseInsensitiveCompare(self.messages[index].message) == .orderedSame) && self.messages[index].isMe{
                isDuplicate = true
                break
            }
        }
        
        return isDuplicate
        
    }
    
    
    internal  func scrollToBottom(){
        if messages.count > 0{
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                self.tblChat.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    
    
    func getUserData(){
        do{
            if let user = realm.objects(UserDataModel.self).first{
                CustomMethods.shared.setupButton(btnCoinCountRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), " \(Int(round(user.coins)))")
                
                lblPoints.text = (user.totalPoints == Double()) ? "0" : "\(Int(round(user.totalPoints)))"
               
                lblTimings.text = "\(progressCount) sec"
               // lblUserName.text = "  \(user.name)"
               // imgUser.sd_setImage(with: URL(string: user.profilePic), placeholderImage: UIImage(named: "profile_pic"))
                socket = socketManager.defaultSocket
                checkSocketConnection()
                getGameDetailsApi()
                
            }
            
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }
    
    
    
    
    internal func getGameDetailsApi(){
        let headers = ["Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        userModel.game_id = item.gameId
        userModel.receiver_id = self.receiver_id
        
        
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.gameDetails, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            if let dataDict = response.resultDict{
                let myMutableString = NSMutableAttributedString()
                if let morePrecisely = dataDict.value(forKey: "morePrecisely") as? NSDictionary{
                    if let converse = morePrecisely.value(forKey: "converse") as? String{
                        
                        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "Describe", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.themeColorDark))
                        
                        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "   \(converse)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
                        
                        
                        
                        
                    }
                }
                
                if let gameCriteriaExplanations = dataDict.value(forKey: "gameCriteriaExplanations") as? NSDictionary{
                    if let explanation = gameCriteriaExplanations.value(forKey: "explanation") as? String{
                        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\nThe icon depicts the instructions category (\(explanation))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
                    }
                }
                
                self.lblDescription.attributedText = myMutableString
                
                
                self.animateDescriptionView()
                
                if let game_details = dataDict.value(forKey: "game_details") as? NSDictionary{
                    if let mode = game_details.value(forKey: "mode") as? Int{
                        self.isComingLives = (mode == 2) ? true : false
                        
                        if self.isComingLives{
                            self.initateLife()
                        }else{
                            self.initateTimer()
                        }
                    }
                    
                    if let mode = game_details.value(forKey: "mode") as? String{
                        self.isComingLives = (mode == "2") ? true : false
                        
                        if self.isComingLives{
                            self.initateLife()
                        }else{
                            self.initateTimer()
                        }
                    }
                    
                    
                    if self.images.count > 0{
                        self.images.removeAll()
                    }
                    
                    if let images = game_details.value(forKey: "images") as? NSArray{
                        for item in images{
                            if let image = item as? String{
                                self.images.append(image)
                            }
                        }
                        
                        self.lblPass.text = "\(self.passCount)/\(self.images.count) \(ConstantTexts.PassLT)"
                        self.fsPager_view.reloadData()
                    }
                    
                    
                }
                
                
                
                
                
                if let languageDetails = dataDict.value(forKey: "languageDetails") as? NSDictionary{
                    if let languageCode = languageDetails.value(forKey: "code") as? String{
                        CustomMethods.shared.setupButton(self.btnCountryDetailRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), " \(languageCode)")
                        self.languageCode = languageCode
                    }
                    
                    if let picture = languageDetails.value(forKey: "picture") as? String{
                        
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
                
                
                if let receiver_details = dataDict.value(forKey: "receiver_details") as? NSDictionary{
                    if let name = receiver_details.value(forKey: "name") as? String{
                        self.lblUserName.text = "  \(name)"
                                     
                    }
                    
                    if let profilePic = receiver_details.value(forKey: "profilePic") as? String{
                        self.imgUser.sd_setImage(with: URL(string: profilePic), placeholderImage: UIImage(named: "profile_pic"))
                    }
                    
                }
                
                
                self.socketHandling()
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
    
    
    internal func returnChatArray(_ modelArray : [MessageDataModel])->NSMutableArray{
        let chatArray = NSMutableArray()
        for item in modelArray{
            let yourMutableDictionary = NSMutableDictionary()
            yourMutableDictionary["pointId"] = item.pointId
            yourMutableDictionary["score"] = item.score
            yourMutableDictionary["point"] = item.point
            yourMutableDictionary["bonus"] = item.bonus
            yourMutableDictionary["streaks"] = item.streaks
            yourMutableDictionary["isMatched"] = item.isMatched
            yourMutableDictionary["all_matched"] = item.all_matched
            chatArray.add(yourMutableDictionary)
        }
        
        
        print(chatArray)
        
        return chatArray
    }
    
    
}



//MARK: - FSPagerView DataSource and Delegate
extension ChatVC : FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return images.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        let last4 = String(images[index].suffix(4))
        
        if(last4.caseInsensitiveCompare(".gif") == .orderedSame){
            
            DispatchQueue.global(qos: .background).async {
                do
                {
                    
                    DispatchQueue.main.async {
                        let gifURL : String = self.images[index]
                        let imageURL = UIImage.gifImageWithURL(gifURL)
                        let imageView3 = UIImageView(image: imageURL)
                        imageView3.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
                        cell.imageView?.addSubview(imageView3)
                        
                    }
                }
                catch {
                    // error
                }
            }
         
         
         
         }else{
            
         cell.imageView?.sd_setImage(with: URL(string: images[index]), placeholderImage: UIImage(named: "default_pic"))
            
         }
         
        //        cell.imageView?.sd_setImage(with: URL(string: images[index]), placeholderImage: UIImage(named: "default_pic"))

        cardIndex = index
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
        
    }
    
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        
    }
    
}



//MARK: - Socket Handling

extension ChatVC{
    
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
                self.socket.emit("room_join", ["_id": self.room_id])
            }
            
        }
        
        
        //TODO: Get callback for notification list
        socket.on("room_join") { (data, ack) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print("room_joined")
            print(data)
            self.scrollToBottom()
            
        }
        
    }
    
    
    internal func socketHandling() {
        
        emitFirstTime()
        broadCast()
        // getMessage()
        getSkip()
    }
    
    
    
    internal func sendMessageSocket(_ eventName: String, _ card:String,_ game_id:String,_ room_id:String,_ receiver_id:String,_ message:String, _ type: String, _ streaks:String,_ point: String, _ bonus: String,_ score: String,_ isMatched: Bool,_ all_matched: String,_ languageCode:String){
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
        
        
        
        self.socket.emit(eventName, ["sender_id": userId,"card":card,"game_id":game_id,"room_id":room_id,"receiver_id":self.receiver_id,"message":message,"type":type,"streaks":Int(streaks) ?? 0.0, "point": Int(point) ?? 0,"bonus": Int(bonus) ?? 0, "score": Int(score) ?? 0, "isMatched": isMatched, "all_matched": all_matched,"Image":self.images[cardIndex],"languageCode":languageCode])
        
        
        
    }
    
    
    internal func btnSkipSocketTapped( _ card:String,_ game_id:String,_ room_id:String,_ receiver_id:String, _ type: String,_ status: String,_ sender_by: String, _ receiver_by: String,_ updates: NSMutableArray){
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
        self.socket.emit("card_pass", ["sender_id": userId,"card":card,"game_id":game_id,"room_id":room_id,"receiver_id":receiver_id,"type":type,"status":status,"sender_by":sender_by,"receiver_by":receiver_by,"updates":updates])
        
        // sender_id,receiver_id,game_id,status,sender_by,receiver_by,card
        
    }
    
    
    internal func gameBackSocketTapped( _ card:String,_ game_id:String,_ room_id:String,_ receiver_id:String, _ type: String,_ status: String,_ sender_by: String, _ receiver_by: String,_ updates: NSMutableArray){
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
        self.socket.emit("game_back", ["sender_id": userId,"card":card,"game_id":game_id,"room_id":room_id,"receiver_id":receiver_id,"type":type,"status":status,"sender_by":sender_by,"receiver_by":receiver_by,"updates":updates])
        
        // sender_id,receiver_id,game_id,status,sender_by,receiver_by,card
        
    }
    
    
    
    
    
    internal func isTypingMethod(_ is_typing:Bool){
        let realm = try! Realm()
        var userId = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                userId = user._id
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        // CustomMethods.shared.showLoaderPresent(view: self.view)
        self.socket.emit("typing_in", ["sender_id": userId,"room_id":self.room_id,"is_typing":is_typing])
        
    }
    
    
    internal func stopTypingMethod(_ is_typing:Bool){
        let realm = try! Realm()
        var userId = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                userId = user._id
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        // CustomMethods.shared.showLoaderPresent(view: self.view)
        self.socket.emit("stop_typing", ["sender_id": userId,"room_id":self.room_id,"is_typing":is_typing])
        
    }
    
    
    //  lives_pass
    
    internal func livePass( _ card:String,_ game_id:String,_ room_id:String,_ receiver_id:String,_ lives: String){
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
        self.socket.emit("lives_pass", ["sender_id": userId,"card":card,"game_id":game_id,"room_id":room_id,"receiver_id":receiver_id,"lives":lives])
        
        // data.sender_id && data.receiver_id, data.game_id, data.room_id, data.card, data.lives
        
    }
    
    
    
    
    internal func getSkip(){
        
        
        //TODO: Get callback for notification list
        socket.on("card_pass") { (data, ack) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print("card_pass")
            print(data)
            
            if let listArray = data as? NSArray{
                
                if listArray.count > 0{
                    if let listDictArray = listArray[0] as? NSDictionary{
                        print(listDictArray)
                        
                        guard let ReceiverMessage = listDictArray.value(forKey: "ReceiverMessage") as? String else{
                            print("No ReceiverMessage")
                            return
                            
                        }
                        
                        guard let SenderMessage = listDictArray.value(forKey: "SenderMessage") as? String else{
                            print("No SenderMessage")
                            return
                            
                        }
                        
                        if let message = listDictArray.value(forKey: "message") as? String{
                            self.receiver_by = "false"
                            self.passCount += 1
                            self.lblPass.textColor = AppColor.whiteColor
                            self.lblPass.text = "\(self.passCount)/\(self.images.count) \(ConstantTexts.PassLT)"
                            self.viewPass.alpha = 0.80
                            self.viewPass.backgroundColor = AppColor.callBgColor
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                
                                let nextIndex = self.fsPager_view.currentIndex + 1 < self.numberOfItems(in:self.fsPager_view) ? self.fsPager_view.currentIndex + 1 : 0
                                self.fsPager_view.scrollToItem(at: nextIndex, animated: true)
                                
                                UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {() -> Void in
                                    self.viewPass.backgroundColor = AppColor.whiteColor
                                    self.lblPass.textColor = AppColor.textColor
                                    self.viewPass.alpha = 0.80
                                    
                                }, completion: {(finished: Bool) -> Void in
                                })
                                self.messages.removeAll()
                                self.tblChat.reloadData()
                                self.scrollToBottom()
                            }
                            
                        }else{
                            
                            self.viewPass.alpha = 0.80
                            self.viewPass.backgroundColor = AppColor.errorColor
                            self.lblPass.textColor = AppColor.whiteColor
                            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut, .repeat, .autoreverse, .allowUserInteraction], animations: {() -> Void in
                                self.viewPass.alpha = 0.0
                            }, completion: {(finished: Bool) -> Void in
                            })
                            
                            
                            if let sender_id = listDictArray.value(forKey: "sender_id") as? String{
                                
                                if sender_id == self.receiver_id{
                                    self.receiver_by = "true"
                                    self.lblPass.text = "\(ReceiverMessage)  \(self.passCount)/\(self.images.count) \(ConstantTexts.PassLT)"
                                }else{
                                    self.lblPass.text = "\(SenderMessage)  \(self.passCount)/\(self.images.count) \(ConstantTexts.PassLT)"
                                    self.receiver_by = "false"
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
            
            
            
            
        }
    }
    
    
    
    
    
    internal func getMessage(){
        
        let realm = try! Realm()
        var userId = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                userId = user._id
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        //TODO: Get callback for notification list
        socket.on("message") { (data, ack) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print("event name")
            print(data)
            
            
            if let listArray = data as? NSArray{
                
                if listArray.count > 0{
                    if let listDictArray = listArray[0] as? NSDictionary{
                        print(listDictArray)
                        
                        
                        if let event_name = listDictArray.value(forKey: "event_name") as? String{
                            if event_name == "message"{
                                
                                let MorereciselyItem = MessageDataModel(createdAt: String(), message: String(), message_Encrypted: String(), read_status: String(), userId: String(), receiver_id: String(), room_id: String(), sender_id: String(), status: String(), type: String(), isMatched: Bool(), isEncryped: Bool(), isMe: Bool(), pointId: Double(), score: Double(), point: Double(), bonus: Double(), streaks: Double(), all_matched: Double(), wordCount: Int())
                                
                                
                                
                                
                                if let createdAt = listDictArray.value(forKey: "createdAt") as? String{
                                    MorereciselyItem.createdAt = createdAt
                                }
                                
                                if let pointId = listDictArray.value(forKey: "pointId") as? String{
                                    MorereciselyItem.pointId = Double(pointId) ?? 0.0
                                }
                                
                                
                                if let pointId = listDictArray.value(forKey: "pointId") as? Double{
                                    MorereciselyItem.pointId = Double(pointId) ?? 0.0
                                }
                                
                                if let message = listDictArray.value(forKey: "message") as? String{
                                    MorereciselyItem.message = message
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
                                
                                if userId == MorereciselyItem.sender_id{
                                    MorereciselyItem.isMe = true
                                }
                                
                                MorereciselyItem.message_Encrypted = String(MorereciselyItem.message.map {
                                    $0 == " " ? " " : "*"
                                })
                                
                                let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
                                let components = MorereciselyItem.message.components(separatedBy: chararacterSet)
                                let words = components.filter { !$0.isEmpty }
                                
                                MorereciselyItem.wordCount = words.count
                                
                                
                                MorereciselyItem.streaks = self.streaks
                                
                                print(self.item.userId)
                                print(self.item.receiverId)
                                print(MorereciselyItem.sender_id)
                                var dataByReciever = Int()
                                
                                for index in 0..<self.messages.count{
                                    
                                    if self.messages[index].isMe == false{
                                        dataByReciever += 1
                                    }
                                    
                                    
                                    
                                    if self.messages[index].isMe && MorereciselyItem.isMe == false{
                                        
                                        if(MorereciselyItem.message.caseInsensitiveCompare(self.messages[index].message) == .orderedSame){
                                            
                                            self.messages[index].isMatched = true
                                            MorereciselyItem.isMatched = true
                                            
                                            self.messages[index].isEncryped = true
                                            MorereciselyItem.isEncryped = true
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    if self.messages[index].isMe == false && MorereciselyItem.isMe{
                                        if(MorereciselyItem.message.caseInsensitiveCompare(self.messages[index].message) == .orderedSame){
                                            if self.messages[index].isMatched == false{
                                                self.messages[index].isMatched = true
                                                MorereciselyItem.isMatched = true
                                                
                                                self.messages[index].isEncryped = true
                                                MorereciselyItem.isEncryped = true
                                                
                                                
                                                MorereciselyItem.all_matched = self.all_matched
                                                MorereciselyItem.bonus = Double(MorereciselyItem.wordCount) ?? 0.0
                                                MorereciselyItem.streaks = self.streaks
                                                MorereciselyItem.point = PointsAndScoreCalcutatingClass.shared.returnPoints(matchPercentage: self.all_matched, matchedSuggesion: 1.0,round:1.0)
                                                
                                                MorereciselyItem.score = PointsAndScoreCalcutatingClass.shared.returnScore(point: MorereciselyItem.point, bonus: MorereciselyItem.bonus, streak: MorereciselyItem.streaks)
                                                
                                                self.score = MorereciselyItem.score
                                                
                                                self.streaks += 1.0
                                                
                                                
                                                
                                                
                                                
                                                
                                                do{
                                                    try self.realm.write {
                                                        if let user = self.realm.objects(UserDataModel.self).first{
                                                            user.totalPoints  = user.totalPoints + MorereciselyItem.point
                                                            if Int(round(self.score)) % 20 == 0{
                                                                user.coins += 1
                                                                self.isCoinAdded = true
                                                                
                                                                
                                                            }
                                                            
                                                        }
                                                    }
                                                }catch{
                                                    print("Error in saving data :- \(error.localizedDescription)")
                                                }
                                                
                                                self.animateChangePasswordView(color: AppColor.errorColor, text: ConstantTexts.MatchCLT, font: AppFont.bold.size(AppFontName.SegoeUI, size: 30), subText: "\(Int(round(MorereciselyItem.point)))", bonus: "\(Int(round(MorereciselyItem.bonus)))", streak: "\(Int(round(MorereciselyItem.streaks)))", coins: "1")
                                                break
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                if self.isComingLives{
                                    
                                    if self.messages.count > 0 && dataByReciever > 0{
                                        if self.lifeCount > 0{
                                            if MorereciselyItem.isMatched == false && MorereciselyItem.isMe{
                                                
                                                if self.streaks == MorereciselyItem.streaks{
                                                    self.streaks = 0.0
                                                }
                                                
                                                
                                                self.lifeCount -= 1
                                                self.livePass( "\(self.cardIndex)",self.item.gameId,self.room_id,self.receiver_id,"\(self.lifeCount)")
                                                self.shakeTextFieldWithoutRedColor()
                                                self.updateLife()
                                            }
                                        }else{
                                            
                                            let type = self.isComingLives ? "2" : "1"
                                            
                                            
                                            DispatchQueue.global(qos: .background).async {
                                                do
                                                {
                                                    DispatchQueue.main.async {
                                                        self.gameBackSocketTapped("\(self.cardIndex)",self.item.gameId,self.room_id,self.item.userId,type,"true","true",self.self.receiver_by,self.returnChatArray(self.messages))
                                                    }
                                                }
                                                catch {
                                                    // error
                                                }
                                            }
                                            
                                            
                                            
                                            
                                            let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GameOverViewController.className) as! GameOverViewController
                                            vc.room_id = self.room_id
                                            vc.item = self.item
                                            vc.reciever_id = self.receiver_id
                                            self.navigationController?.pushViewController(vc, animated: false)
                                        }
                                    }
                                    
                                    
                                    
                                }else{
                                    if self.isTimerInitateFirstTime == false{
                                        self.isTimerInitateFirstTime = true
                                        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.showProgressbar), userInfo: nil, repeats: true)
                                    }
                                }
                                
                                
                                
                                
                                if MorereciselyItem.sender_id == userId || MorereciselyItem.sender_id == self.receiver_id{
                                    
                                    if MorereciselyItem.message != String(){
                                        self.messages.append(MorereciselyItem)
                                    }
                                    
                                }
                                
                                self.txtMessage.text = String()
                                self.tblChat.dataSource = self
                                self.tblChat.delegate = self
                                self.tblChat.reloadData()
                                self.scrollToBottom()
                                
                                
                            }else if event_name == "typing_in"{
                                if let room_id = listDictArray.value(forKey: "room_id") as? String{
                                    if self.room_id == room_id{
                                        
                                        if let sender_id = listDictArray.value(forKey: "sender_id") as? String{
                                            if sender_id != userId{
                                                self.startTypingLoader()
                                            }
                                        }
                                        
                                        
                                    }
                                    
                                }
                            }else if event_name == "stop_typing"{
                                if let room_id = listDictArray.value(forKey: "room_id") as? String{
                                    print(room_id)
                                    if self.room_id == room_id{
                                        self.stopTypingLoader()
                                    }
                                    
                                }
                                
                            }
                            
                            
                            
                            
                        }
                    }
                }
                
            }
            
            
        }
    }
    
    
    
    internal func broadCast(){
        let realm = try! Realm()
        var userId = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                userId = user._id
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        //TODO: Get callback for notification list
        socket.on("broadcast") { (data, ack) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print("event name")
            print(data)
            
            
            if let listArray = data as? NSArray{
                
                if listArray.count > 0{
                    if let listDictArray = listArray[0] as? NSDictionary{
                        print(listDictArray)
                        
                        
                        if let event_name = listDictArray.value(forKey: "event_name") as? String{
                            if event_name == "message"{
                                
                                let MorereciselyItem = MessageDataModel(createdAt: String(), message: String(), message_Encrypted: String(), read_status: String(), userId: String(), receiver_id: String(), room_id: String(), sender_id: String(), status: String(), type: String(), isMatched: Bool(), isEncryped: Bool(), isMe: Bool(), pointId: Double(), score: Double(), point: Double(), bonus: Double(), streaks: Double(), all_matched: Double(), wordCount: Int())
                                
                                
                                
                                
                                if let createdAt = listDictArray.value(forKey: "createdAt") as? String{
                                    MorereciselyItem.createdAt = createdAt
                                }
                                
                                if let pointId = listDictArray.value(forKey: "pointId") as? String{
                                    MorereciselyItem.pointId = Double(pointId) ?? 0.0
                                }
                                
                                
                                if let pointId = listDictArray.value(forKey: "pointId") as? Double{
                                    MorereciselyItem.pointId = Double(pointId) ?? 0.0
                                }
                                
                                if let message = listDictArray.value(forKey: "message") as? String{
                                    MorereciselyItem.message = message
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
                                
                                if userId == MorereciselyItem.sender_id{
                                    MorereciselyItem.isMe = true
                                }
                                
                                MorereciselyItem.message_Encrypted = String(MorereciselyItem.message.map {
                                    $0 == " " ? " " : "*"
                                })
                                
                                let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
                                let components = MorereciselyItem.message.components(separatedBy: chararacterSet)
                                let words = components.filter { !$0.isEmpty }
                                
                                MorereciselyItem.wordCount = words.count
                                
                                
                                MorereciselyItem.streaks = self.streaks
                                
                                print(self.item.userId)
                                print(self.item.receiverId)
                                print(MorereciselyItem.sender_id)
                                var dataByReciever = Int()
                                
                                for index in 0..<self.messages.count{
                                    
                                    if self.messages[index].isMe == false{
                                        dataByReciever += 1
                                    }
                                    
                                    
                                    
                                    if self.messages[index].isMe && MorereciselyItem.isMe == false{
                                        
                                        if(MorereciselyItem.message.caseInsensitiveCompare(self.messages[index].message) == .orderedSame){
                                            
                                            self.messages[index].isMatched = true
                                            MorereciselyItem.isMatched = true
                                            
                                            self.messages[index].isEncryped = true
                                            MorereciselyItem.isEncryped = true
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    if self.messages[index].isMe == false && MorereciselyItem.isMe{
                                        if(MorereciselyItem.message.caseInsensitiveCompare(self.messages[index].message) == .orderedSame){
                                            if self.messages[index].isMatched == false{
                                                self.messages[index].isMatched = true
                                                MorereciselyItem.isMatched = true
                                                
                                                self.messages[index].isEncryped = true
                                                MorereciselyItem.isEncryped = true
                                                
                                                
                                                MorereciselyItem.all_matched = self.all_matched
                                                MorereciselyItem.bonus = Double(MorereciselyItem.wordCount) ?? 0.0
                                                MorereciselyItem.streaks = self.streaks
                                                MorereciselyItem.point = PointsAndScoreCalcutatingClass.shared.returnPoints(matchPercentage: self.all_matched, matchedSuggesion: 1.0,round:1.0)
                                                
                                                MorereciselyItem.score = PointsAndScoreCalcutatingClass.shared.returnScore(point: MorereciselyItem.point, bonus: MorereciselyItem.bonus, streak: MorereciselyItem.streaks)
                                                
                                                self.score = MorereciselyItem.score
                                                
                                                self.streaks += 1.0
                                                
                                                
                                                
                                                
                                                
                                                
                                                do{
                                                    try self.realm.write {
                                                        if let user = self.realm.objects(UserDataModel.self).first{
                                                            user.totalPoints  = user.totalPoints + MorereciselyItem.point
                                                            if Int(round(self.score)) % 20 == 0{
                                                                user.coins += 1
                                                                self.isCoinAdded = true
                                                                
                                                                
                                                            }
                                                            
                                                        }
                                                    }
                                                }catch{
                                                    print("Error in saving data :- \(error.localizedDescription)")
                                                }
                                                
                                                self.animateChangePasswordView(color: AppColor.errorColor, text: ConstantTexts.MatchCLT, font: AppFont.bold.size(AppFontName.SegoeUI, size: 30), subText: "\(Int(round(MorereciselyItem.point)))", bonus: "\(Int(round(MorereciselyItem.bonus)))", streak: "\(Int(round(MorereciselyItem.streaks)))", coins: "1")
                                                break
                                            }
                                        }
                                    }
                                    
                                }
                                
                                
                                if self.isComingLives{
                                    
                                    if self.messages.count > 0 && dataByReciever > 0{
                                        if self.lifeCount > 0{
                                            if MorereciselyItem.isMatched == false && MorereciselyItem.isMe{
                                                
                                                
                                                if self.streaks == 0.0{
                                                    self.lifeCount -= 1
                                                }
                                                
                                                if self.streaks == MorereciselyItem.streaks{
                                                    self.streaks = 0.0
                                                }
                                                
                                                
                                                
                                                self.livePass( "\(self.cardIndex)",self.item.gameId,self.room_id,self.receiver_id,"\(self.lifeCount)")
                                                self.shakeTextFieldWithoutRedColor()
                                                self.updateLife()
                                            }
                                        }else{
                                            
                                            let type = self.isComingLives ? "2" : "1"
                                            
                                            
                                            DispatchQueue.global(qos: .background).async {
                                                do
                                                {
                                                    DispatchQueue.main.async {
                                                        self.gameBackSocketTapped("\(self.cardIndex)",self.item.gameId,self.room_id,self.item.userId,type,"true","true",self.self.receiver_by,self.returnChatArray(self.messages))
                                                    }
                                                }
                                                catch {
                                                    // error
                                                }
                                            }
                                            
                                            
                                            
                                            
                                            let vc = AppStoryboard.home.instantiateViewController(withIdentifier: GameOverViewController.className) as! GameOverViewController
                                            vc.room_id = self.room_id
                                            vc.item = self.item
                                            vc.reciever_id = self.receiver_id
                                            self.navigationController?.pushViewController(vc, animated: false)
                                        }
                                    }
                                    
                                    
                                    
                                }else{
                                    
                                    
                                    
                                    if self.streaks == MorereciselyItem.streaks{
                                        self.streaks = 0.0
                                    }
                                    
                                    
                                    if self.isTimerInitateFirstTime == false{
                                        self.isTimerInitateFirstTime = true
                                        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.showProgressbar), userInfo: nil, repeats: true)
                                    }
                                }
                                
                                
                                
                                
                                if MorereciselyItem.sender_id == userId || MorereciselyItem.sender_id == self.receiver_id{
                                    
                                    if MorereciselyItem.message != String(){
                                        self.messages.append(MorereciselyItem)
                                    }
                                    
                                }
                                
                                self.txtMessage.text = String()
                                self.tblChat.dataSource = self
                                self.tblChat.delegate = self
                                self.tblChat.reloadData()
                                self.scrollToBottom()
                                
                                
                            }else if event_name == "typing_in"{
                                if let room_id = listDictArray.value(forKey: "room_id") as? String{
                                    if self.room_id == room_id{
                                        
                                        if let sender_id = listDictArray.value(forKey: "sender_id") as? String{
                                            if sender_id != userId{
                                                self.startTypingLoader()
                                            }
                                        }
                                        
                                        
                                    }
                                    
                                }
                            }else if event_name == "stop_typing"{
                                if let room_id = listDictArray.value(forKey: "room_id") as? String{
                                    print(room_id)
                                    if self.room_id == room_id{
                                        self.stopTypingLoader()
                                    }
                                    
                                }
                                
                            }
                            
                            
                            
                            
                        }
                    }
                }
                
            }
            
            
        }
        
    }
    
}


//MARK: - Extension For animations
extension ChatVC{
    internal func shakeTextField(){
        
        let transformAnim  = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values  = [NSValue(caTransform3D: CATransform3DMakeRotation(0.04, 0.0, 0.0, 1.0)),NSValue(caTransform3D: CATransform3DMakeRotation(-0.04 , 0, 0, 1))]
        transformAnim.autoreverses = true
        transformAnim.duration  =  0.105
        transformAnim.repeatCount = 4
        self.txtMessage.layer.add(transformAnim, forKey: "transform")
        self.txtMessage.backgroundColor = AppColor.errorColor
        self.txtMessage.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 25.0)
        self.txtMessage.text = ConstantTexts.DuplicateLT
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.txtMessage.text = String()
            self.txtMessage.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
            self.txtMessage.backgroundColor = AppColor.chatTfColor
            
        }
        
        
        
    }
    
    
    internal func shakeTextFieldWithoutRedColor(){
        
        let transformAnim  = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values  = [NSValue(caTransform3D: CATransform3DMakeRotation(0.04, 0.0, 0.0, 1.0)),NSValue(caTransform3D: CATransform3DMakeRotation(-0.04 , 0, 0, 1))]
        transformAnim.autoreverses = true
        transformAnim.duration  =  0.105
        transformAnim.repeatCount = 4
        self.txtMessage.layer.add(transformAnim, forKey: "transform")
    }
    
    
    
    internal func startTypingLoader(){
        self.viewTyping.isHidden = false
        self.viewTyping.backgroundColor = AppColor.clearColor
        viewTyping.alpha = 0.80
        CustomMethods.shared.showAnimationWithName(view: viewTyping,animationName:"lf30_editor_T1Am9Z")
        
    }
    
    internal func stopTypingLoader(){
        self.viewTyping.isHidden = true
        self.viewTyping.backgroundColor = AppColor.clearColor
        viewTyping.alpha = 0.80
    }
    
    
    func hideFieldsOfChangePass() {
        self.lblScoreAlert1.isHidden = true
        self.lblScoreAlert2.isHidden = true
        
    }
    
    func showHideFieldsOfChangePass(color:UIColor,text:String,font:UIFont,subText:String,bonus:String,streak:String,coins:String) {
        
        self.lblScoreAlert1.textColor = color
        self.lblScoreAlert1.font = font
        self.lblScoreAlert1.numberOfLines = 0
        
        self.lblScoreAlert2.textColor = color
        self.lblScoreAlert2.font = font
        self.lblScoreAlert2.numberOfLines = 0
        
        self.lblScoreAlert1.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.lblScoreAlert1.layer.shadowOpacity = 0.8
        self.lblScoreAlert1.layer.shadowRadius = 2
        self.lblScoreAlert1.layer.shadowColor = AppColor.textColor.cgColor
        
        self.lblScoreAlert2.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.lblScoreAlert2.layer.shadowOpacity = 0.8
        self.lblScoreAlert2.layer.shadowRadius = 2
        self.lblScoreAlert2.layer.shadowColor = AppColor.textColor.cgColor
        
        
        if text == ConstantTexts.MatchCLT{
            self.lblScoreAlert1.text = text
            self.lblScoreAlert2.text = subText
        }else if text == ConstantTexts.BonusCLT{
            self.lblScoreAlert1.text = "\(text)\n\(bonus)x \(ConstantTexts.WordsLT)"
            self.lblScoreAlert2.text = subText
        }else if text == ConstantTexts.StreakCLT{
            CustomMethods.shared.showLoaderPresentCeleb(view: self.viewCeleb, animationName: "7893-confetti-cannons")
            self.viewCeleb.isHidden = (streak != "0") ? false:true
            self.lblScoreAlert1.text = "\(text)\n\(streak)x"
            self.lblScoreAlert2.text = subText
        }else if text == ConstantTexts.PointsCLT{
            CustomMethods.shared.showLoaderPresentCoins(view: self.viewCoin, animationName: "18089-gold-coin")
            self.viewCoin.isHidden = false
            // self.lblScoreAlert1.text = "\(coins) \(ConstantTexts.PointsLT)"
            self.lblScoreAlert1.text = "\(text)"
            self.lblScoreAlert2.text = "\(coins) \(ConstantTexts.CoinsLT)"
        }
        
        
        self.lblScoreAlert1.isHidden = false
        self.lblScoreAlert2.isHidden = false
        
    }
    
    func animateChangePasswordView(color:UIColor,text:String,font:UIFont,subText:String,bonus:String,streak:String,coins:String){
        showHideFieldsOfChangePass(color: color, text: text, font: font, subText: subText,bonus:bonus,streak:streak, coins: coins)
        self.lblScoreAlert1.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.viewCeleb.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.25,
                       initialSpringVelocity: 8.00,
                       options: .allowUserInteraction,
                       animations: {
                        self.lblScoreAlert1.transform = CGAffineTransform.identity
                        self.lblScoreAlert2.transform = CGAffineTransform.identity
                        self.viewCeleb.transform = CGAffineTransform.identity
                        self.viewCoin.transform = CGAffineTransform.identity
                        
                        
        })
        
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            
            if text == ConstantTexts.PointsCLT{
                guard let viewPoints = self.btnCoinCountRef.superview?.convert(self.btnCoinCountRef.frame.origin, to: nil) else{
                    print("No viewPoints co-ordinates...")
                    return
                }
                guard let lblPoints = self.viewCoin.superview?.convert(self.viewCoin.frame.origin, to: nil) else{
                    print("No lblPoints co-ordinates...")
                    return
                }
                
                let points = self.distance(viewPoints, lblPoints)
                
                self.viewCoin.transform = CGAffineTransform(translationX: points.0, y: points.1)
                
            }else{
                guard let viewPoints = self.viewPointBG.superview?.convert(self.viewPointBG.frame.origin, to: nil) else{
                    print("No viewPoints co-ordinates...")
                    return
                }
                guard let lblPoints = self.lblScoreAlert2.superview?.convert(self.lblScoreAlert2.frame.origin, to: nil) else{
                    print("No lblPoints co-ordinates...")
                    return
                }
                
                let points = self.distance(viewPoints, lblPoints)
                
                self.lblScoreAlert2.transform = CGAffineTransform(translationX: points.0, y: points.1)
                
            }
            
            
            
            
            
        }) { (done) in
            
            if text == ConstantTexts.MatchCLT{
                do{
                    if let user = self.realm.objects(UserDataModel.self).first{
                        
                        self.lblPoints.text = (user.totalPoints == Double()) ? "0" : "\(Int(round(user.totalPoints)))"
                        
                    }
                    
                }catch{
                    print("Error in saving data :- \(error.localizedDescription)")
                }
                self.lblScoreAlert1.transform = CGAffineTransform.identity
                self.lblScoreAlert2.transform = CGAffineTransform.identity
                self.viewCeleb.transform = CGAffineTransform.identity
                self.viewCeleb.isHidden = true
                self.viewCoin.transform = CGAffineTransform.identity
                self.viewCoin.isHidden = true
                self.hideFieldsOfChangePass()
                
                self.animateChangePasswordView(color: AppColor.bonusColor, text: ConstantTexts.BonusCLT, font: AppFont.bold.size(AppFontName.SegoeUI, size: 30), subText: bonus, bonus: bonus, streak: streak, coins: coins)
                
            }else if text == ConstantTexts.BonusCLT{
                self.lblScoreAlert1.transform = CGAffineTransform.identity
                self.lblScoreAlert2.transform = CGAffineTransform.identity
                self.viewCeleb.transform = CGAffineTransform.identity
                self.viewCeleb.isHidden = true
                self.viewCoin.transform = CGAffineTransform.identity
                self.viewCoin.isHidden = true
                self.hideFieldsOfChangePass()
                if streak != "0"{
                    self.animateChangePasswordView(color: AppColor.callBgColor, text: ConstantTexts.StreakCLT, font: AppFont.bold.size(AppFontName.SegoeUI, size: 30), subText: bonus, bonus: bonus, streak: streak, coins: coins)
                }else if self.isCoinAdded == true{
                    self.lblScoreAlert1.transform = CGAffineTransform.identity
                    self.lblScoreAlert2.transform = CGAffineTransform.identity
                    self.viewCeleb.transform = CGAffineTransform.identity
                    self.viewCeleb.isHidden = true
                    self.viewCoin.transform = CGAffineTransform.identity
                    self.viewCoin.isHidden = true
                    self.hideFieldsOfChangePass()
                    self.isCoinAdded = false
                    self.animateChangePasswordView(color: AppColor.emailColor, text: ConstantTexts.PointsCLT, font: AppFont.bold.size(AppFontName.SegoeUI, size: 30), subText: bonus, bonus: bonus, streak: streak, coins: coins)
                    
                }else {
                    self.lblScoreAlert1.transform = CGAffineTransform.identity
                    self.lblScoreAlert2.transform = CGAffineTransform.identity
                    self.viewCeleb.transform = CGAffineTransform.identity
                    self.viewCoin.transform = CGAffineTransform.identity
                    self.viewCoin.isHidden = true
                    self.viewCeleb.isHidden = true
                    self.hideFieldsOfChangePass()
                }
                
            }else if text == ConstantTexts.StreakCLT{
                self.lblScoreAlert1.transform = CGAffineTransform.identity
                self.lblScoreAlert2.transform = CGAffineTransform.identity
                self.viewCeleb.transform = CGAffineTransform.identity
                self.viewCeleb.isHidden = true
                self.viewCoin.transform = CGAffineTransform.identity
                self.viewCoin.isHidden = true
                self.hideFieldsOfChangePass()
                
                if self.isCoinAdded == true{
                    self.lblScoreAlert1.transform = CGAffineTransform.identity
                    self.lblScoreAlert2.transform = CGAffineTransform.identity
                    self.viewCeleb.transform = CGAffineTransform.identity
                    self.viewCeleb.isHidden = true
                    self.viewCoin.transform = CGAffineTransform.identity
                    self.viewCoin.isHidden = true
                    self.hideFieldsOfChangePass()
                    self.isCoinAdded = false
                    self.animateChangePasswordView(color: AppColor.emailColor, text: ConstantTexts.PointsCLT, font: AppFont.bold.size(AppFontName.SegoeUI, size: 30), subText: bonus, bonus: bonus, streak: streak, coins: coins)
                    
                }else if text == ConstantTexts.PointsCLT {
                    
                    
                    do{
                        if let user = self.realm.objects(UserDataModel.self).first{
                            
                            CustomMethods.shared.setupButton(self.btnCoinCountRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), " \(Int(round(user.coins)))")
                            
                        }
                        
                    }catch{
                        print("Error in saving data :- \(error.localizedDescription)")
                    }
                    
                    
                    self.lblScoreAlert1.transform = CGAffineTransform.identity
                    self.lblScoreAlert2.transform = CGAffineTransform.identity
                    self.viewCeleb.transform = CGAffineTransform.identity
                    self.viewCoin.transform = CGAffineTransform.identity
                    self.viewCoin.isHidden = true
                    self.viewCeleb.isHidden = true
                    self.hideFieldsOfChangePass()
                }else{
                    self.lblScoreAlert1.transform = CGAffineTransform.identity
                    self.lblScoreAlert2.transform = CGAffineTransform.identity
                    self.viewCeleb.transform = CGAffineTransform.identity
                    self.viewCoin.transform = CGAffineTransform.identity
                    self.viewCoin.isHidden = true
                    self.viewCeleb.isHidden = true
                    self.hideFieldsOfChangePass()
                }
                
                
            }else{
                self.lblScoreAlert1.transform = CGAffineTransform.identity
                self.lblScoreAlert2.transform = CGAffineTransform.identity
                self.viewCeleb.transform = CGAffineTransform.identity
                self.viewCoin.transform = CGAffineTransform.identity
                self.viewCoin.isHidden = true
                self.viewCeleb.isHidden = true
                self.hideFieldsOfChangePass()
            }
            
            
            
        }
        
        
        
    }
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> (CGFloat,CGFloat) {
        return (CGFloat(a.x - b.x),CGFloat(a.y - b.y))
    }
    
    
    
    func animateDescriptionView(){
        self.viewDescription.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.25,
                       initialSpringVelocity: 8.00,
                       options: .allowUserInteraction,
                       animations: {
                        self.viewDescription.transform = CGAffineTransform.identity
        })
        
    }
    
    
    
}



extension ChatVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if isTypingNew == false{
            DispatchQueue.global(qos: .background).async {
                do
                {
                    print(self.room_id)
                    DispatchQueue.main.async {self.isTypingMethod(true)}
                }
                catch {
                    // error
                }
            }
        }
        
        
        
        
        
    }
}

