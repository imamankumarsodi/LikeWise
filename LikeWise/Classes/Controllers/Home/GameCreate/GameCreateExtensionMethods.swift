//
//  GameCreateExtensionMethods.swift
//  LikeWise
//
//  Created by cst on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift
import SocketIO
import RealmSwift


extension GameCreateViewController{
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    internal func initialSetUp(){
        
        lblHeaderTitle.font = ConstantFonts.SubmitButtonFont
        lblHeaderTitle.textColor = AppColor.whiteColor
        lblHeaderTitle.text = ConstantTexts.CreateGameLT
        
        lblSelectMode.font = ConstantFonts.TextFieldFont
        lblSelectMode.textColor = AppColor.whiteColor
        lblSelectMode.text = ConstantTexts.SelectModeNewLT
        lblSelectMode.numberOfLines = 0
        
        
        
        lblTimeMode.numberOfLines = 0
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.TimeLT, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.whiteColor))
      //  myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n(\("90 seconds"))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.whiteColor))
        
        lblTimeMode.attributedText = myMutableString
        
        lblLiveMode.numberOfLines = 0
        let MyMutableString = NSMutableAttributedString()
        MyMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.LivesLT, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.whiteColor))
       // MyMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n(\("8 trials"))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.whiteColor))
        
        lblLiveMode.attributedText = MyMutableString
        
        lblInvitePartner.font = ConstantFonts.TextFieldFont
        lblInvitePartner.textColor = AppColor.whiteColor
        lblInvitePartner.text = ConstantTexts.InvitePartnerLT
        lblInvitePartner.numberOfLines = 0
        
        
        lblSelectLang.font = ConstantFonts.TextFieldFont
        lblSelectLang.textColor = AppColor.whiteColor
        lblSelectLang.text = ConstantTexts.SelectOneLangLT
        lblSelectLang.numberOfLines = 0
        
        lblObj.font = ConstantFonts.TextFieldFont
        lblObj.textColor = AppColor.whiteColor
        lblObj.text = ConstantTexts.WhatObjLT
        lblObj.numberOfLines = 0
        
        
        lblMorePre.font = ConstantFonts.TextFieldFont
        lblMorePre.textColor = AppColor.whiteColor
        lblMorePre.numberOfLines = 0
        showHideMorePrecisely()
        
        lblCustomeIns.font = ConstantFonts.TextFieldFont
        lblCustomeIns.textColor = AppColor.whiteColor
        lblCustomeIns.text = ConstantTexts.CommonInsLT
        lblCustomeIns.numberOfLines = 0
        
        lblAddImage.font = ConstantFonts.TextFieldFont
        lblAddImage.textColor = AppColor.whiteColor
        lblAddImage.text = ConstantTexts.AddImagesLT
        lblAddImage.numberOfLines = 0
        
        lblAddImageNew.font = AppFont.semibold.size(.SegoeUI, size: 10)
        lblAddImageNew.textColor = AppColor.placeholderColor
        lblAddImageNew.text = ConstantTexts.AddImagesLT
        lblAddImageNew.numberOfLines = 0
        
        instructionTv.font = ConstantFonts.TextFieldFont
        instructionTv.textColor = AppColor.placeholderColor
        instructionTv.text = ConstantTexts.OptionalPH
        instructionTv.delegate = self
        
        
        
        
        
        
        txtSearchField.font = ConstantFonts.TextFieldFont
        txtSearchField.textColor = AppColor.textColor
        txtSearchField.placeholder = ConstantTexts.SearchFriendsLT
        txtSearchField.delegate = self
        createGmeCV.register(nib: SelectLanguageCollectionViewCell.className)
        createGmeCV.delegate = self
        createGmeCV.dataSource = self
        
        selectLangCV.register(nib: SelectLanguageCollectionViewCell.className)
        selectLangCV.delegate = self
        selectLangCV.dataSource = self
        
        objevtiveCV.register(nib: CreategameObjectiveCollectionViewCell.className)
        objevtiveCV.delegate = self
        objevtiveCV.dataSource = self
        objevtiveCV.allowsMultipleSelection = false
        
        
        preciselyCV.register(nib: preciselyCollectionViewCell.className)
        
        addImagesCV.register(nib: AddImageCollectionViewCell.className)
        addImagesCV.delegate = self
        addImagesCV.dataSource = self
        
        
        
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.liveView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.timeView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.timerView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.searchView, 8.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.instructionTv, 12.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.addImageView, 8.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        sendInviteBtn.layer.cornerRadius = 16
        sendInviteBtn.clipsToBounds = true
        
        listExplanationApi()
        
    }
    
    func showHideMorePrecisely(){
        if objectives != String(){
            lblMorePre.text = ConstantTexts.MorePreciLT
            lblMorePeciselyTop.constant = 20
            lblMorePeciselyBottom.constant = 10
            heightMorePreciselyCol.constant = 50
            bottomheightMorePreciselyCol.constant = 20
        }else{
            lblMorePre.text = ConstantTexts.empty
            lblMorePeciselyTop.constant = 0
            lblMorePeciselyBottom.constant = 0
            heightMorePreciselyCol.constant = 0
            bottomheightMorePreciselyCol.constant = 0
        }
        
        
        preciselyCV.dataSource = self
        preciselyCV.delegate = self
        preciselyCV.reloadData()
       
        
    }
    
    
    
    internal func validation(){
        
        
        if mode.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.selectModeAlert)
            return
        }
        if languageCode.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.selectLanguageAlert)
            return
        }
        
        if socialId.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.selectfriendAlert)
            return
        }
        
        if objectives.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.selectObjectiveAlert)
            return
        }
        
        if morePresicely.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.selectPreciseAlert)
            return
        }
        
      /*  if photosArray.count == 0{
            HHelper.showAlert(ConstantTexts.selectImageAlert)
            return
        } */
        
        if instructionTv.text!.trimmingCharacters(in: .whitespaces) == "" || instructionTv.text!.trimmingCharacters(in: .whitespaces) == ConstantTexts.OptionalPH{
            
            userModel.customInstruction = String()
            
        }else{
            userModel.customInstruction = instructionTv.text!
        }
        
        self.fileName.removeAll()
        self.mimeType.removeAll()
        self.profileImage.removeAll()
        self.withName.removeAll()
        
        
        userModel.mode = self.mode
        userModel.languageCode = languageCode
        userModel.socialId = socialId
        userModel.objective = objectives
        userModel.morePrecisely = morePresicely
        var imageUrls = [String]()
        for index in 0..<photosArray.count{
            if photosArray[index]._id == String(){
                self.fileName.append("images[\(index)].jpeg")
                self.mimeType.append( "image/png")
                self.withName.append("images[\(index)]")
                self.profileImage.append(photosArray[index].image)
                print(photosArray[index].image)
            }else{
                imageUrls.append(photosArray[index].images)
            }
        }
        
        
        if profileImage.count == 0 && imageUrls.count == 0{
            self.fileName.append("images[\(0)].jpeg")
            self.mimeType.append( "image/png")
            self.withName.append("images[\(0)]")
            self.profileImage.append(#imageLiteral(resourceName: "IMG_20200518_165524"))
            
        }
        
        if var reqDict = userModel.toJSON() as? [String:Any]{
            print(reqDict)
            for index in 0..<imageUrls.count{
                reqDict["publicGallery[\(index)]"] = imageUrls[index]
            }
            print(reqDict)
            createGameApi(params:reqDict)
        }
        
        
        
        
    }
    
    
    
    internal func listExplanationApi(){
        
        
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
        
        print(token)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        SAuthService().getTypeService(serviceName: SAuthApi.listExplanation, header: headers).done { (response) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            if self.CountryDataModelCollecArr_Language.count > 0{
                self.CountryDataModelCollecArr_Language.removeAll()
            }
            
            if self.CountryDataModelCollecArr_SearchFriends.count > 0{
                self.CountryDataModelCollecArr_SearchFriends.removeAll()
            }
            
            if self.CountryDataModelCollecArr_Objective.count > 0{
                self.CountryDataModelCollecArr_Objective.removeAll()
            }
            
            if let itemDict = response.resultDict{
                print(itemDict)
                
                //TODO: For languages
                if let laguageArray = itemDict.value(forKey: "laguage") as? NSArray{
                    
                    var CountryDataModelCollecArr_LanguageTemp = [LanguageDataModel]()
                    
                    for item in laguageArray{
                        if let dataDict = item as? NSDictionary{
                            let languageArray = LanguageDataModel(__v: String(), _id: String(), code: String(), createdAt: String(), description: String(), language: String(), picture: String(), status: String(), isSelected: Bool())
                            if let picture = dataDict.value(forKey: "picture") as? String{
                                languageArray.picture = picture
                            }
                            
                            if let language = dataDict.value(forKey: "language") as? String{
                                languageArray.language = language
                            }
                            
                            if let description = dataDict.value(forKey: "description") as? String{
                                languageArray.description = description
                            }
                            
                            if let code = dataDict.value(forKey: "code") as? String{
                                languageArray.code = code
                            }
                            
                            if let _id = dataDict.value(forKey: "_id") as? String{
                                languageArray._id = _id
                            }
                            
                            if let status = dataDict.value(forKey: "status") as? String{
                                languageArray.status = status
                            }
                            CountryDataModelCollecArr_LanguageTemp.append(languageArray)
                        }
                    }
                    
                    do{
                        if let user = self.realm.objects(UserDataModel.self).first{
                            
                            print(user.languageCode)
                            let langCodeArray = user.languageCode.split(separator: ",")
                            print(langCodeArray)
                            
                            for code in langCodeArray{
                                for modelCode in CountryDataModelCollecArr_LanguageTemp{
                                    if code == modelCode.code{
                                        self.CountryDataModelCollecArr_Language.append(modelCode)
                                        break
                                    }
                                }
                            }
                            
                        }
                        
                    }catch{
                        print("Error in saving data :- \(error.localizedDescription)")
                    }
                    
                    
                    
                    self.selectLangCV.reloadData()
                }
                
                
                //TODO: For Fb friends
                
                if let friendsArray = itemDict.value(forKey: "fbFriends") as? NSArray{
                    for item in friendsArray{
                        if let dataDict = item as? NSDictionary{
                            let userData = CountryDataModelCollec(__v: String(), _id: String(), coinStatus: String(), dob: String(), email: String(), jwtToken: String(), languageCode: String(), name: String(), notificationStatus: String(), profilePic: String(), status: String(), totalPoints: String(), username: String(), type: String(), country: String(), defaultLangCode: String(), nationalit: String(), state: String(), aboutus: String(), city: String(), interest: String(), gender: String(), password: String(), descriptionUser: String(), socialId: String(), isSelected: Bool(), coins: String())
                            if let __v = dataDict.value(forKey: "__v") as? String{
                                userData.__v = __v
                            }
                            
                            if let socialId = dataDict.value(forKey: "socialId") as? String{
                                userData.socialId = socialId
                            }
                            
                            if let _id = dataDict.value(forKey: "_id") as? String{
                                userData._id = _id
                            }
                            
                            if let coinStatus = dataDict.value(forKey: "coinStatus") as? String{
                                userData.coinStatus = coinStatus
                            }
                            
                            if let coinStatus = dataDict.value(forKey: "coinStatus") as? Int{
                                userData.coinStatus = "\(coinStatus)"
                            }
                            
                            
                            if let coins = dataDict.value(forKey: "coins") as? String{
                                userData.coins = coins
                            }
                            
                            if let coins = dataDict.value(forKey: "coins") as? Int{
                                userData.coins = "\(coins)"
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
                    
                                userData.name = name.replacingOccurrences(of: " ", with: "\n")
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
                                userData.totalPoints = totalPoints
                            }
                            
                            if let totalPoints = dataDict.value(forKey: "totalPoints") as? Int{
                                userData.totalPoints = "\(totalPoints)"
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
                            
                            if let description = dataDict.value(forKey: "description") as? String{
                                userData.descriptionUser = description
                            }
                            
                            if let languadeCode = dataDict.value(forKey: "languageCode") as? NSArray{
                                userData.languageCode = languadeCode.componentsJoined(by: ",")
                            }
                            
                            
                            do{
                                if let user = self.realm.objects(UserDataModel.self).first{
                                    if userData._id != user._id{
                                        self.CountryDataModelCollecArr_SearchFriends.append(userData)
                                    }
                                }
                            }catch{
                                print("Error in saving data :- \(error.localizedDescription)")
                            }
                            
                            
                            
                        }
                    }
                    self.createGmeCV.reloadData()
                }
                
                
                //TODO: For Fb Objective
                
                if let ObjectiveArray = itemDict.value(forKey: "Objective") as? NSArray{
                    for index in 0..<ObjectiveArray.count{
                        
                        if let dataDict = ObjectiveArray[index] as? NSDictionary{
                            let userData = Objective(__v: String(), _id: String(), explanation: String(), createdAt: String(), pictureSelected: String(), pictureUnSelected: String(), MorereciselyArray: [Morerecisely](), isSelected: Bool())
                           
                            userData.isSelected = Bool()
                            
                            if let __v = dataDict.value(forKey: "__v") as? String{
                                userData.__v = __v
                            }
                            
                            if let _id = dataDict.value(forKey: "_id") as? String{
                                userData._id = _id
                            }
                            
                            if let explanation = dataDict.value(forKey: "explanation") as? String{
                                self.objectives = String()
                                userData.isSelected = Bool()
                                userData.explanation = explanation
                            }
                            
                            if let createdAt = dataDict.value(forKey: "createdAt") as? String{
                                userData.createdAt = createdAt
                            }
                            
                            if let pictureArray = dataDict.value(forKey: "picture") as? NSArray{
                                for picture in pictureArray{
                                    if let pictureDict = picture as? NSDictionary{
                                        if let type = pictureDict.value(forKey: "type") as? String{
                                            if type == "selected"{
                                                if let picture = pictureDict.value(forKey: "picture") as? String{
                                                    userData.pictureSelected = picture
                                                }
                                            }else{
                                                if let picture = pictureDict.value(forKey: "picture") as? String{
                                                    userData.pictureUnSelected = picture
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            self.CountryDataModelCollecArr_Objective.append(userData)
                        }
                    }
                    self.objevtiveCV.reloadData()
                }
                
                //TODO: For Morerecisely
                var tempMorerecisely = [Morerecisely]()
                if let MorereciselyArray = itemDict.value(forKey: "Morerecisely") as? NSArray{
                    for item in MorereciselyArray{
                        
                        if let dataDict = item as? NSDictionary{
                            let MorereciselyItem = Morerecisely(__v: String(), _id: String(), converse: String(), createdAt: String(), explanation_id: String(), isSelected: Bool())
                            if let __v = dataDict.value(forKey: "__v") as? String{
                                MorereciselyItem.__v = __v
                            }
                            
                            if let _id = dataDict.value(forKey: "_id") as? String{
                                MorereciselyItem._id = _id
                            }
                            
                            if let converse = dataDict.value(forKey: "converse") as? String{
                                MorereciselyItem.converse = converse
                            }
                            
                            if let createdAt = dataDict.value(forKey: "createdAt") as? String{
                                MorereciselyItem.createdAt = createdAt
                            }
                            
                            if let explanation_id = dataDict.value(forKey: "explanation_id") as? String{
                                MorereciselyItem.explanation_id = explanation_id
                            }
                            tempMorerecisely.append(MorereciselyItem)
                        }
                    }
                }
                
                
                for index_i in 0..<self.CountryDataModelCollecArr_Objective.count{
                    for index_j in 0..<tempMorerecisely.count{
                        if tempMorerecisely[index_j].explanation_id == self.CountryDataModelCollecArr_Objective[index_i]._id{
                            self.CountryDataModelCollecArr_Objective[index_i].MorereciselyArray.append(tempMorerecisely[index_j])
                            break
                        }
                    }
                    
                }
                
                
                self.preciselyCV.delegate = self
                self.preciselyCV.dataSource = self
                self.preciselyCV.reloadData()
                
                
                
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
    
    
    internal func createGameApi(params:[String:Any]){
        
        
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
                self.selectedFriend.name = self.userName
                self.selectedFriend.profilePic = self.profilePic
                vc.selectedFriend = self.selectedFriend
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
                vc.languangeCode = self.languageCode
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
                
                
                self.roomCreateSocketForCreate(reci_id, gameId)
                
                
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
    
    
    
    internal func roomCreateSocketForCreate(_ receiverId: String, _ gameId: String){
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
        userModel.languageCode = languageCode
        
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
                    
                    print(self.userName)
                    print(self.profilePic)
                    
                    MorereciselyItem.name = self.userName
                    MorereciselyItem.profilePic = self.profilePic
                    
                    
                    
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




//MARK: - TextField Delegate Mathod

extension GameCreateViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if filtered.count > 0{
            filtered.removeAll()
        }
        
        let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if newText.count > 0 {
            searchActive = true
            if CountryDataModelCollecArr_SearchFriends.count > 0 {
                for index in 0..<CountryDataModelCollecArr_SearchFriends.count {
                    if let dictResponse = CountryDataModelCollecArr_SearchFriends[index] as? CountryDataModelCollec{
                        
                        if let restName = dictResponse.name as? String{
                            if (restName.lowercased().range(of: newText.lowercased()) != nil) {
                                filtered.append(dictResponse)
                            }
                        }
                    }
                }
            }
            
        }else {
            searchActive = false
            
        }
        createGmeCV.reloadData()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        for index in 0..<CountryDataModelCollecArr_SearchFriends.count{
            CountryDataModelCollecArr_SearchFriends[index].isSelected = Bool()
        }
        return true
    }
    
}

//MARK: - Textview delegates
extension GameCreateViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == AppColor.placeholderColor {
            textView.text = nil
            textView.textColor = AppColor.textColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ConstantTexts.OptionalPH
            textView.textColor = AppColor.placeholderColor
        }
    }
    
}
