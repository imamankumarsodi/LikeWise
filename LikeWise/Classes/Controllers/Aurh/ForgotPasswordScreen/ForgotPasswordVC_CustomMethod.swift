//
//  ForgotPasswordVC_CustomMethod.swift
//  LikeWise
//
//  Created by Aman Kumar on 16/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//MARK: - Extension Custom methods
extension ForgetPasswordVC{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        
    }
    
    
    //TODO: Initial setup method
    internal func initialSetup(){
        
       let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.ForgetPasswordLT, font:  ConstantFonts.TitleForgotFont, AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\n\(ConstantTexts.ForgetPasswordDescriptionLT)", font: ConstantFonts.TitleNewFont, AppColor.textColor))
        
        lblHeading.numberOfLines = 0
        lblHeading.attributedText = myMutableString
        
       
        CustomMethods.shared.provideCornerRadiusTo(viewContent, 20, [.layerMinXMinYCorner,.layerMaxXMinYCorner])
        
        CustomMethods.shared.provideShadowAndCornerRadius(viewMail, viewMail.frame.size.height/2, AppColor.clearColor, 0, 0, 0, 10, 1, AppColor.placeholderColor)
        txtMail.font = ConstantFonts.TitleNewFont
        txtMail.textColor = AppColor.textColor
        txtMail.placeholder = ConstantTexts.emailPH
        txtMail.keyboardType = .emailAddress
        txtMail.delegate = self
        
        CustomMethods.shared.setupButton(btnLoginNewRef, AppColor.whiteColor,AppColor.themeColorDark,ConstantFonts.TextFieldFont, ConstantTexts.submitBT)
        
        CustomMethods.shared.provideCornerRadiusTo(btnLoginNewRef, btnLoginNewRef.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    
    internal func setupVAlidations(){
        
        
        if txtMail.text!.trimmingCharacters(in: .whitespaces) == "" {
            HHelper.showAlert(ConstantTexts.enterEmailAlert)
            return
        }
        
        if HHelper.isValidEmail(txtMail.text!) == false {
            HHelper.showAlert(ConstantTexts.enterValidEmailAlert)
            return
        }
        
      
        
        //MARK :- hitting checking email and user name api
        userModel.email = txtMail.text!
       
       forgotPasswordApi()
        
    }
    
    
    
    func forgotPasswordApi(){
        
        let headers:HTTPHeaders = [
            "Content-Type":"application/json",
            "accept": "application/json"]
        
        print(headers)
        CustomMethods.shared.showLoaderPresent(view: self.view)
        
        SAuthService().postService(parameters: userModel.toJSON(), serviceName: SAuthApi.forgetpassword, header: headers).done{(response) -> Void  in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            if let message = response.message as? String{
                
                _ = SweetAlert().showAlert(APP_NAME, subTitle: message, style: AlertStyle.success, buttonTitle: ConstantTexts.okBT, action: { (okButton) in
                    self.dismiss(animated: true, completion: nil)
                })
               
            }
            
            
        }.catch { (error) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            let nsError = error as NSError
            if let error = nsError.userInfo["errorMessage"] as? String{
                HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
            }
        }
        
    }
    
}


//MARK: - Extension Custom methods
extension ForgetPasswordVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
            CustomMethods.shared.showSelectUnselectTextFields(true, [viewMail])
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        CustomMethods.shared.showSelectUnselectTextFields(false, [viewMail])
    }
    
   
    
    
}


