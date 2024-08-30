//
//  ImagePickerViewController.swift
//  LikeWise
//
//  Created by Deepti Sharma on 29/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class ImagePickerViewController: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblHeadingRef: UILabel!

    @IBOutlet weak var searchTxt: UITextField!
    
    @IBOutlet weak var phoneGalIV: UIImageView!
    @IBOutlet weak var photoGalIV: UIImageView!
    @IBOutlet weak var takePicIV: UIImageView!
    
    @IBOutlet weak var phoneGllLbl: UILabel!
    @IBOutlet weak var publicGAllLBl: UILabel!
    @IBOutlet weak var takePicLbl: UILabel!
    
    @IBOutlet weak var phoneGallView: UIView!
    @IBOutlet weak var photoGallView: UIView!
    @IBOutlet weak var takePicVieew: UIView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var publicGalleryCV: UICollectionView!
    
    internal var imagesArray = [selectImage]()
    internal var filterArray = [selectImage]()
    
    //MARK: - Variables
    
    
    internal var imagePicker = UIImagePickerController()
    var callBackImages:((_ array:[selectImage])->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // setupNavigation()
    }
    
    @IBAction func takePhotoAction(_ sender: Any) {
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Button capture")
            takePicVieew.backgroundColor = AppColor.themeColorDark
            photoGallView.backgroundColor = AppColor.whiteColor
            phoneGallView.backgroundColor = AppColor.whiteColor
            
            takePicIV.image  = UIImage(named: "icam_s")
            photoGalIV.image  = UIImage(named: "publicgal_un")
            phoneGalIV.image  = UIImage(named: "gal_un")
            
            takePicLbl.textColor = AppColor.themeColorDark
            publicGAllLBl.textColor = AppColor.whiteColor
            phoneGllLbl.textColor = AppColor.whiteColor
            
            
            phoneGallView.layer.borderWidth = 1.5
            phoneGallView.layer.borderColor = UIColor.black.cgColor
            phoneGallView.clipsToBounds = true
            
            photoGallView.layer.borderWidth = 1.5
            photoGallView.layer.borderColor = UIColor.black.cgColor
            photoGallView.clipsToBounds = true
            publicGalleryCV.isHidden = true
            
            
            
            
            CustomMethods.shared.provideShadowAndCornerRadius(self.takePicVieew, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
            
            
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }else{
            HHelper.showAlert(ConstantTexts.dontHaveCamAT)
        }
    }
    
    
    @IBAction func photoGallAction(_ sender: Any) {
        takePicVieew.backgroundColor = AppColor.whiteColor
        photoGallView.backgroundColor = AppColor.themeColorDark
        phoneGallView.backgroundColor = AppColor.whiteColor
        
        takePicIV.image  = UIImage(named: "icam_un")
        photoGalIV.image  = UIImage(named: "publicgal_s")
        phoneGalIV.image  = UIImage(named: "gal_un")
        
        takePicLbl.textColor = AppColor.textColor
        publicGAllLBl.textColor = AppColor.whiteColor
        phoneGllLbl.textColor = AppColor.textColor
        
        phoneGallView.layer.borderWidth = 1.5
        phoneGallView.layer.borderColor = AppColor.textColor.cgColor
        phoneGallView.clipsToBounds = true
        
        takePicVieew.layer.borderWidth = 1.5
        takePicVieew.layer.borderColor = AppColor.textColor.cgColor
        takePicVieew.clipsToBounds = true
        
        
        publicGalleryCV.isHidden = false
        publicGalleryCV.delegate = self
        publicGalleryCV.dataSource = self
        
    }
    
    
    @IBAction func phoneGAllAction(_ sender: Any) {
        takePicVieew.backgroundColor = AppColor.whiteColor
        photoGallView.backgroundColor = AppColor.whiteColor
        phoneGallView.backgroundColor = AppColor.themeColorDark
        
        takePicIV.image  = UIImage(named: "icam_un")
        photoGalIV.image  = UIImage(named: "publicgal_un")
        phoneGalIV.image  = UIImage(named: "gal_s")
        
        takePicLbl.textColor = AppColor.textColor
        publicGAllLBl.textColor = AppColor.textColor
        phoneGllLbl.textColor = AppColor.whiteColor
        
        photoGallView.layer.borderWidth = 1.5
        photoGallView.layer.borderColor = AppColor.textColor.cgColor
        photoGallView.clipsToBounds = true
        
        takePicVieew.layer.borderWidth = 1.5
        takePicVieew.layer.borderColor = AppColor.textColor.cgColor
        takePicVieew.clipsToBounds = true
        
        publicGalleryCV.isHidden = true
        
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func saveBtnACtion(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func closeBtnACtion(_ sender: Any) {
        callBackImages!(filterArray)
        self.dismiss(animated: true, completion: nil)
    }
    
}
