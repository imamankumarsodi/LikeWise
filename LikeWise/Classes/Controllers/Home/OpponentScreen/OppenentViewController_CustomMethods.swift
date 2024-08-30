//
//  OppenentViewController_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Extension Custom methods
extension OppenentViewController{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    //TODO: Initial setup method
    internal func initialSetup(){
        
        
        
        CustomMethods.shared.setupButton(btnEditRef, AppColor.themeColorDark,AppColor.whiteColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), ConstantTexts.invitePlayBT)
        
        CustomMethods.shared.provideCornerRadiusTo(btnEditRef, btnEditRef.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        lblName.font = ConstantFonts.SubmitButtonFont
        lblName.textColor = AppColor.whiteColor
        
        
        CustomMethods.shared.provideCornerRadiusTo(self.profileImg, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        profileImg.contentMode = .scaleAspectFill
        
        
       
        
        //TODO: Section 1
        
        lblPropertiesTitle.font = ConstantFonts.TextFieldFont
        lblPropertiesTitle.textColor = AppColor.whiteColor
        lblPropertiesTitle.text = ConstantTexts.ExperLT
        lblPropertiesTitle.numberOfLines = 0
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleCenter = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyleCenter.lineSpacing = 8 // Whatever line spacing you want in points
        
        var myMutableString = NSMutableAttributedString()
        
        CustomMethods.shared.provideCornerRadiusTo(expertiseView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.RankLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 11.0), AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(08)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
        paragraphStyleCenter.alignment = .center
        
        rankLbl.attributedText = myMutableString
        
        
        
        
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.FavoriteLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 11.0), AppColor.textColor))
        
        
        lblFavMode.attributedText = myMutableString
        
        
        //TODO: Section 2
        
        lblGamesTitle.font = ConstantFonts.TextFieldFont
        lblGamesTitle.textColor = AppColor.whiteColor
        lblGamesTitle.text = ConstantTexts.GamesLT
        lblGamesTitle.numberOfLines = 0
        
        CustomMethods.shared.provideCornerRadiusTo(gamesView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        //TODO: Section 3
        
        lblPersonalInfo.font = ConstantFonts.TextFieldFont
        lblPersonalInfo.textColor = AppColor.whiteColor
        lblPersonalInfo.text = ConstantTexts.PersonalInfoLT
        lblPersonalInfo.numberOfLines = 0
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 8 // Whatever line spacing you want in points
        
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.FullNameLT)\n\(ConstantTexts.UserNameLT)\n\(ConstantTexts.GenderLT)\n\(ConstantTexts.DateOfBirthLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
        
        lblDetailsHeading.numberOfLines = 0
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        lblDetailsHeading.attributedText = myMutableString
        
        
        
        CustomMethods.shared.provideCornerRadiusTo(personalInformationView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        //TODO: Section 4
        
        lblAboutMeHeading.font = ConstantFonts.TextFieldFont
        lblAboutMeHeading.textColor = AppColor.whiteColor
        lblAboutMeHeading.text = ConstantTexts.aboutMeLT
        lblAboutMeHeading.numberOfLines = 0
        
        
        aboutMeDescLbl.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        aboutMeDescLbl.textColor = AppColor.textColor
        aboutMeDescLbl.numberOfLines = 0
        
        CustomMethods.shared.provideCornerRadiusTo(aboutMeView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        //TODO: Section 5
        
        languageTitleHeading.font = ConstantFonts.TextFieldFont
        languageTitleHeading.textColor = AppColor.whiteColor
        languageTitleHeading.text = ConstantTexts.LanguagesKnownLT
        languageTitleHeading.numberOfLines = 0
        
        CustomMethods.shared.provideCornerRadiusTo(languagesKnownView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        languageCV.register(nib: SelectLanguageCollectionViewCell.className)
        
        languageCV.delegate = self
        languageCV.dataSource = self
        
        
        
        //TODO: Section 6
        
        nationalityHeading.font = ConstantFonts.TextFieldFont
        nationalityHeading.textColor = AppColor.whiteColor
        nationalityHeading.text = ConstantTexts.NationalityLT
        nationalityHeading.numberOfLines = 0
        
        
        residencyHeading.font = ConstantFonts.TextFieldFont
        residencyHeading.textColor = AppColor.whiteColor
        residencyHeading.text = ConstantTexts.ResidenceLT
        residencyHeading.numberOfLines = 0
        
        InterestHeading.font = ConstantFonts.TextFieldFont
        InterestHeading.textColor = AppColor.whiteColor
        InterestHeading.text = ConstantTexts.InterestsLT
        InterestHeading.numberOfLines = 0
        
        
        
        lblCountry.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblCountry.textColor = AppColor.textColor
        lblCountry.numberOfLines = 0
        
        CustomMethods.shared.provideCornerRadiusTo(intrerestView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerRadiusTo(residenceView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerRadiusTo(nationalityView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        // MARK: - init and setup DYPieChartView
        pieChart.startAngle = -.pi / 2
        pieChart.clockwise = true
        pieChart.lineWidth = 5
        pieChart.backgroundColor = AppColor.whiteColor
        
        pieChart.sectorColors = [
            AppColor.themeColorDark,
            AppColor.placeholderColor
        ]
        
        // MARK: - animations
        //type 1: for duration
        
        //type 2: quickly
        
        lblProgPer.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblProgPer.textColor = AppColor.textColor
        
        
        getUserDetailOther(urlString:"\(SAuthApi.getOtherUserDetails)/\(id)")
        
        
    }
    
    
    
    internal func getUserDetailOther(urlString:String){
        
        
        let headers = ["Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        SAuthService().getTypeService(serviceName: urlString, header: headers).done { (response) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            if let dataDict = response.resultDict as? NSDictionary{
                
                // *** Create instance of `NSMutableParagraphStyle`
                let paragraphStyleCenter = NSMutableParagraphStyle()
                
                // *** set LineSpacing property in points ***
                paragraphStyleCenter.lineSpacing = 8 // Whatever line spacing you want in points
                var myMutableString = NSMutableAttributedString()
                var languageSletedArray = [String]()
                
                
                if let wordCountAlls = dataDict.value(forKey: "wordCountAlls") as? String{
                    
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.ActivityLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 11.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(wordCountAlls)  (\(ConstantTexts.WordsLT))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                    paragraphStyleCenter.alignment = .center
                    
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    
                    self.lblActivity.attributedText = myMutableString
                    
                }
                
                
                if let wordCountAlls = dataDict.value(forKey: "wordCountAlls") as? Int{
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.ActivityLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 11.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(wordCountAlls)  (\(ConstantTexts.WordsLT))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                    paragraphStyleCenter.alignment = .center
                    
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    
                    self.lblActivity.attributedText = myMutableString
                    
                }
                
                
                if let accuracy = dataDict.value(forKey: "accuracy") as? String{
                    
                    let accuracyDouble = Double(accuracy) ?? 0.0
                    
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.AccuracyLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 11.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(accuracyDouble == Double() ? "0" : "\(Int(round(accuracyDouble)))")\(ConstantTexts.PerLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                    
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    paragraphStyleCenter.alignment = .center
                    
                    self.lblAccuracy.attributedText = myMutableString
                }
                
                
                if let accuracy = dataDict.value(forKey: "accuracy") as? Int{
                    
                    let accuracyDouble = Double(accuracy)
                    
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.AccuracyLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 11.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(accuracyDouble == Double() ? "0" : "\(Int(round(accuracyDouble)))")\(ConstantTexts.PerLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                    
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    paragraphStyleCenter.alignment = .center
                    
                    self.lblAccuracy.attributedText = myMutableString
                }
                
                
                if let accuracy = dataDict.value(forKey: "accuracy") as? Double{
                    
                    let accuracyDouble = Double(accuracy)
                    
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.AccuracyLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 11.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(accuracyDouble == Double() ? "0" : "\(Int(round(accuracyDouble)))")\(ConstantTexts.PerLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                    
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    paragraphStyleCenter.alignment = .center
                    
                    self.lblAccuracy.attributedText = myMutableString
                }
                
                if let finalFavoriteModes = dataDict.value(forKey: "finalFavoriteModes") as? String{
                    
                    self.imgFav.image = (finalFavoriteModes == "1") ? #imageLiteral(resourceName: "time_un") :#imageLiteral(resourceName: "life_un")
                    
                }
                
                
                if let finalFavoriteModes = dataDict.value(forKey: "finalFavoriteModes") as? Int{
                    self.imgFav.image = (finalFavoriteModes == 1) ? #imageLiteral(resourceName: "time_un") :#imageLiteral(resourceName: "life_un")
                }
                
                if let totalMatchFind = dataDict.value(forKey: "totalMatchFind") as? String{
                    
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.PlayedLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(totalMatchFind)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 8.0), AppColor.textColor))
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    paragraphStyleCenter.alignment = .center
                    
                    self.lblPlayed.numberOfLines = 0
                    self.lblPlayed.attributedText = myMutableString
                    
                }
                
                
                if let totalMatchFind = dataDict.value(forKey: "totalMatchFind") as? Int{
                    
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.PlayedLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(totalMatchFind)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 8.0), AppColor.textColor))
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    paragraphStyleCenter.alignment = .center
                    
                    self.lblPlayed.numberOfLines = 0
                    self.lblPlayed.attributedText = myMutableString
                    
                }
                
                if let createMatchFind = dataDict.value(forKey: "createMatchFind") as? String{
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.CreatedLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(createMatchFind)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 8.0), AppColor.textColor))
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    paragraphStyleCenter.alignment = .center
                    
                    self.lblCreated.numberOfLines = 0
                    self.lblCreated.attributedText = myMutableString
                }
                
                
                if let createMatchFind = dataDict.value(forKey: "createMatchFind") as? Int{
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.CreatedLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(createMatchFind)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 8.0), AppColor.textColor))
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    paragraphStyleCenter.alignment = .center
                    
                    self.lblCreated.numberOfLines = 0
                    self.lblCreated.attributedText = myMutableString
                }
                
                
                if let commonMatchFind = dataDict.value(forKey: "commonMatchFind") as? String{
                    
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.InCommonLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(commonMatchFind)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 8.0), AppColor.textColor))
                    
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    paragraphStyleCenter.alignment = .center
                    
                    self.lblInCommon.numberOfLines = 0
                    self.lblInCommon.attributedText = myMutableString
                    
                }
                
                
                if let commonMatchFind = dataDict.value(forKey: "commonMatchFind") as? Int{
                    
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.InCommonLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(commonMatchFind)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 8.0), AppColor.textColor))
                    
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                    paragraphStyleCenter.alignment = .center
                    
                    self.lblInCommon.numberOfLines = 0
                    self.lblInCommon.attributedText = myMutableString
                    
                }
                
                
                
                if let receiver_details = dataDict.value(forKey: "receiver_details") as? NSDictionary{
                    if let name = receiver_details.value(forKey: "name") as? String{
                        self.lblName.text = name
                    }
                    
                    if let totalPoints = receiver_details.value(forKey: "totalPoints") as? String{
                        // *** Create instance of `NSMutableParagraphStyle`
                        let paragraphStyleCenter = NSMutableParagraphStyle()
                        
                        // *** set LineSpacing property in points ***
                        paragraphStyleCenter.lineSpacing = 2 // Whatever line spacing you want in points
                        
                        let myMutableString = NSMutableAttributedString()
                        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(totalPoints)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 14.0), AppColor.whiteColor))
                        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.PointsCLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.whiteColor))
                        
                        
                        // *** Apply attribute to string ***
                        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                        paragraphStyleCenter.alignment = .center
                        
                        self.lblPoints.numberOfLines = 0
                        self.lblPoints.attributedText = myMutableString
                    }
                    
                    if let totalPoints = receiver_details.value(forKey: "totalPoints") as? Int{
                        // *** Create instance of `NSMutableParagraphStyle`
                        let paragraphStyleCenter = NSMutableParagraphStyle()
                        
                        // *** set LineSpacing property in points ***
                        paragraphStyleCenter.lineSpacing = 2 // Whatever line spacing you want in points
                        
                        let myMutableString = NSMutableAttributedString()
                        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(totalPoints)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 14.0), AppColor.whiteColor))
                        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.PointsCLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.whiteColor))
                        
                        
                        // *** Apply attribute to string ***
                        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                        paragraphStyleCenter.alignment = .center
                        
                        self.lblPoints.numberOfLines = 0
                        self.lblPoints.attributedText = myMutableString
                    }
                    
                    if let coins = receiver_details.value(forKey: "coins") as? String{
                        CustomMethods.shared.setupLabel(self.lblCoin, AppColor.whiteColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 14.0), "\(coins)", AppColor.clearColor)
                    }
                    
                    if let coins = receiver_details.value(forKey: "coins") as? Int{
                        CustomMethods.shared.setupLabel(self.lblCoin, AppColor.whiteColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 14.0), "\(coins)", AppColor.clearColor)
                    }
                    
                    if let profilePic = receiver_details.value(forKey: "profilePic") as? String{
                        self.profileImg.sd_setImage(with: URL(string: profilePic), placeholderImage: UIImage(named: "profile_pic"))
                    }
                    
                    if let All_LikeWise_Persantege = receiver_details.value(forKey: "All_LikeWise_Persantege") as? Int{
                        self.lblProgPer.text = "\(All_LikeWise_Persantege)\(ConstantTexts.PerLT)"
                        
                        self.pieChart.animate(toScaleValues: [NSNumber(value: (Double(All_LikeWise_Persantege) )/100),NSNumber(value: (100 - (Double(All_LikeWise_Persantege)))/100)], duration: 2)
                    }
                    
                    
                    
                    guard let name = receiver_details.value(forKey: "name") as? String else{
                        print("No name")
                        return
                    }
                    
                    guard let username = receiver_details.value(forKey: "username") as? String else{
                        print("No username")
                        return
                    }
                    
                    guard let gender = receiver_details.value(forKey: "gender") as? String else{
                        print("No gender")
                        return
                    }
                    
                    guard let dob = receiver_details.value(forKey: "dob") as? String else{
                        print("No dob")
                        return
                    }
                    
                    let inputFormatter = DateFormatter()
                    inputFormatter.dateFormat = "dd-MM-yyyy"
                    var resultString = String()
                    if let showDate = inputFormatter.date(from: dob) as? Date{
                        inputFormatter.dateFormat = "dd MMM yyy"
                        resultString = inputFormatter.string(from: showDate)
                        print(resultString)
                    }
                    
                    
                    
                    
                    // *** Create instance of `NSMutableParagraphStyle`
                    let paragraphStyleNew = NSMutableParagraphStyle()
                    
                    // *** set LineSpacing property in points ***
                    paragraphStyleNew.lineSpacing = 8 // Whatever line spacing you want in points
                    
                    let myMutableStringNew = NSMutableAttributedString()
                    myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(name)\n\(username)\n\(gender)\n\(resultString)", font: AppFont.light.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
                    
                    self.lblDetailsValues.numberOfLines = 0
                    
                    // *** Apply attribute to string ***
                    myMutableStringNew.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleNew, range:NSMakeRange(0, myMutableStringNew.length))
                    
                    self.lblDetailsValues.textAlignment = .right
                    paragraphStyleNew.alignment = .right
                    self.lblDetailsValues.attributedText = myMutableStringNew
                    
                    
                    if let type = receiver_details.value(forKey: "type") as? Int{
                        self.imgFB.isHidden = (type == 1) ? false : true
                    }
                    
                    if let type = receiver_details.value(forKey: "type") as? String{
                        self.imgFB.isHidden = (type == "1") ? false : true
                    }
                    
                    
                    if let aboutus = receiver_details.value(forKey: "aboutus") as? String{
                        
                        if aboutus == String(){
                            self.aboutMeDescLbl.text = ConstantTexts.no_describeLT
                        }else{
                            self.aboutMeDescLbl.text = aboutus
                        }
                        
                    }
                    
                    if let nationalit = receiver_details.value(forKey: "nationalit") as? String{
                        
                        if nationalit == String(){
                            self.lblCountry.text = ConstantTexts.no_countryAddedLT
                        }else{
                            self.lblCountry.text = nationalit
                            
                        }
                        
                    }
                    
                    var countryString = ConstantTexts.no_countryAddedNewLT
                    var cityString = ConstantTexts.no_cityAddedNewLT
                    var stateString = ConstantTexts.no_stateAddedNewLT
                    
                    if let country = receiver_details.value(forKey: "country") as? String{
                        if country != String(){
                            countryString = country
                        }
                    }
                    
                    if let city = receiver_details.value(forKey: "city") as? String{
                        if city != String(){
                            cityString = city
                        }
                    }
                    
                    if let state = receiver_details.value(forKey: "state") as? String{
                        if state != String(){
                            stateString = state
                        }
                    }
                    
                    // *** Create instance of `NSMutableParagraphStyle`
                    let paragraphStyle = NSMutableParagraphStyle()
                    
                    // *** set LineSpacing property in points ***
                    paragraphStyle.lineSpacing = 8 // Whatever line spacing you want in points
                    
                    
                    myMutableString = NSMutableAttributedString()
                    myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(countryString)\n\(cityString)\n\(stateString)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
                    
                    self.LblResidency.numberOfLines = 0
                    
                    // *** Apply attribute to string ***
                    myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
                    
                    
                    self.LblResidency.attributedText = myMutableString
                    
                    
                    
                    
                    if let interest = receiver_details.value(forKey: "interest") as? String{
                        
                        if interest == String(){
                            myMutableString = NSMutableAttributedString()
                            myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.no_interestLT, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
                            
                            self.LblInterests.numberOfLines = 0
                            
                            // *** Apply attribute to string ***
                            myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
                            
                            
                            self.LblInterests.attributedText = myMutableString
                        }else{
                            
                            let interests = interest.components(separatedBy: ",")
                            
                            if interest.count > 0{
                                let joinedinterests = interests.joined(separator: "\n")
                                
                                
                                
                                myMutableString = NSMutableAttributedString()
                                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: joinedinterests, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
                                
                                self.LblInterests.numberOfLines = 0
                                
                                // *** Apply attribute to string ***
                                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
                                
                                
                                self.LblInterests.attributedText = myMutableString
                            }else{
                                myMutableString = NSMutableAttributedString()
                                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.no_interestLT, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
                                
                                self.LblInterests.numberOfLines = 0
                                
                                // *** Apply attribute to string ***
                                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
                                
                                
                                self.LblInterests.attributedText = myMutableString
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    if let languadeCode = receiver_details.value(forKey: "languageCode") as? String{
                        languageSletedArray = languadeCode.components(separatedBy: ",")
                    }
                    
                    if let languadeCode = receiver_details.value(forKey: "languageCode") as? NSArray
                    {
                        if languadeCode.count > 0{
                            if let lanString = languadeCode.object(at: 0) as? String{
                                languageSletedArray = lanString.components(separatedBy: ",")
                            }
                        }
                        
                    }
                    
                    
                    
                }
                
                
                
                var temp_countryList = [getUserDetail]()
                
                if let countryList = dataDict.value(forKey: "countryList") as? NSArray{
                    
                    for item in countryList{
                        if let countryDict = item as? NSDictionary{
                            let countryList = getUserDetail(_id: String(), code: String(), description: String(), language: String(), picture: String(), status: String(), isSelected: false)
                            
                            if let _id = countryDict.value(forKey: "_id") as? String{
                                countryList._id = _id
                            }
                            
                            if let code = countryDict.value(forKey: "code") as? String{
                                countryList.code = code
                                // self.getingLanguagesCode = code
                            }
                            
                            
                            
                            if let description = countryDict.value(forKey: "description") as? String{
                                
                                countryList.description = description
                            }
                            
                            if let language = countryDict.value(forKey: "language") as? String{
                                countryList.language = language
                            }
                            
                            if let picture = countryDict.value(forKey: "picture") as? String{
                                countryList.picture = picture
                            }
                            
                            if let status = countryDict.value(forKey: "status") as? String{
                                countryList.status = status
                            }
                            
                            temp_countryList.append(countryList)
                            
                        }
                    }
                    
                }
                
                
                for langCodeItem in languageSletedArray{
                    for countryItem in temp_countryList{
                        if langCodeItem == countryItem.code{
                            self.countryList.append(countryItem)
                        }
                    }
                }
                
                
                self.languageCV.reloadData()
                
                
                
                
            }
            
            
            
        }.catch { (error) in
            
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            let nsError = error as NSError
            HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
        }
    }
    
    
    
}



