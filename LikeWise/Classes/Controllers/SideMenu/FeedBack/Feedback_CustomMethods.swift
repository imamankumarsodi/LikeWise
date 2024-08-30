//
//  Feedback_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 02/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import Photos
import RealmSwift

//MARK:- Custom Methods
extension FedbackViewController {
    internal func initiallizers() {
        lblTitle.attributedText = CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.FeedBAckLT, font: ConstantFonts.HeaderFont, AppColor.whiteColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.fedbackTextView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.feedbcakBtn, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.VisitusLT, font:  ConstantFonts.TextFieldFont, UIColor.white))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.LikewiseChatUrlLT, font:  ConstantFonts.TextFieldFont, AppColor.themeColorLight))
        
        visitLbl.attributedText = myMutableString
        
        
        lblPleaseTell.attributedText = CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.PleaseTellusLT, font: ConstantFonts.TextFieldFont, AppColor.whiteColor)
        
        
        fedbackTextView.font = ConstantFonts.TextFieldFont
        fedbackTextView.keyboardType = .default
        fedbackTextView.textColor = AppColor.placeholderColor
        fedbackTextView.text = ConstantTexts.feedBackPH
        fedbackTextView.delegate = self
        
        lblUploadShot.font = ConstantFonts.HeaderFont
        lblUploadShot.textColor =  AppColor.whiteColor
        lblUploadShot.text = ConstantTexts.uploadScreenShotLT
        
        
        
        
         CustomMethods.shared.setupButton(feedbcakBtn, AppColor.themeColorDark, AppColor.whiteColor, ConstantFonts.TextFieldFont, ConstantTexts.sendFeedbackBT)
        
    }
    
    
    
    internal func validation(){
        if fedbackTextView.text!.trimmingCharacters(in: .whitespaces) == "" || fedbackTextView.text!.trimmingCharacters(in: .whitespaces) == ConstantTexts.feedBackPH {
            HHelper.showAlert(ConstantTexts.feedbackAlert)
            return
        }
        userModel.message = fedbackTextView.text!
        sendFeedbackApi()
    }
    
    internal func sendFeedbackApi(){
        var token = String()
         let realm = try! Realm()

        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
            }
            
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        let header = ["authorization":token,
                      "Content-Type": "application/json",
                      "accept": "application/json"]
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        
        SAuthService().formDataService(profileImage, withName: withName, fileName: fileName, mimeType: mimeType, parameters: userModel.toJSON(), serviceName: SAuthApi.addFeedback, header: header).done{(response) -> Void  in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            
            if let message = response.message{
                _ = SweetAlert().showAlert(APP_NAME, subTitle: message, style: AlertStyle.success, buttonTitle: ConstantTexts.okBT, action: { (okButton) in
                    self.navigationController?.popViewController(animated: true)
                })
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
    
    
}

//MARK: - Textview delegates
extension FedbackViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == AppColor.placeholderColor {
            textView.text = nil
            textView.textColor = AppColor.textColor
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = ConstantTexts.DescriptionPH
            textView.textColor = AppColor.placeholderColor
        }
    }
    
}


//MARK: - Open camera extension
extension FedbackViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
 
    
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
            
            let data = choosen_image.jpegData(compressionQuality:0.5) as NSData!
            profileImage.append(choosen_image.jpegData(compressionQuality: 0.2)!)
            self.withName.append("image")
            self.fileName.append("image")
            self.mimeType.append( "image/png")
            
            if let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
                let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
                let asset = result.firstObject
                if let name = asset?.value(forKey: "filename") as? String{
                    lblUploadShot.text = name
                }
                
                print(asset?.value(forKey: "filename"))

            }
            
            
        }else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: false, completion: nil)
        
    }
    


}
