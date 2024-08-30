//
//  ImagePickerExtensionMethod.swift
//  LikeWise
//
//  Created by Deepti Sharma on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit


extension ImagePickerViewController{
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    internal func initialSetUp(){
        
        lblHeadingRef.font = ConstantFonts.SubmitButtonFont
        lblHeadingRef.textColor = AppColor.textColor
        lblHeadingRef.text = ConstantTexts.SelectMaxImagesLT
        
        
        takePicLbl.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0)
        takePicLbl.textColor = AppColor.textColor
        takePicLbl.text = ConstantTexts.TakePicLT
        
        publicGAllLBl.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0)
        publicGAllLBl.textColor = AppColor.whiteColor
        publicGAllLBl.text = ConstantTexts.PublicGalaryLT
        
        phoneGllLbl.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0)
        phoneGllLbl.textColor = AppColor.textColor
        phoneGllLbl.text = ConstantTexts.PhoneGalaryLT
        
        searchTxt.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        searchTxt.textColor = AppColor.textColor
        searchTxt.placeholder = ConstantTexts.SearchFriendsLT
        
        
        
        takePicVieew.backgroundColor = AppColor.whiteColor
        photoGallView.backgroundColor = AppColor.themeColorDark
        phoneGallView.backgroundColor = AppColor.whiteColor
        
        
        takePicIV.image  = UIImage(named: "icam_un")
        photoGalIV.image  = UIImage(named: "publicgal_s")
        phoneGalIV.image  = UIImage(named: "gal_un")
        
        
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.phoneGallView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.photoGallView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.takePicVieew, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.searchView, 5.0, AppColor.searchColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideCornerRadiusTo(self.mainView, 20,[.layerMinXMinYCorner,.layerMaxXMinYCorner])
        
        
        phoneGallView.layer.borderWidth = 1.5
        phoneGallView.layer.borderColor = AppColor.textColor.cgColor
        phoneGallView.clipsToBounds = true
        
        photoGallView.layer.borderWidth = 1.5
        photoGallView.layer.borderColor = AppColor.textColor.cgColor
        photoGallView.clipsToBounds = true
        
        takePicVieew.layer.borderWidth = 1.5
        takePicVieew.layer.borderColor = AppColor.textColor.cgColor
        takePicVieew.clipsToBounds = true
        
        publicGalleryCV.register(nib: AddImageCollectionViewCell.className)
        
        publicGalleryCV.isHidden = false
        publicGalleryCV.delegate = self
        publicGalleryCV.dataSource = self
        
        getImages(urlString:SAuthApi.listImage)
        
    }
    
    
    
    internal func getImages(urlString:String){
        
        
        
       
        let headers = [
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        SAuthService().getTypeService(serviceName: urlString, header: headers).done { (response) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            
            if self.imagesArray.count > 0{
                self.imagesArray.removeAll()
            }
            
            if let images = response.resultArray as? NSArray{
                for item in images{
                    if let itemDict = item as? NSDictionary{
                        let selectedItem = selectImage(_id: String(), images: String(), themeName: String(), image: UIImage(), isSelected: Bool(), withName: "images", fileName:"images", mimeType: "image/png")
                        
                        if let _id = itemDict.value(forKey: "_id") as? String{
                            selectedItem._id = _id
                        }
                        
                        if let themeName = itemDict.value(forKey: "themeName") as? String{
                            selectedItem.themeName = themeName
                        }
                        
                        if let images = itemDict.value(forKey: "images") as? NSArray{
                            for imageUrl in images{
                                if let image = imageUrl as? String{
                                    selectedItem.images = image
                                }
                            }
                          
                        }
                         self.imagesArray.append(selectedItem)
                        
                    }
                }
                DispatchQueue.main.async {
                               self.publicGalleryCV.reloadData()
                           }
                
               
            }
            

            
          
        }.catch { (error) in
            
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            
            let nsError = error as NSError
            HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
        }
    }
    
}

