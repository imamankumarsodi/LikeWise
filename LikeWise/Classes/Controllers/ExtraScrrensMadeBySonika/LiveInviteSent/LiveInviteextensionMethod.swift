//
//  LiveInviteextensionMethod.swift
//  LikeWise
//
//  Created by cst on 25/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Alamofire

extension LiveInviteSentViewController:UIScrollViewDelegate{
    
    
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    internal func initialSetUp(){
        
        // collectData()
        self.view.backgroundColor = AppColor.themeColorDark
        lblHeadingRef.font = ConstantFonts.SubmitButtonFont
        lblHeadingRef.textColor = AppColor.whiteColor
        lblHeadingRef.text = ConstantTexts.SearchingForPartnerLT
        
        
        lblLanguage.numberOfLines = 0
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: languageArray.name, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n(\(languageArray.descriptionUser))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 8.0), AppColor.textColor))
        
        lblLanguage.attributedText = myMutableString
        
        
        imgLanguage.sd_setImage(with: URL(string: languageArray.profilePic), placeholderImage: UIImage(named: "default_pic"))
        
        CustomMethods.shared.provideCornerRadiusTo(imgLanguage, 20, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerBorderTo(imgLanguage, 2, AppColor.whiteColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.backView, 15.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.isPagingEnabled = true
        
        collectionView.register(nib: LifeInviteCollectionViewCell.className)
        
        let floawLayout = UPCarouselFlowLayout()
        let plusWidth = collectionView.frame.size.width / 10
        
        floawLayout.itemSize = CGSize(width: (collectionView.frame.size.width / 3) + plusWidth , height: collectionView.frame.size.height - 10)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 0.0)
        
        
        let chunkSize = 6
        chunks = stride(from: 0, to: RandomImagesModelArray.count, by: chunkSize).map {
                  Array(RandomImagesModelArray[$0..<min($0 + chunkSize, RandomImagesModelArray.count)])
              }
              
        print(chunks)
               
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isScrollEnabled = true
        collectionView.collectionViewLayout = floawLayout
        
        randomSelection()
    }
    
    
    
    internal func randomSelection(){
        let randomObjective = Int(arc4random_uniform(UInt32(CountryDataModelCollecArr_Objective.count)))
        let randomObjectiveItem = CountryDataModelCollecArr_Objective[randomObjective]
        let objectiveId = randomObjectiveItem._id
        print(objectiveId)
        
        let randomPrecisely = Int(arc4random_uniform(UInt32(randomObjectiveItem.MorereciselyArray.count)))
        let randomPreciselyItem = randomObjectiveItem.MorereciselyArray[randomPrecisely]
        let PreciselyId = randomPreciselyItem._id
        print(PreciselyId)
        
        
        let randomPartner = Int(arc4random_uniform(UInt32(PlayGameUserModel_Array.count)))
        let randomPartnerItem = PlayGameUserModel_Array[randomPartner]
        print(randomPartner)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.collectionView.scrollToItem(at:IndexPath(item: randomPartner, section: 0), at: .centeredHorizontally, animated: true)
            
            
            if self.chunks.count > 0{
                self.getFindPatnerApi(receiver_id:randomPartnerItem._id, languageCode: self.languageArray.languageCode, socialId: randomPartnerItem._id, objectives: objectiveId, morePresicely: PreciselyId, selectedFriend: CountryDataModelCollec(__v: String(), _id: randomPartnerItem._id, coinStatus: String(), dob: String(), email: String(), jwtToken: String(), languageCode: String(), name: randomPartnerItem.name, notificationStatus: String(), profilePic: randomPartnerItem.profilePic, status: String(), totalPoints: String(), username: randomPartnerItem.name, type: String(), country: String(), defaultLangCode: String(), nationalit: String(), state: String(), aboutus: String(), city: String(), interest: String(), gender: randomPartnerItem.gender, password: String(), descriptionUser: String(), socialId: String(), isSelected: Bool(), coins: String()),chunk:self.chunks[self.index])
            }
            
            
            
        }
        
    }
    
    
    
    
    //TODO: api for get find patner list
    internal func getFindPatnerApi(receiver_id:String,languageCode:String,socialId:String,objectives:String,morePresicely:String,selectedFriend:CountryDataModelCollec,chunk:[RandomImagesModel]){
        var token = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
                userModel.sender_id = user._id
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        userModel.receiver_id = receiver_id
        
       
      
        
        let picArray = NSMutableArray()
        var prams = [String:Any]()
        if var reqDict = userModel.toJSON() as? [String:Any]{
            print(reqDict)
            for index in 0..<chunk.count{
                picArray.add(chunk[index].Image)
                
            }
        reqDict["Data"] = picArray
           prams = reqDict
        }
        
        print(prams)
        
        
        let headers = ["authorization":token,
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        
        
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        
        SAuthService().postService(parameters: prams, serviceName: SAuthApi.countCardValue, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            
            if let dataDict = response.resultDict as? NSDictionary{
                if let cardImage = dataDict.value(forKey: "cardImage") as? NSArray{
                    
                    for item in cardImage{
                        if let itemDict = item as? NSDictionary{
                            if let isMatched = itemDict.value(forKey: "isMatched") as? Int{
                                if isMatched == 1{
                                    if let Image = itemDict.value(forKey: "Image") as? String{
                                        self.imageArray.add(Image)
                                    }
                                }
                            }
                        }
                    }
                    
                    self.index += 1
                    
                    if self.imageArray.count > 5{
                               self.userModel.type = "random_patner"
                               self.userModel.mode = self.mode
                               self.userModel.languageCode = languageCode
                               self.userModel.socialId = socialId
                               self.userModel.objective = objectives
                               self.userModel.morePrecisely = morePresicely
                        
                        if var reqDict = self.userModel.toJSON() as? [String:Any]{
                            print(reqDict)
                            for index in 0..<self.imageArray.count{
                                reqDict["publicGallery[\(index)]"] = self.imageArray[index]
                            }
                            print(reqDict)
                            self.createGameApi(params:reqDict, receiver_id: receiver_id, languageCode: languageCode, socialId: socialId, objectives: objectives, morePresicely: morePresicely, selectedFriend: selectedFriend)
                        }

                    }else{
                        
                        if self.index <= self.RandomImagesModelArray.count{
                            self.getFindPatnerApi(receiver_id:receiver_id, languageCode: languageCode, socialId: socialId, objectives: objectives, morePresicely: morePresicely, selectedFriend: selectedFriend,chunk:self.chunks[self.index])
                        }else{
                            
                           self.userModel.type = "random_patner"
                                   self.userModel.mode = self.mode
                                   self.userModel.languageCode = languageCode
                                   self.userModel.socialId = socialId
                                   self.userModel.objective = objectives
                                   self.userModel.morePrecisely = morePresicely
                            
                            if var reqDict = self.userModel.toJSON() as? [String:Any]{
                                print(reqDict)
                                for index in 0..<self.imageArray.count{
                                    reqDict["publicGallery[\(index)]"] = self.imageArray[index]
                                }
                                print(reqDict)
                                self.createGameApi(params:reqDict, receiver_id: receiver_id, languageCode: languageCode, socialId: socialId, objectives: objectives, morePresicely: morePresicely, selectedFriend: selectedFriend)
                                
                            }
                        }
                        
                        
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
    
    
    internal func createGameApi(params:[String:Any],receiver_id:String,languageCode:String,socialId:String,objectives:String,morePresicely:String,selectedFriend:CountryDataModelCollec){
        var token = String()
        var userId = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
                userId = user._id
            }
            
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        
        let header = ["authorization":token,
                      "Content-Type": "application/json",
                      "accept": "application/json"]
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        SAuthService().formDataService(profileImage, withName: withName, fileName: fileName, mimeType: mimeType, parameters: params, serviceName: SAuthApi.gameCreate, header: header).done{(response) -> Void  in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            
            if let message = response.message{
                _ = SweetAlert().showAlert(APP_NAME, subTitle: message, style: AlertStyle.success)
            }
            if self.mode == "1"{
                // self.navigationController?.popViewController(animated: true)
                let vc = AppStoryboard.home.instantiateViewController(withIdentifier: InviteSentViewController.className) as! InviteSentViewController
                vc.selectedFriend = selectedFriend
                if let dataDict = response.resultDict?.value(forKey: "game_details") as? NSDictionary{
                    if let _id = dataDict.value(forKey: "_id") as? String{
                        print(_id)
                        vc.game_id = _id
                    }
                }
                if let receiver_id = response.resultDict?.value(forKey: "receiver_id") as? String{
                    print(receiver_id)
                    vc.receiver_id = receiver_id
                }
                vc.type = self.mode
                vc.languangeCode = languageCode
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
                var reci_id = String()
                var gameId = String()
                
                if let dataDict = response.resultDict?.value(forKey: "game_details") as? NSDictionary{
                    if let _id = dataDict.value(forKey: "_id") as? String{
                        gameId = _id
                    }
                }
                if let receiver_id = response.resultDict?.value(forKey: "receiver_id") as? String{
                    print(receiver_id)
                    reci_id = receiver_id
                }
                
                
                self.roomCreateSocketForCreate(reci_id, gameId, selectedFriend.username, selectedFriend.profilePic)
                
                
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
    
    
    
    internal func roomCreateSocketForCreate(_ receiverId: String, _ gameId: String,_ username:String,_ profilePic:String){
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
        userModel.receiver_id = receiverId
        userModel.game_id = gameId
        self.userModel.room_status = true
        userModel.type = mode
        userModel.languageCode = self.languageArray.languageCode
        
        let headers:HTTPHeaders = ["Content-Type":"application/json","authorization":token]
        
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.roomCreate, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            
            if let dataDict = response.resultDict as? NSDictionary{
                
                if let room_id = dataDict.value(forKey: "room_id") as? String{
                    
                    let MorereciselyItem = NotificationDataModel(name: String(), description: String(), __v: String(), _id: String(), gameId: String(), profilePic: String(), createdAt: String(), userId: String(), receiverId: String(), type: String(), status: String(), startDate: Date(),endDate: Date())
                    
                    MorereciselyItem.gameId = gameId
                    MorereciselyItem.receiverId = receiverId
                    MorereciselyItem.userId = receiverId
                    
                    MorereciselyItem.name = username
                    MorereciselyItem.profilePic = profilePic
                    
                    
                    
                    let viewController = AppStoryboard.chat.instantiateViewController(withIdentifier: ChatVC.className) as! ChatVC
                    
                    // viewController.isComingLives = true
                    
                    print(receiverId)
                    viewController.receiver_id = receiverId
                    viewController.room_id = room_id
                    viewController.item = MorereciselyItem
                    
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
