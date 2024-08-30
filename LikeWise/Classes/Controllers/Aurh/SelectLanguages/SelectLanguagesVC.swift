//
//  SelectLanguagesVC.swift
//  LikeWise
//
//  Created by Deepti Sharma on 20/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import RealmSwift

protocol getLanguageProtocol {
    
    
    func getLang(languArr : [getUserDetail])
    
}

class SelectLanguagesVC: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgBackgroud: UIImageView!
    @IBOutlet weak var tblLanguage: UITableView!
    @IBOutlet weak var btnSaveRef: UIButton!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    
    //MARK: - Variable
    internal var countryDataModelArray = [CountryDataModelMain]()
    internal var isComing = String()
    internal var withName = [String]()
    internal var fileName = [String]()
    internal var mimeType = [String]()
    internal var profileImageArr = [Any]()
    
   
    internal var choosingLangugae  = [String]()
    var delegateLang : getLanguageProtocol?
    var userModel = UserModel()
    var navObj = UIViewController()
    
    var oldLang = [String]()
    var isComingEditProfile = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(isComing)
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblHeight.constant = tblLanguage.contentSize.height
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tblHeight.constant = tblLanguage.contentSize.height
    }
    
    override func viewDidLayoutSubviews() {
        tblHeight.constant = tblLanguage.contentSize.height
    }
    
    
    func removeDuplicates(array: [String]) -> [String] {
          var encountered = Set<String>()
          var result: [String] = []
          for value in array {
              if encountered.contains(value) {
                  // Do not add a duplicate element.
              }
              else {
                  // Add value to the set.
                  encountered.insert(value)
                  // ... Append the value.
                  result.append(value)
              }
          }
          return result
      }
    
    @IBAction func okBtnACtion(_ sender: Any) {
        if self.isComingEditProfile == true {
            
            var collArray = [getUserDetail]()
            
           for i in 0..<countryDataModelArray.count{
                
                for j in 0..<countryDataModelArray[i].array.count{
                    
                    if countryDataModelArray[i].array[j].isSelected{
                        let item = getUserDetail(_id: countryDataModelArray[i].array[j]._id, code: countryDataModelArray[i].array[j].code, description: countryDataModelArray[i].array[j].description, language: countryDataModelArray[i].array[j].language, picture: countryDataModelArray[i].array[j].picture, status: countryDataModelArray[i].array[j].code, isSelected:Bool())
                        collArray.append(item)
                    }
                }
            }
            
            
            if collArray.count == 0{
                HHelper.showAlert(ConstantTexts.LanguageSelectionAtLeastAlrert)
                return
            }else{
                delegateLang?.getLang(languArr: collArray)
                print("I'm at select language on user Profile!!!")
                self.navigationController?.popViewController(animated: true)
            }
           
            
            
            
        }else{
            
            
            for i in 0..<countryDataModelArray.count{
                
                for j in 0..<countryDataModelArray[i].array.count{
                    
                    if countryDataModelArray[i].array[j].isSelected{
                        choosingLangugae.append(countryDataModelArray[i].array[j].code)
                    }
                }
            }
            
            
            if choosingLangugae.count == 0{
                HHelper.showAlert(ConstantTexts.LanguageSelectionAtLeastAlrert)
                return
            }
                
            else{
                
                if isComing == "GUEST"{
                    // hit guest login api here....
                    UserDefaults.standard.set(true, forKey: "IS_GUEST")
                    userModel.languageAny = choosingLangugae
                    userModel.type = "3"
                    hitGuestLoginApi()
                } else if isComing == "SOCIAL"{
                    UserDefaults.standard.set(false, forKey: "IS_GUEST")
                    userModel.languageAny = choosingLangugae
                    userModel.type = "1"
                    hitSocialLoginApi()
                }else{
                    // hit sign up api here....
                    UserDefaults.standard.set(false, forKey: "IS_GUEST")
                    userModel.languageAny = choosingLangugae
                    userModel.type = "2"
                    hitSignUpApi()
                }
            }
            
            
            
        }

        
        
      /*  if selectLang == true {

            
        }else{
            

           
            print(choosingLangugae)
            
        } */
        
        
        
        
    }
}
