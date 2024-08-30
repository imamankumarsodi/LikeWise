//
//  PlayGameExtensionMethod.swift
//  LikeWise
//
//  Created by cst on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift

extension PlayGameViewController{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    internal func initialSetUp(){
        
        lblHeaderTitle.font = ConstantFonts.SubmitButtonFont
        lblHeaderTitle.textColor = AppColor.whiteColor
        lblHeaderTitle.text = ConstantTexts.PlayGameLT
        
        lblSelectLangTitle.font = ConstantFonts.TextFieldFont
        lblSelectLangTitle.textColor = AppColor.textColor
        lblSelectLangTitle.text = ConstantTexts.SelectOneOfLangLT
        
        lblSelectModeTitle.font = ConstantFonts.TextFieldFont
        lblSelectModeTitle.textColor = AppColor.textColor
        lblSelectModeTitle.text = ConstantTexts.SelectModeLT
        
        lblTimeLeft.numberOfLines = 0
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.TimeLT, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
        
//        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n(\("90 \(ConstantTexts.SecondsSLT)"))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
        
        lblTimeLeft.attributedText = myMutableString
        lblLifeLeft.numberOfLines = 0
        
        let MyMutableString = NSMutableAttributedString()
        MyMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.LivesLT, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
        
//        MyMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n(\("8 \(ConstantTexts.TrialsSLT)"))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
//
        lblLifeLeft.attributedText = MyMutableString
        
        langCV.register(nib: SelectLanguageCollectionViewCell.className)
        langCV.delegate  = self
        langCV.dataSource = self
        
        self.liveView.backgroundColor = AppColor.whiteColor
        self.timeView.backgroundColor = AppColor.whiteColor
        liveImg.image = UIImage(named: "life_un")
        timerImg.image = UIImage(named: "timeUN")
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.liveView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.timeView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.modeView, 15.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.languageView, 15.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.setupButton(goBtn, AppColor.themeColorLight,AppColor.whiteColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0), ConstantTexts.goBT)
        
        CustomMethods.shared.provideCornerRadiusTo(goBtn, goBtn.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        self.timeView.backgroundColor = AppColor.themeColorLight
        self.liveView.backgroundColor = AppColor.whiteColor
        liveImg.image = UIImage(named: "life_un")
        timerImg.image = UIImage(named: "timeNew")
         type = "1"
        
        hitLanguageListApi()
    }
    
    internal func validation(){
        
        if sideNAme == -1 {
            HHelper.showAlert(ConstantTexts.selectLanguageAlert)
            return
        }
        
        if type.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.selectModeAlert)
            return
        }
        
        
        
        userModel.type = type
        userModel.languageCode = CountryDataModelCollecArr[sideNAme].languageCode
        getFindPatnerApi()
    }
    
    
    
    
    
    //TODO: api for language list
    internal func hitLanguageListApi(){
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        SAuthService().getTypeService(serviceName: SAuthApi.languageList, header: headers).done { (response) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            if let data = response.resultArray as? NSArray{
                var CountryDataModelCollecArr_LanguageTemp = [CountryDataModelCollec]()
                if CountryDataModelCollecArr_LanguageTemp.count > 0{
                    CountryDataModelCollecArr_LanguageTemp.removeAll()
                }
                for item in data{
                    
                    let languageArray = CountryDataModelCollec(__v: String(), _id: String(), coinStatus: String(), dob: String(), email: String(), jwtToken: String(), languageCode: String(), name: String(), notificationStatus: String(), profilePic: String(), status: String(), totalPoints: String(), username: String(), type: String(), country: String(), defaultLangCode: String(), nationalit: String(), state: String(), aboutus: String(), city: String(), interest: String(), gender: String(), password: String(), descriptionUser: String(), socialId: String(), isSelected: Bool(), coins: String())
                    
                    if let user = self.realm.objects(UserDataModel.self).first{
                        self.defaultLang = user.defaultLangCode
                    }
                    
                    if let dataDict = item as? NSDictionary{
                        
                        if let picture = dataDict.value(forKey: "picture") as? String{
                            languageArray.profilePic = picture
                        }
                        
                        if let language = dataDict.value(forKey: "language") as? String{
                            languageArray.name = language
                        }
                        
                        if let description = dataDict.value(forKey: "description") as? String{
                            languageArray.descriptionUser = description
                        }
                        
                        if let code = dataDict.value(forKey: "code") as? String{
                            languageArray.languageCode = code
                        }
                        
                        if let _id = dataDict.value(forKey: "_id") as? String{
                            languageArray._id = _id
                            languageArray.defaultLangCode = self.defaultLang
                        }
                        
                        if let status = dataDict.value(forKey: "status") as? String{
                            print(status)
                        }
                        
                       
                        CountryDataModelCollecArr_LanguageTemp.append(languageArray)
                    }
                }
                
                do{
                    if let user = self.realm.objects(UserDataModel.self).first{
                        self.defaultLang = user.defaultLangCode
                        print(user.languageCode)
                        let langCodeArray = user.languageCode.split(separator: ",")
                        
                        print(langCodeArray)
                        
                        for code in langCodeArray{
                            for modelCode in CountryDataModelCollecArr_LanguageTemp{
                                
                                
                                print("p",modelCode.defaultLangCode)
                                if code == modelCode.languageCode{
                                    
                                    self.CountryDataModelCollecArr.append(modelCode)
                                    
                                    break
                                }
                            }
                        }
                        
                        
                        for index in 0..<self.CountryDataModelCollecArr.count{
                            if self.defaultLang == self.CountryDataModelCollecArr[index].languageCode{
                                self.CountryDataModelCollecArr[index].isSelected = true
                                self.sideNAme = self.CountryDataModelCollecArr[index].isSelected ? index : -1
                            }else{
                                 self.CountryDataModelCollecArr[index].isSelected = Bool()
                            }
                        }
                        
                    }
                    
                }catch{
                    print("Error in saving data :- \(error.localizedDescription)")
                }
                
                self.langCV.reloadData()
                
            }
        }.catch { (error) in
            
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            let nsError = error as NSError
            HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
        }
    }
    
    
    //TODO: api for get find patner list
    internal func getFindPatnerApi(){
        
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
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.getFindPatner, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            
            print(response)
          
            if response.status == "false" {
                
                let vc = AppStoryboard.home.instantiateViewController(withIdentifier: TimeNotFoundViewController.className) as! TimeNotFoundViewController
                self.navigationController?.pushViewController(vc, animated: false)
                
            }else{
                if self.CountryDataModelCollecArr_Objective.count > 0{
                    self.CountryDataModelCollecArr_Objective.removeAll()
                }
                
                if self.PlayGameUserModel_Array.count > 0{
                    self.PlayGameUserModel_Array.removeAll()
                }
                
                if self.RandomImagesModelArray.count > 0{
                    self.RandomImagesModelArray.removeAll()
                }
                
                
                if let itemDict = response.resultDict{
                    print(itemDict)
                    
                    
                    if let followerDetail = itemDict.value(forKey: "followerDetail") as? NSArray{
                        for index in 0..<followerDetail.count{
                            if let dataDict = followerDetail[index] as? NSDictionary{
                                let image = RandomImagesModel(Image: String(), count: String())
                                if let count = dataDict.value(forKey: "count") as? String{
                                    image.count = count
                                }
                                
                                if let count = dataDict.value(forKey: "count") as? Int{
                                    image.count = "\(count)"
                                }
                                
                                if let _id = dataDict.value(forKey: "_id") as? NSDictionary{
                                    if let Image = _id.value(forKey: "Image") as? String{
                                        image.Image = Image
                                    }
                                }
                                
                                self.RandomImagesModelArray.append(image)
                            }
                        }
                        
                    }
                    
                    
                    //TODO: For Fb Objective
                    
                    if let ObjectiveArray = itemDict.value(forKey: "explanationModel") as? NSArray{
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
                        
                    }
                    
                    //TODO: For Morerecisely
                    var tempMorerecisely = [Morerecisely]()
                    if let MorereciselyArray = itemDict.value(forKey: "converseModel") as? NSArray{
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
                    
                    if let userDetails = itemDict.value(forKey: "userDetails") as? NSArray{
                        for index in 0..<userDetails.count{
                            if let dataDict = userDetails[index] as? NSDictionary{
                                let userData = PlayGameUserModel(All_LikeWise_Number: String(), All_LikeWise_Persantege: String(), _id: String(), gender: String(), name: String(), profilePic: String(), userValue: String())
                                
                                if let All_LikeWise_Number = dataDict.value(forKey: "All_LikeWise_Number") as? String{
                                    userData.All_LikeWise_Number = All_LikeWise_Number
                                }
                                
                                if let All_LikeWise_Number = dataDict.value(forKey: "All_LikeWise_Number") as? Int{
                                    userData.All_LikeWise_Number = "\(All_LikeWise_Number)"
                                }
                                
                                if let All_LikeWise_Persantege = dataDict.value(forKey: "All_LikeWise_Persantege") as? String{
                                    userData.All_LikeWise_Persantege = All_LikeWise_Persantege
                                }
                                
                                if let All_LikeWise_Persantege = dataDict.value(forKey: "All_LikeWise_Persantege") as? Int{
                                    userData.All_LikeWise_Persantege = "\(All_LikeWise_Persantege)"
                                }
                                
                                if let _id = dataDict.value(forKey: "_id") as? String{
                                    userData._id = _id
                                }
                                
                                if let gender = dataDict.value(forKey: "gender") as? String{
                                    userData.gender = gender
                                }
                                
                                if let name = dataDict.value(forKey: "name") as? String{
                                    userData.name = name
                                }
                                
                                if let profilePic = dataDict.value(forKey: "profilePic") as? String{
                                    userData.profilePic = profilePic
                                }
                                
                                if let userValue = dataDict.value(forKey: "userValue") as? String{
                                    userData.userValue = userValue
                                }
                                
                                if let userValue = dataDict.value(forKey: "userValue") as? Double{
                                    userData.userValue = "\(userValue)"
                                }
                                
                                do{
                                    if let user = self.realm.objects(UserDataModel.self).first{
                                        if userData._id != user._id{
                                            self.PlayGameUserModel_Array.append(userData)
                                        }
                                    }
                                }catch{
                                    print("Error in saving data :- \(error.localizedDescription)")
                                }
                                
                                
                                
                            }
                            
                        }
                    }
                }
                
                let vc = AppStoryboard.home.instantiateViewController(withIdentifier: LiveInviteSentViewController.className) as! LiveInviteSentViewController
                
                vc.CountryDataModelCollecArr_Objective = self.CountryDataModelCollecArr_Objective
                vc.PlayGameUserModel_Array = self.PlayGameUserModel_Array
                vc.RandomImagesModelArray = self.RandomImagesModelArray
                vc.languageArray = self.CountryDataModelCollecArr[self.sideNAme]
                vc.mode = self.type
                self.navigationController?.pushViewController(vc, animated: true)
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
