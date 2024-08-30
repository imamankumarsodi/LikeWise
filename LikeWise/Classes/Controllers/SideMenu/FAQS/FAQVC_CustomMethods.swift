//
//  FAQVC_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 02/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

  //MARK:- Custom Methods
extension FAQVC {
   internal func initiallizers() {
    
    if isComingFromPrivacy{
        
        //yaha
        
        lblTitle.attributedText = CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.privacyAndPolicyLT, font: ConstantFonts.HeaderFont, AppColor.whiteColor)
        tblVw.backgroundColor = AppColor.themeColorDark
        
        getPrivacyAndFAQ(urlString:SAuthApi.listPrivacyPolicy)
        
     
        
    }else{
        
        getPrivacyAndFAQ(urlString:SAuthApi.listFaq)
        
        
        lblTitle.attributedText = CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.FAQLT, font: ConstantFonts.HeaderFont, AppColor.whiteColor)
        tblVw.backgroundColor = AppColor.themeColorDark
        
      
        
    }
        
    
    
    
    
    
    configure()

    
    
        
    }
    
    
    func configure() {
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.registerMultiple(nibs: [FAQCell.className,FAQHeader.className])
        
    }
    
    
    
    internal func getPrivacyAndFAQ(urlString:String){
        
        
          let headers = ["Content-Type": "application/json",
                            "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        SAuthService().getTypeService(serviceName: urlString, header: headers).done { (response) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            
            if urlString == "listPrivacyPolicy"{
                if let dataArray = response.resultArray as? NSArray{
                    for item in dataArray{
                        if let itemDict = item as? NSDictionary{
                            if let policy = itemDict.value(forKey: "answer") as? String{
                                self.FAQDataModelArray.append(FAQDataModel(title: ConstantTexts.privacyAndPolicyLT, subtitle: policy, isSelected: true))
                            }
                        }
                    }
                }
                self.tblVw.reloadData()
            }else{
                if let dataArray = response.resultArray as? NSArray{
                    for item in dataArray{
                        if let itemDict = item as? NSDictionary{
                            let item = FAQDataModel(title: String(), subtitle: String(), isSelected: Bool())
                            
                            if let policy = itemDict.value(forKey: "answer") as? String{
                                item.subtitle = policy
                            }
                            
                            if let question = itemDict.value(forKey: "question") as? String{
                                    item.title = question
                            }
                            
                             self.FAQDataModelArray.append(item)
                            
                        }
                    }
                }
                self.tblVw.reloadData()


            }
            
            

            
          
        }.catch { (error) in
            
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            let nsError = error as NSError
            HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
        }
    }
    
    
}

