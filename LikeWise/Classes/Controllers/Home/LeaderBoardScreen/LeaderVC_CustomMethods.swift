//
//  LeaderVC_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 28/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
//MARK: - Extension custom methods
extension LeaderBoardVC{
    
    
    //TODO: Initial setup method
    internal func initialSetup(){
        self.view.backgroundColor = AppColor.themeColorDark
        viewHeader.backgroundColor = AppColor.themeColorDark
        tblView_leader.hideEmptyCells()
        tblView_leader.separatorStyle = .none
        tblView_leader.backgroundColor = AppColor.clearColor
        tblView_leader.register(nib: LeaderboardCell.className)
        
        
        
        
        
        
        uperView.backgroundColor = AppColor.themeColorLight
        CustomMethods.shared.provideShadowAndCornerRadius(uperView, 10, AppColor.textColor, 2, 2, 0.5, 5, 0, AppColor.clearColor)
        
        lblName.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0)
        lblName.textColor = AppColor.whiteColor
        
        lblDetail.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblDetail.textColor = AppColor.whiteColor
        
        lblTimings.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 20.0)
        lblTimings.textColor = AppColor.whiteColor
        
        
        lblGameCount.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblGameCount.textColor = AppColor.whiteColor
        
        
        
        
        
        
        // MARK: - init and setup DYPieChartView
        pieChartView.startAngle = -.pi / 2
        pieChartView.clockwise = true
        pieChartView.lineWidth = 5
        pieChartView.backgroundColor = AppColor.whiteColor
        
        pieChartView.sectorColors = [
            AppColor.themeColorDark,
            AppColor.placeholderColor
        ]
        
        // MARK: - animations
        //type 1: for duration
        pieChartView.animate(toScaleValues: [NSNumber(value: 0.8),NSNumber(value: 0.2)], duration: 2)
        //type 2: quickly
        
       
        
        
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.LeaderBoardLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0), AppColor.whiteColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n(\(ConstantTexts.PublicGamesLT))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.placeholderColor))
        
        lblTitle.numberOfLines = 0
        lblTitle.attributedText = myMutableString
        
        
        CustomMethods.shared.provideCornerRadiusTo(self.imgProfile, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        imgProfile.contentMode = .scaleAspectFill
        
      
        getUserData()
        
    }
    
    
   internal func getUserData(){
         let realm = try! Realm()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                self.lblName.text = user.name
                lblDetail.text = "\(round(user.totalPoints))"
                self.imgProfile.sd_setImage(with: URL(string: user.profilePic), placeholderImage: UIImage(named: "profile_pic"))
                
                leaderboardApi()
               
            }
           
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }

    
    //TODO: api for get find patner list
    internal func leaderboardApi(){
        
        var token = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
                userModel.id = user._id
                
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        let headers = ["authorization":token,
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.leaderboard, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            if self.leaderBoardArray.count > 0{
                self.leaderBoardArray.removeAll()
            }
            if let dataArray = response.resultArray as? NSArray{
                for item in dataArray{
                    if let dataDict = item as? NSDictionary{
                        let itemModel = LeaderBoardDataModel(gameCounts: Int(), likewisePer: Int(), scores: Int(), All_LikeWise_Number: String(), All_LikeWise_Persantege: String(), _id: String(), gender: String(), name: String(), aboutus: String(), profilePic: String(), userValue: String(), city: String(), coinDate: String(), coinStatus: Int(), coins: Int(), country: String(), createdAt: String(), defaultLangCode: String(), dob: String(), email: String(), interest: String(), languageCode: String(), mobileNumber: String(), nationalit: String(), notification: Int(), socialId: String(), socialType: String(), state: String(), status: Int(), totalPoints: Int(), type: Int(), username: String())
                        
                        if let gameCounts = dataDict.value(forKey: "gameCounts") as? Int{
                            itemModel.gameCounts = gameCounts
                        }
                        
                        if let gameCounts = dataDict.value(forKey: "gameCounts") as? String{
                            itemModel.gameCounts = Int(gameCounts) ?? 0
                        }
                        
                        if let likewisePer = dataDict.value(forKey: "likewisePer") as? Int{
                            itemModel.likewisePer = likewisePer
                        }
                        
                        if let likewisePer = dataDict.value(forKey: "likewisePer") as? String{
                            itemModel.likewisePer = Int(likewisePer) ?? 0
                        }
                        
                        if let scores = dataDict.value(forKey: "scores") as? Int{
                            itemModel.scores = scores
                        }
                        
                        if let scores = dataDict.value(forKey: "scores") as? String{
                            itemModel.scores = Int(scores) ?? 0
                        }
                        
                        if let userDetails = dataDict.value(forKey: "userDetails") as? NSDictionary{
                            
                            if let All_LikeWise_Number = userDetails.value(forKey: "All_LikeWise_Number") as? Int{
                                itemModel.All_LikeWise_Number = "\(All_LikeWise_Number)"
                            }
                            
                            if let All_LikeWise_Number = userDetails.value(forKey: "All_LikeWise_Number") as? String{
                                itemModel.All_LikeWise_Number = All_LikeWise_Number
                            }
                            
                            if let All_LikeWise_Persantege = userDetails.value(forKey: "All_LikeWise_Persantege") as? Int{
                                itemModel.All_LikeWise_Persantege = "\(All_LikeWise_Persantege)"
                            }
                            
                            if let All_LikeWise_Persantege = userDetails.value(forKey: "All_LikeWise_Persantege") as? String{
                                itemModel.All_LikeWise_Persantege = All_LikeWise_Persantege
                            }
                            
                            if let _id = userDetails.value(forKey: "_id") as? String{
                                itemModel._id = _id
                            }
                            
                            if let aboutus = userDetails.value(forKey: "aboutus") as? String{
                                itemModel.aboutus = aboutus
                            }
                            
                            if let city = userDetails.value(forKey: "city") as? String{
                                itemModel.city = city
                            }
                            
                            if let coinDate = userDetails.value(forKey: "coinDate") as? String{
                                itemModel.coinDate = coinDate
                            }
                            
                            if let coinStatus = userDetails.value(forKey: "coinStatus") as? Int{
                                itemModel.coinStatus = coinStatus
                            }
                            
                            if let coinStatus = userDetails.value(forKey: "coinStatus") as? String{
                                itemModel.coinStatus = Int(coinStatus) ?? 0
                            }
                            
                            if let coins = userDetails.value(forKey: "coins") as? Int{
                                itemModel.coins = coins
                            }
                            
                            if let coins = userDetails.value(forKey: "coins") as? String{
                                itemModel.coins = Int(coins) ?? 0
                            }
                            
                            if let country = userDetails.value(forKey: "country") as? String{
                                itemModel.country = country
                            }
                            
                            if let createdAt = userDetails.value(forKey: "createdAt") as? String{
                                itemModel.createdAt = createdAt
                            }
                            
                            if let defaultLangCode = userDetails.value(forKey: "defaultLangCode") as? String{
                                itemModel.defaultLangCode = defaultLangCode
                            }
                            
                            if let dob = userDetails.value(forKey: "dob") as? String{
                                itemModel.dob = dob
                            }
                            
                            if let email = userDetails.value(forKey: "email") as? String{
                                itemModel.email = email
                            }
                            
                            if let gender = userDetails.value(forKey: "gender") as? String{
                                itemModel.gender = gender
                            }
                            
                            if let interest = userDetails.value(forKey: "interest") as? String{
                                itemModel.interest = interest
                            }
                            
                            if let mobileNumber = userDetails.value(forKey: "mobileNumber") as? String{
                                itemModel.mobileNumber = mobileNumber
                            }
                            
                            if let name = userDetails.value(forKey: "name") as? String{
                                itemModel.name = name
                            }
                            
                            if let nationalit = userDetails.value(forKey: "nationalit") as? String{
                                itemModel.nationalit = nationalit
                            }
                            
                            if let notification = userDetails.value(forKey: "notification") as? Int{
                                itemModel.notification = notification
                            }
                            
                            if let notification = userDetails.value(forKey: "notification") as? String{
                                itemModel.notification = Int(notification) ?? 0
                            }
                            
                            if let profilePic = userDetails.value(forKey: "profilePic") as? String{
                                itemModel.profilePic = profilePic
                            }
                            
                            if let socialId = userDetails.value(forKey: "socialId") as? String{
                                itemModel.socialId = socialId
                            }
                            
                            if let socialType = userDetails.value(forKey: "socialType") as? String{
                                itemModel.socialType = socialType
                            }
                            
                            if let state = userDetails.value(forKey: "state") as? String{
                                itemModel.state = state
                            }
                            
                            if let status = userDetails.value(forKey: "status") as? Int{
                                itemModel.status = status
                            }
                            
                            if let status = userDetails.value(forKey: "status") as? String{
                                itemModel.status = Int(status) ?? 0
                            }
                            
                            if let totalPoints = userDetails.value(forKey: "totalPoints") as? Int{
                                itemModel.totalPoints = totalPoints
                            }
                            
                            if let totalPoints = userDetails.value(forKey: "totalPoints") as? String{
                                itemModel.totalPoints = Int(totalPoints) ?? 0
                            }
                            
                            if let type = userDetails.value(forKey: "type") as? Int{
                                itemModel.type = type
                            }
                            
                            if let type = userDetails.value(forKey: "type") as? String{
                                itemModel.type = Int(type) ?? 0
                            }
                            
                            if let userValue = userDetails.value(forKey: "userValue") as? String{
                                itemModel.userValue = userValue
                            }
                            
                            if let username = userDetails.value(forKey: "username") as? String{
                                itemModel.username = username
                            }
                            
                        }
                        
                       
                        
                        do{
                            if let user = self.realm.objects(UserDataModel.self).first{
                                if itemModel._id != user._id{
                                    self.leaderBoardArray.append(itemModel)
                                }else{
                                    
                                    self.lblTimings.text = "\(itemModel.gameCounts)"
                                    self.lblDetail.text = "\(itemModel.totalPoints)"
                                    self.lblGameCount.text = "\(itemModel.All_LikeWise_Number) \(ConstantTexts.GamesLT)"
                                    self.percentageLbl.text = "\(itemModel.All_LikeWise_Persantege)\(ConstantTexts.PerLT)"
                                    self.imgFB.isHidden = (itemModel.type == 1) ? false : true
                                    
                                    
                                    self.pieChartView.animate(toScaleValues: [NSNumber(value: (Double(itemModel.All_LikeWise_Persantege) ?? 0.0)/100),NSNumber(value: (100 - (Double(itemModel.All_LikeWise_Persantege) ?? 0.0))/100)], duration: 2)
                                }
                            }
                        }catch{
                            print("Error in saving data :- \(error.localizedDescription)")
                        }
                        

                        
                        
                        self.leaderBoardArray.append(itemModel)
                        
                        
                    }
                }
                
                self.tblView_leader.reloadData()
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

