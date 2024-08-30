//
//  MyProfileVC.swift
//  LikeWise
//
//  Created by Aman Kumar on 28/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import ADCountryPicker
import DatePickerDialog
import DropDown

class MyProfileVC: BaseViewController,ADCountryPickerDelegate{
    
    //MARK: - IBOutlets
    @IBOutlet weak var imgFB: UIImageView!
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var btnEditRef: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPropertiesTitle: UILabel!
    @IBOutlet weak var expertiseView: UIView!
    @IBOutlet weak var lblActivity: UILabel!
    @IBOutlet weak var lblAccuracy: UILabel!
    @IBOutlet weak var lblFavMode: UILabel!
    @IBOutlet weak var lblGamesTitle: UILabel!
    @IBOutlet weak var gamesView: UIView!
    @IBOutlet weak var lblPlayed: UILabel!
    @IBOutlet weak var lblCreated: UILabel!
    @IBOutlet weak var lblInCommon: UILabel!
    @IBOutlet weak var lblPersonalInfo: UILabel!
    @IBOutlet weak var personalInformationView: UIView!
    @IBOutlet weak var lblAboutMeHeading: UILabel!
    @IBOutlet weak var aboutMeDescLbl: UITextView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var aboutMeView: UIView!
    @IBOutlet weak var Profile_image_btn: UIButton!
    @IBOutlet weak var languageTitleHeading: UILabel!
    @IBOutlet weak var languageCV: UICollectionView!
    @IBOutlet weak var languagesKnownView: UIView!
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var nationalityHeading: UILabel!
    @IBOutlet weak var residencyHeading: UILabel!
    @IBOutlet weak var InterestHeading: UILabel!
    @IBOutlet weak var intrerestView: UIView!
    @IBOutlet weak var residenceView: UIView!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblDetailsHeading: UILabel!
    @IBOutlet weak var lblUserNameHeading: UILabel!
    @IBOutlet weak var lblEmailHeading: UILabel!
    @IBOutlet weak var lblGenderHeading: UILabel!
    @IBOutlet weak var lblDOBHeading: UILabel!
    @IBOutlet weak var txtDetails: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var dobBtn: UIButton!
    @IBOutlet weak var txtCountyr: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtInterest1: UITextField!
    @IBOutlet weak var txtInterest2: UITextField!
    @IBOutlet weak var txtInterest3: UITextField!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblCoin: UILabel!
    @IBOutlet weak var btnSelectLanguageRef: UIButton!
    
    
    
    internal var userModel = UserModel()
    var countryList = [getUserDetail]()
    var getingLanguagesCode = String()
    
    
    internal let realm = try! Realm()
    internal var token = String()
    internal var userName = String()
    internal var isEditable = Bool()
    
    //MARK: - Variables for hit web services
    internal var withName = [String]()
    internal var fileName = [String]()
    internal var mimeType = [String]()
    internal var profileImage = [Any]()
    
    internal var CountryDataModelCollecArr = [CountryDataModelCollec]()
    internal let myPickerController = UIImagePickerController()
    
    let dropDown = DropDown()
    var datePicker = DatePickerDialog()
    var UserSelectedlanguage = String()
    
    internal var shownIntersts = String()
    internal var requestIntersts = String()
    
    internal var selectLang = Bool()
    internal var knownLang = [getUserDetail]()
    internal var lanCode = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutMeDescLbl.isScrollEnabled = false
        self.dismiss(animated: true, completion: nil)
        initialSetup()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func genderBtnAction(_ sender: UIButton) {
        
        CustomMethods.openDownOnFooter(dropDown: dropDown, array: [ConstantTexts.selectGenderLT,ConstantTexts.MaleLT,ConstantTexts.FemaleLT], anchor: self.txtGender) { (dropDown) in
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                
                if item == ConstantTexts.selectGenderLT{
                    self.txtGender.text = String()
                }else{
                    self.txtGender.text = item
                }
            }
        }
    }
    
    @IBAction func dobAction(_ sender: Any) {
        
        CustomMethods.datePickerTapped(datePicker: datePicker) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                self.txtDOB.text = formatter.string(from: dt).uppercased()
            }
        }
        
    }
    
    @IBAction func editBtnAction(_ sender: Any) {
        
        if isEditable == false{
            isEditable = true
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
            
        }else{
            setValiadtion()
        }
        
        
        
        
    }
    
    @IBAction func addProfileImgAction(_ sender: Any) {
        openActionSheet()
    }
    
    
    
    
    @IBAction func btnAddInterest(_ sender: UIButton) {
        
        var textFeild = UITextField()
        
        let alert = UIAlertController(title: APP_NAME, message: ConstantTexts.AddInterestLT, preferredStyle: .alert)
        let action = UIAlertAction(title: ConstantTexts.DoneBT, style: .default) { (action) in
            
            if textFeild.text != ""{
                
                
                if self.shownIntersts == String(){
                    self.shownIntersts.append(textFeild.text!)
                }else{
                    self.shownIntersts.append("\n\(textFeild.text!)")
                }
                
                if self.requestIntersts == String(){
                    self.requestIntersts.append(textFeild.text!)
                }else{
                    self.requestIntersts.append(",\(textFeild.text!)")
                }
                
                
                
             
                
            }else{
                _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.AddInterestLT, style: .error)
            }
            
        }
        
        let cancelAction = UIAlertAction(title: ConstantTexts.cancelBT, style: .cancel,handler: nil)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = ConstantTexts.InterestsLT
            
            textFeild = alertTextFeild
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func nationalityBtn(_ sender: Any) {
        
        let picker = ADCountryPicker()
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
        
        picker.delegate = self
        selectLang = false
    }
    
    @IBAction func tapAddLanguage(_ sender: Any) {
        
        let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: SelectLanguagesVC.className) as! SelectLanguagesVC
        vc.delegateLang = self
        vc.oldLang = lanCode
        vc.isComingEditProfile = true
        self.navigationController?.pushViewController(vc, animated: false)
        
        
    }
    
    func countryPicker(picker: ADCountryPicker, didSelectCountryWithName name: String, code: String) {
        
        let flagImage =  picker.getFlag(countryCode: code)
        self.countryImg.image = flagImage
        
        let countryName =  picker.getCountryName(countryCode: code)
        self.lblCountry.text = countryName
    }
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        
        
        
        _ = picker.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
        if selectLang {
            
            
            
            
        }else{
            
            let flagImage =  picker.getFlag(countryCode: code)
            self.countryImg.isHidden = false
            self.countryImg.image = flagImage
            
            let countryName =  picker.getCountryName(countryCode: code)
            self.lblCountry.text = countryName
            
        }
        
        
        
    }
}



extension MyProfileVC : getLanguageProtocol{
    
    func getLang(languArr: [getUserDetail]) {
        
        var d_Code = String()
        
        if let user = self.realm.objects(UserDataModel.self).first{
            d_Code = user.defaultLangCode
        }
        
        
        
        
        if self.lanCode.count > 0{
            self.lanCode.removeAll()
        }
        
        if self.countryList.count > 0{
            self.countryList.removeAll()
        }
        
        
        for item in languArr{
            
            
            if d_Code == item.code{
                item.isSelected = true
            }else{
                item.isSelected = false
            }
            
            self.lanCode.append(item.code)
            self.countryList.append(item)
        }
        
        
        self.languageCV.reloadData()
        
    }
    
    
    
    
}

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}
