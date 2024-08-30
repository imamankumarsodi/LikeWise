//
//  MyProfile_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 28/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import Alamofire
import ADCountryPicker

//MARK: - Extension Custom methods
extension MyProfileVC{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    //TODO: Initial setup method
    internal func initialSetup(){
        
        
        
        CustomMethods.shared.setupButton(btnEditRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), ConstantTexts.editBT)
        
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
        
        
        
        lblDetailsHeading.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblDetailsHeading.textColor = AppColor.textColor
        lblDetailsHeading.text = ConstantTexts.FullNameLT
        lblDetailsHeading.numberOfLines = 0
        
        lblUserNameHeading.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblUserNameHeading.textColor = AppColor.textColor
        lblUserNameHeading.text = ConstantTexts.UserNameLT
        lblUserNameHeading.numberOfLines = 0
        
        
        lblEmailHeading.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblEmailHeading.textColor = AppColor.textColor
        lblEmailHeading.text = ConstantTexts.emailPH
        lblEmailHeading.numberOfLines = 0
        
        lblGenderHeading.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblGenderHeading.textColor = AppColor.textColor
        lblGenderHeading.text = ConstantTexts.GenderLT
        lblGenderHeading.numberOfLines = 0
        
        lblDOBHeading.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        lblDOBHeading.textColor = AppColor.textColor
        lblDOBHeading.text = ConstantTexts.DateOfBirthLT
        lblDOBHeading.numberOfLines = 0
        
        
        
        
        txtDetails.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtDetails.textColor = AppColor.textColor
        txtDetails.placeholder = ConstantTexts.FullNameLT
        txtDetails.keyboardType = .default
        
        txtUserName.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtUserName.textColor = AppColor.textColor
        txtUserName.placeholder = ConstantTexts.user_namePH
        txtUserName.keyboardType = .default
        
        txtEmail.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtEmail.textColor = AppColor.textColor
        txtEmail.placeholder = ConstantTexts.emailPH
        txtEmail.keyboardType = .emailAddress
        
        txtGender.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtGender.textColor = AppColor.textColor
        txtGender.placeholder = ConstantTexts.GenderLT
        txtGender.keyboardType = .default
        
        txtDOB.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtDOB.textColor = AppColor.textColor
        txtDOB.placeholder = ConstantTexts.DateOfBirthLT
        txtDOB.keyboardType = .default
        
        
        txtCountyr.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtCountyr.textColor = AppColor.textColor
        txtCountyr.placeholder = ConstantTexts.countryLT
        txtCountyr.keyboardType = .default
        
        
        txtState.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtState.textColor = AppColor.textColor
        txtState.placeholder = ConstantTexts.stateLT
        txtState.keyboardType = .default
        
        txtCity.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtCity.textColor = AppColor.textColor
        txtCity.placeholder = ConstantTexts.cityLT
        txtCity.keyboardType = .default
        
        
        txtInterest1.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtInterest1.textColor = AppColor.textColor
        txtInterest1.placeholder = ConstantTexts.addHereLT
        txtInterest1.keyboardType = .default
        
        
        txtInterest2.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtInterest2.textColor = AppColor.textColor
        txtInterest2.placeholder = ConstantTexts.addHereLT
        txtInterest1.keyboardType = .default
        
        txtInterest3.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        txtInterest3.textColor = AppColor.textColor
        txtInterest3.placeholder = ConstantTexts.addHereLT
        txtInterest3.keyboardType = .default
        
        CustomMethods.shared.provideCornerRadiusTo(personalInformationView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        //TODO: Section 4
        
        lblAboutMeHeading.font = ConstantFonts.TextFieldFont
        lblAboutMeHeading.textColor = AppColor.whiteColor
        lblAboutMeHeading.text = ConstantTexts.aboutMeLT
        lblAboutMeHeading.numberOfLines = 0
        
        
        aboutMeDescLbl.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        
        
        
        
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
        lblCountry.text = ConstantTexts.JapanNewBT
        lblCountry.numberOfLines = 0
        
        
      
        CustomMethods.shared.provideCornerRadiusTo(intrerestView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerRadiusTo(residenceView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerRadiusTo(nationalityView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        if isEditable == true{
            CustomMethods.shared.setupButton(btnEditRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), ConstantTexts.saveProfileBT)
            
            txtDetails.isUserInteractionEnabled = true
            txtUserName.isUserInteractionEnabled = true
            txtEmail.isUserInteractionEnabled = true
            txtGender.isUserInteractionEnabled = true
            txtDOB.isUserInteractionEnabled = true
            aboutMeDescLbl.isUserInteractionEnabled = true
            aboutMeDescLbl.isEditable = true
            Profile_image_btn.isUserInteractionEnabled = true
            nationalityBtn.isUserInteractionEnabled = true
            genderBtn.isUserInteractionEnabled = true
            dobBtn.isUserInteractionEnabled = true
           
            txtCountyr.isUserInteractionEnabled = true
            txtState.isUserInteractionEnabled = true
            txtCity.isUserInteractionEnabled = true
            
            
            
        }
        else{
            CustomMethods.shared.setupButton(btnEditRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), ConstantTexts.editBT)
            
            txtDetails.isUserInteractionEnabled = false
            txtUserName.isUserInteractionEnabled = false
            txtEmail.isUserInteractionEnabled = false
            txtGender.isUserInteractionEnabled = false
            txtDOB.isUserInteractionEnabled = false
            aboutMeDescLbl.isUserInteractionEnabled = true
            aboutMeDescLbl.isEditable = false
            Profile_image_btn.isUserInteractionEnabled = false
            nationalityBtn.isUserInteractionEnabled = false
            genderBtn.isUserInteractionEnabled = false
            dobBtn.isUserInteractionEnabled = false
            
            txtCountyr.isUserInteractionEnabled = false
            txtState.isUserInteractionEnabled = false
            txtCity.isUserInteractionEnabled = false
            
            txtInterest1.isUserInteractionEnabled = false
            txtInterest2.isUserInteractionEnabled = false
            txtInterest3.isUserInteractionEnabled = false
            btnSelectLanguageRef.isUserInteractionEnabled = false
        }
        
        
        do{
            if let user = realm.objects(UserDataModel.self).first{
                self.token = user.jwtToken
                self.lblName.text = user.name
                self.profileImg.sd_setImage(with: URL(string: user.profilePic), placeholderImage: UIImage(named: "profile_pic"))
                
                // *** Create instance of `NSMutableParagraphStyle`
                let paragraphStyleCenter = NSMutableParagraphStyle()
                
                // *** set LineSpacing property in points ***
                paragraphStyleCenter.lineSpacing = 2 // Whatever line spacing you want in points
                
                let myMutableString = NSMutableAttributedString()
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(Int(round(user.totalPoints)))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 14.0), AppColor.whiteColor))
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.PointsCLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.whiteColor))
                
                
                // *** Apply attribute to string ***
                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                paragraphStyleCenter.alignment = .center
                
                self.lblPoints.numberOfLines = 0
                self.lblPoints.attributedText = myMutableString
                
                CustomMethods.shared.setupLabel(lblCoin, AppColor.whiteColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 14.0), " \(Int(round(user.coins)))", AppColor.clearColor)
                
                
                self.userName = user.username
                
                txtDetails.text = user.name
                txtUserName.text = user.username
                txtEmail.text = user.email
                txtGender.text = user.gender
                txtDOB.text = user.dob
                
                UserSelectedlanguage = user.languageCode
                txtCountyr.text = user.country
                txtState.text = user.state
                txtCity.text = user.city
                
                if user.aboutus == String(){
                    aboutMeDescLbl.textColor = AppColor.placeholderColor
                    aboutMeDescLbl.text = ConstantTexts.pleaseTellusPH
                    aboutMeDescLbl.delegate = self
                }else{
                    aboutMeDescLbl.textColor = AppColor.textColor
                    aboutMeDescLbl.text = user.aboutus
                    aboutMeDescLbl.delegate = self
                }
                
                
                
                
            }
            
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        CustomMethods.shared.provideCornerRadiusTo(self.countryImg, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        
        profileApi()
        
        
    }
    
    internal func check_isEditable(){
        if isEditable == true{
            CustomMethods.shared.setupButton(btnEditRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), ConstantTexts.saveProfileBT)
            
            txtDetails.isUserInteractionEnabled = true
            txtUserName.isUserInteractionEnabled = true
            txtEmail.isUserInteractionEnabled = true
            txtGender.isUserInteractionEnabled = true
            txtDOB.isUserInteractionEnabled = true
            aboutMeDescLbl.isUserInteractionEnabled = true
            aboutMeDescLbl.isEditable = true
            Profile_image_btn.isUserInteractionEnabled = true
            nationalityBtn.isUserInteractionEnabled = true
            genderBtn.isUserInteractionEnabled = true
            dobBtn.isUserInteractionEnabled = true
            
            txtCountyr.isUserInteractionEnabled = true
            txtState.isUserInteractionEnabled = true
            txtCity.isUserInteractionEnabled = true
            
            txtInterest1.isUserInteractionEnabled = true
            txtInterest2.isUserInteractionEnabled = true
            txtInterest3.isUserInteractionEnabled = true
            btnSelectLanguageRef.isUserInteractionEnabled = true
            
        }
        else{
            CustomMethods.shared.setupButton(btnEditRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), ConstantTexts.editBT)
            
            txtDetails.isUserInteractionEnabled = false
            txtUserName.isUserInteractionEnabled = false
            txtEmail.isUserInteractionEnabled = false
            txtGender.isUserInteractionEnabled = false
            txtDOB.isUserInteractionEnabled = false
            aboutMeDescLbl.isUserInteractionEnabled = true
            aboutMeDescLbl.isEditable = false
            Profile_image_btn.isUserInteractionEnabled = false
            nationalityBtn.isUserInteractionEnabled = false
            genderBtn.isUserInteractionEnabled = false
            dobBtn.isUserInteractionEnabled = false
            
            txtCountyr.isUserInteractionEnabled = false
            txtState.isUserInteractionEnabled = false
            txtCity.isUserInteractionEnabled = false
            
            txtInterest1.isUserInteractionEnabled = false
            txtInterest2.isUserInteractionEnabled = false
            txtInterest3.isUserInteractionEnabled = false
            btnSelectLanguageRef.isUserInteractionEnabled = false
        }
    }
    
    func setValiadtion(){
        
        if txtDetails.text!.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.enterFullNameAlert)
            return
        }
        
        if txtUserName.text!.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.enterUserNameAlert)
            return
        }
        
        if txtEmail.text!.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.enterEmailAlert)
            return
        }
        
        if HHelper.isValidEmail(txtEmail.text!) == false {
            HHelper.showAlert(ConstantTexts.enterValidEmailAlert)
            return
        }
        
        if txtGender.text!.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.genderAlert)
            return
        }
        
        if txtDOB.text!.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.dobAlert)
            return
        }
        
        if aboutMeDescLbl.text!.trimmingCharacters(in: .whitespaces) == "" || aboutMeDescLbl.text!.trimmingCharacters(in: .whitespaces) == ConstantTexts.pleaseTellusPH {
            HHelper.showAlert(ConstantTexts.aboutAlert)
            return
        }
        
        
        if txtCountyr.text!.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.enterCountryAlert)
            return
        }
        
        if txtState.text!.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.enterStateAlert)
            return
        }
        
        
        if txtCity.text!.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.enterCityAlert)
            return
        }
        self.requestIntersts = (txtInterest1.text ?? String()) + "," + (txtInterest2.text ?? String()) + "," + (txtInterest3.text ?? String())
        userModel.name = txtDetails.text
        userModel.username = txtUserName.text
        userModel.gender = txtGender.text
        userModel.dob = txtDOB.text
        userModel.email = txtEmail.text
        userModel.country = txtCountyr.text
        userModel.state = txtState.text
        userModel.city = txtCity.text
        userModel.interest = requestIntersts
        userModel.aboutus = aboutMeDescLbl.text
        
        let string = lanCode.joined(separator: ",")
        userModel.languageCode = string
        
        EditProfileApi()
        
    }
}



//MARK:- retriving data from realm
extension MyProfileVC{
    func getUserData(){
        do{
            if let user = realm.objects(UserDataModel.self).first{
                
                self.token = user.jwtToken
                self.lblName.text = user.name
                
                self.profileImg.sd_setImage(with: URL(string: user.profilePic), placeholderImage: UIImage(named: "profile_pic"))
                
                
                
                
                
                // *** Create instance of `NSMutableParagraphStyle`
                let paragraphStyleCenter = NSMutableParagraphStyle()
                
                // *** set LineSpacing property in points ***
                paragraphStyleCenter.lineSpacing = 2 // Whatever line spacing you want in points
                
                let myMutableString = NSMutableAttributedString()
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(Int(round(user.totalPoints)))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 14.0), AppColor.whiteColor))
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.PointsCLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.whiteColor))
                
                
                // *** Apply attribute to string ***
                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                paragraphStyleCenter.alignment = .center
                
                self.lblPoints.numberOfLines = 0
                self.lblPoints.attributedText = myMutableString
                
                
                
                CustomMethods.shared.setupLabel(lblCoin, AppColor.whiteColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 14.0), " \(Int(round(user.coins)))", AppColor.clearColor)
                
                self.userName = user.username
                
                txtDetails.text = user.name
                txtUserName.text = user.username
                txtEmail.text = user.email
                // txtPassword.text = user.password
                txtGender.text = user.gender
                txtDOB.text = user.dob
                imgFB.isHidden = (user.type == "1") ? false : true
                
                if user.nationalit == String(){
                    self.lblCountry.text = ConstantTexts.no_countryAddedLT
                }else{
                    self.lblCountry.text = user.nationalit
                    
                }
                
                if user.aboutus == String(){
                    
                    aboutMeDescLbl.textColor = AppColor.placeholderColor
                    aboutMeDescLbl.text = ConstantTexts.pleaseTellusPH
                    aboutMeDescLbl.delegate = self
                    
                }else{
                    aboutMeDescLbl.textColor = AppColor.textColor
                    aboutMeDescLbl.text = user.aboutus
                    aboutMeDescLbl.delegate = self
                    
                }
                
                UserSelectedlanguage = user.languageCode
                txtCountyr.text = user.country
                txtState.text = user.state
                txtCity.text = user.city
                
                // txtInterest1.text = user.interest1
                
                requestIntersts = user.interest
                let intrestArray = user.interest.split(separator: ",")
                
                for index in 0..<intrestArray.count{
                    if index == 0{
                        self.txtInterest1.text = String(intrestArray[index])
                    }else if index == 2{
                        self.txtInterest2.text = String(intrestArray[index])
                    }else{
                        self.txtInterest3.text = String(intrestArray[index])
                    }
                }
                
               
                
            }
            
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }
    
    
    
}

//MARK: - profile info api
extension MyProfileVC{
    
    
    internal func profileApi(){
        
        
        let headers:HTTPHeaders = ["Content-Type":"application/json","authorization":token]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        SAuthService().getTypeService(serviceName: SAuthApi.getUserDetails, header: headers).done { (response) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            var languageSletedArray = [String]()
            
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyleCenter = NSMutableParagraphStyle()
            
            // *** set LineSpacing property in points ***
            paragraphStyleCenter.lineSpacing = 8 // Whatever line spacing you want in points
            
            var myMutableString = NSMutableAttributedString()
            
            if let rank = response.rank as? Int{
                myMutableString = NSMutableAttributedString()
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.RankLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(rank)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                
                
                // *** Apply attribute to string ***
                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                paragraphStyleCenter.alignment = .center
                
                self.rankLbl.attributedText = myMutableString
            }
            
            
            if let wordCount = response.wordCount as? Int {
                
                myMutableString = NSMutableAttributedString()
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.ActivityLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 11.0), AppColor.textColor))
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(wordCount)  (\(ConstantTexts.WordsLT))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                paragraphStyleCenter.alignment = .center
                
                
                // *** Apply attribute to string ***
                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                
                self.lblActivity.attributedText = myMutableString
                
            }
            
            if let accuracy = response.accuracy as? Int{
                
                myMutableString = NSMutableAttributedString()
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.AccuracyLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(accuracy)\(ConstantTexts.PerLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                
                // *** Apply attribute to string ***
                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                
                
                self.lblAccuracy.attributedText = myMutableString
                
            }
            
            
            
            if let mode = response.mode as? Int{
                self.imgFav.image = (mode == 1 || mode == 0 ) ? #imageLiteral(resourceName: "time_un") :#imageLiteral(resourceName: "life_un")
            }
            
            if let played = response.played as? Int{
                myMutableString = NSMutableAttributedString()
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.PlayedLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(played)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                
                // *** Apply attribute to string ***
                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                paragraphStyleCenter.alignment = .center
                
                self.lblPlayed.numberOfLines = 0
                self.lblPlayed.attributedText = myMutableString
            }
            
            if let created = response.created as? Int{
                myMutableString = NSMutableAttributedString()
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.CreatedLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(created)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                
                // *** Apply attribute to string ***
                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                paragraphStyleCenter.alignment = .center
                
                self.lblCreated.numberOfLines = 0
                self.lblCreated.attributedText = myMutableString
                
            }
            
            if let patners = response.patners as? Int{
                
                
                
                myMutableString = NSMutableAttributedString()
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.PartnersLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(patners)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
                
                
                // *** Apply attribute to string ***
                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                paragraphStyleCenter.alignment = .center
                
                self.lblInCommon.numberOfLines = 0
                self.lblInCommon.attributedText = myMutableString
            }
            
            
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
                    if self.lanCode.count > 0{
                        self.lanCode.removeAll()
                    }
                    let string = languageCode.componentsJoined(by: ",")
                    userData.languageCode = string
                    
                    for item in languageCode{
                        if let itemString = item as? String{
                            self.lanCode.append(itemString)
                        }
                    }
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
                    
                    self.getUserData()
                    
                    if let data = response.resultDict as? NSDictionary{
                        if let languadeCode = data.value(forKey: "languageCode") as? NSArray{
                            languageSletedArray = languadeCode as? [String] ?? []
                        }
                    }
                    
                })
            }
            
            
            var temp_countryList = [getUserDetail]()
            
            if self.knownLang.count > 0 {
                self.knownLang.removeAll()
            }
            
            if let countryList = response.countryList as? NSArray{
                
                for item in countryList{
                    if let countryDict = item as? NSDictionary{
                        let countryList = getUserDetail(_id: String(), code: String(), description: String(), language: String(), picture: String(), status: String(), isSelected: false)
                        
                        //if let user = realm.objects(user)
                        
                        if let _id = countryDict.value(forKey: "_id") as? String{
                            countryList._id = _id
                        }
                        
                        if let code = countryDict.value(forKey: "code") as? String{
                            countryList.code = code
                            
                            if let user = self.realm.objects(UserDataModel.self).first{
                                
                                if code == user.defaultLangCode {
                                    countryList.isSelected = true
                                }else{
                                    countryList.isSelected = false
                                }
                                
                            }
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
                        self.knownLang.append(countryList)
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
    
    internal func EditProfileApi(){
        
        let header = ["authorization":token,
                      "Content-Type": "application/json",
                      "accept": "application/json"]
        
        print("Param",userModel.toJSON())
        
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        SAuthService().formDataService(profileImage, withName: withName, fileName: fileName, mimeType: mimeType, parameters: userModel.toJSON(), serviceName: SAuthApi.updateUserProfile, header: header).done{(response) -> Void  in
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
                    
                    CustomMethods.shared.setupButton(self.btnEditRef, AppColor.whiteColor,AppColor.clearColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), ConstantTexts.editBT)
                    self.isEditable = false
                    self.txtDetails.isUserInteractionEnabled = false
                    self.txtUserName.isUserInteractionEnabled = false
                    self.txtEmail.isUserInteractionEnabled = false
                    self.txtGender.isUserInteractionEnabled = false
                    self.txtDOB.isUserInteractionEnabled = false
                    self.aboutMeDescLbl.isUserInteractionEnabled = true
                    self.aboutMeDescLbl.isEditable = false
                    self.Profile_image_btn.isUserInteractionEnabled = false
                    self.nationalityBtn.isUserInteractionEnabled = false
                    self.genderBtn.isUserInteractionEnabled = false
                    self.dobBtn.isUserInteractionEnabled = false
                    
                    self.txtCountyr.isUserInteractionEnabled = false
                    self.txtState.isUserInteractionEnabled = false
                    self.txtCity.isUserInteractionEnabled = false
                })
            }
            
            if let message = response.message{
                _ = SweetAlert().showAlert(APP_NAME, subTitle: message, style: AlertStyle.success)
            }
            
            self.navigationController?.popViewController(animated: true)
            
            
            
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
}

//MARK: - Textview delegates
extension MyProfileVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        let sizeToFitIn = CGSize(width: self.aboutMeDescLbl.bounds.size.width, height: CGFloat(MAXFLOAT))
        let newSize = self.aboutMeDescLbl.sizeThatFits(sizeToFitIn)
        self.textViewHeight.constant = newSize.height
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == AppColor.placeholderColor {
            textView.text = nil
            textView.textColor = AppColor.textColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ConstantTexts.pleaseTellusPH
            textView.textColor = AppColor.placeholderColor
        }
    }
    
}


//MARK: - Open camera extension
extension MyProfileVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    
    func openActionSheet() {
        
        let alert = UIAlertController(title: APP_NAME, message: ConstantTexts.SelectYourOptionLT, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: ConstantTexts.CameraLT, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: ConstantTexts.GalleryLT, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: ConstantTexts.CancelBT, style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        myPickerController.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            myPickerController.sourceType = UIImagePickerController.SourceType.camera
            self .present(myPickerController, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: APP_NAME, message:ConstantTexts.cameraAlert, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: ConstantTexts.okBT, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerController.delegate = self
        myPickerController.mediaTypes = ["public.image"]
        self.present(myPickerController, animated: true, completion: nil)
        
        
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let choosen_image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImg.image = choosen_image
            let data = choosen_image.jpegData(compressionQuality:0.5) as NSData!
            profileImage.append(choosen_image.jpegData(compressionQuality: 0.2)!)
            self.withName.append("profilePic")
            self.fileName.append("profilePic")
            self.mimeType.append( "image/png")
            
        }else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    
}
