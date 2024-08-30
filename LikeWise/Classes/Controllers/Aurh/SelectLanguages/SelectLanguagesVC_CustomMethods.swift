//
//  SelectLanguagesVC_CustomMethods.swift
//  LikeWise
//
//  Created by Deepti Sharma on 20/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


//MARK: - Extension Custom methods
extension SelectLanguagesVC{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(false)
        super.addColorToNavigationBarAndSafeArea(color: AppColor.clearColor)
        super.setupNavigationBarTitleWithAttributedString(ConstantTexts.selectHeaderHT, ConstantTexts.selectHeaderSubtitleHT, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
    }        
    
    
    //TODO: Initial setup method
    internal func initialSetup(){
        
        imgBackgroud.image = AppImages.bgImage
        
        
        CustomMethods.shared.provideShadowAndCornerRadius(tblLanguage, 20, AppColor.clearColor, 0, 0, 0, 10, 1, AppColor.placeholderColor)
        
        CustomMethods.shared.provideCornerRadiusTo(btnSaveRef, btnSaveRef.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.setupButton(btnSaveRef, AppColor.themeColorDark,AppColor.whiteColor,ConstantFonts.SubmitButtonFont, ConstantTexts.okBT)
        
        countryDataModelArray.append(CountryDataModelMain(title: ConstantTexts.MostPopularLT, array: [CountryDataModel]()))
        
        countryDataModelArray.append(CountryDataModelMain(title: ConstantTexts.OthersLT, array: [CountryDataModel]()))
        
        
        tblLanguage.hideEmptyCells()
        tblLanguage.separatorStyle = .none
        tblLanguage.backgroundColor = AppColor.whiteColor
        tblLanguage.register(nib: SelectLanguage_TableViewCell.className)
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tblLanguage.tableHeaderView = UIView(frame: frame)
        
        
        hitLanguageListApi()
    }
    
}

extension SelectLanguagesVC{
    
    //TODO: api for language list
    internal func hitLanguageListApi(){
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        
        print(headers)
        
        
       
            CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        
        SAuthService().getTypeService(serviceName: SAuthApi.languageList, header: headers).done { (response) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            
            if let data = response.resultArray as? NSArray{
                
                var popularArray = [CountryDataModel]()
                var otherArray = [CountryDataModel]()
                for item in data{
                    
                    let languageArray = CountryDataModel(picture: String(), _id: String(), code: String(), description: String(), language: String(), __v: String(), isSelected: Bool())
                    
                    if let dataDict = item as? NSDictionary{
                        
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
                            if status == "1"{
                                popularArray.append(languageArray)
                            }else{
                                otherArray.append(languageArray)
                            }
                        }
                        self.countryDataModelArray[0].array = popularArray
                        self.countryDataModelArray[1].array = otherArray
                    }
                }
                
                if self.isComingEditProfile{
                    
                    for item in self.oldLang{
                        for i in 0..<self.countryDataModelArray.count{
                            for j in 0..<self.countryDataModelArray[i].array.count{
                                if item == self.countryDataModelArray[i].array[j].code{
                                    self.countryDataModelArray[i].array[j].isSelected = true
                                    break
                                }
                            }
                        }
                    }
                }
                
                
                
                self.tblLanguage.reloadData()
                self.tblHeight.constant = self.tblLanguage.contentSize.height
            }
        }.catch { (error) in
            
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            let nsError = error as NSError
            HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
        }
    }
    
    //TODO: api for sign up
    internal func hitSignUpApi(){
        let headers:HTTPHeaders = [
            "Content-Type":"application/json",
            "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.signUp, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            print(response)
            
            if let dataDict = response.resultDict as? NSDictionary{
                let userData = UserDataModel()
                if let __v = dataDict.value(forKey: "__v") as? String{
                    userData.__v = __v
                }
                
                if let _id = dataDict.value(forKey: "_id") as? String{
                    userData._id = _id
                }
                if let coinStatus = dataDict.value(forKey: "coinStatus") as? String{
                    userData.coinStatus = Double(coinStatus) ?? 0.0
                }
                
                if let coinStatus = dataDict.value(forKey: "coinStatus") as? Double{
                    userData.coinStatus = Double(coinStatus) ?? 0.0
                }
                
                if let coins = dataDict.value(forKey: "coins") as? String{
                    userData.coins = Double(coins) ?? 0.0
                }
                
                if let coins = dataDict.value(forKey: "coins") as? Double{
                    userData.coins = Double(coins) ?? 0.0
                }
                
                if let coins = dataDict.value(forKey: "coins") as? Int{
                    userData.coins = Double(coins) ?? 0.0
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
                    userData.name = name
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
                    userData.totalPoints = Double(totalPoints) ?? 0.0
                }
                
                if let totalPoints = dataDict.value(forKey: "totalPoints") as? Double{
                    userData.totalPoints = Double(totalPoints) ?? 0.0
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
                
                if let interest1 = dataDict.value(forKey: "interest1") as? String{
                    userData.interest1 = interest1
                }
                
                if let interest2 = dataDict.value(forKey: "interest2") as? String{
                    userData.interest2 = interest2
                }
                
                if let interest3 = dataDict.value(forKey: "interest3") as? String{
                    userData.interest3 = interest3
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
                
                
                CustomMethods.shared.saveUserData(item: userData, callBack: {
                    kAppDelegate.openDrawer()
                })
                
                
            }
            
            
        }.catch { (error) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            let nsError = error as NSError
            if let error = nsError.userInfo["errorMessage"] as? String{
                HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
            }
        }
        
    }
    
    //TODO: api for guest user
    internal func hitGuestLoginApi(){
        let headers:HTTPHeaders = [
            "Content-Type":"application/json",
            "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.guestLogin, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            if let dataDict = response.resultDict as? NSDictionary{
                let userData = UserDataModel()
                if let __v = dataDict.value(forKey: "__v") as? String{
                    userData.__v = __v
                }
                
                if let _id = dataDict.value(forKey: "_id") as? String{
                    userData._id = _id
                }
                
                if let coinStatus = dataDict.value(forKey: "coinStatus") as? String{
                    userData.coinStatus = Double(coinStatus) ?? 0.0
                }
                
                if let coinStatus = dataDict.value(forKey: "coinStatus") as? Double{
                    userData.coinStatus = Double(coinStatus) ?? 0.0
                }
                
                if let coins = dataDict.value(forKey: "coins") as? String{
                    userData.coins = Double(coins) ?? 0.0
                }
                
                if let coins = dataDict.value(forKey: "coins") as? Double{
                    userData.coins = Double(coins) ?? 0.0
                }
                
                if let coins = dataDict.value(forKey: "coins") as? Int{
                    userData.coins = Double(coins) ?? 0.0
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
                    userData.name = name
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
                    userData.totalPoints = Double(totalPoints) ?? 0.0
                }
                
                if let totalPoints = dataDict.value(forKey: "totalPoints") as? Double{
                    userData.totalPoints = Double(totalPoints) ?? 0.0
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
                
                if let interest1 = dataDict.value(forKey: "interest1") as? String{
                    userData.interest1 = interest1
                }
                
                if let interest2 = dataDict.value(forKey: "interest2") as? String{
                    userData.interest2 = interest2
                }
                
                if let interest3 = dataDict.value(forKey: "interest3") as? String{
                    userData.interest3 = interest3
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
                
                CustomMethods.shared.saveUserData(item: userData, callBack: {
                    kAppDelegate.openDrawer()
                })
                
                
            }
            
            
        }.catch { (error) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            let nsError = error as NSError
            if let error = nsError.userInfo["errorMessage"] as? String{
                HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
            }
        }
        
    }
    
    
    
    //TODO: facebook api hit
    func hitSocialLoginApi(){
        
        let headers:HTTPHeaders = [
            "Content-Type":"application/json",
            "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.socialLogin, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            
            if let dataDict = response.resultDict as? NSDictionary{
                let userData = UserDataModel()
                if let __v = dataDict.value(forKey: "__v") as? String{
                    userData.__v = __v
                }
                
                if let _id = dataDict.value(forKey: "_id") as? String{
                    userData._id = _id
                }
                
                if let coinStatus = dataDict.value(forKey: "coinStatus") as? String{
                    userData.coinStatus = Double(coinStatus) ?? 0.0
                }
                
                if let coinStatus = dataDict.value(forKey: "coinStatus") as? Double{
                    userData.coinStatus = Double(coinStatus) ?? 0.0
                }
                
                if let coins = dataDict.value(forKey: "coins") as? String{
                    userData.coins = Double(coins) ?? 0.0
                }
                
                if let coins = dataDict.value(forKey: "coins") as? Double{
                    userData.coins = Double(coins) ?? 0.0
                }
                
                if let coins = dataDict.value(forKey: "coins") as? Int{
                    userData.coins = Double(coins) ?? 0.0
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
                    userData.name = name
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
                    userData.totalPoints = Double(totalPoints) ?? 0.0
                }
                
                if let totalPoints = dataDict.value(forKey: "totalPoints") as? Double{
                    userData.totalPoints = Double(totalPoints) ?? 0.0
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
                
                if let interest1 = dataDict.value(forKey: "interest1") as? String{
                    userData.interest1 = interest1
                }
                
                if let interest2 = dataDict.value(forKey: "interest2") as? String{
                    userData.interest2 = interest2
                }
                
                if let interest3 = dataDict.value(forKey: "interest3") as? String{
                    userData.interest3 = interest3
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
                
                CustomMethods.shared.saveUserData(item: userData, callBack: {
                    kAppDelegate.openDrawer()
                })
                
                
            }
            
        }.catch { (error) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            let nsError = error as NSError
            if let error = nsError.userInfo["errorMessage"] as? String{
                HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
            }
        }
        
    }
    
}
