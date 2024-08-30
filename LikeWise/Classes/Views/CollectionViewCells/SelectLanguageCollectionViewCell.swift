//
//  SelectLanguageCollectionViewCell.swift
//  LikeWise
//
//  Created by Aman Kumar on 28/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit


class SelectLanguageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnSelectRef: UIButton!
    
    var defaultLANG  = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func configureCellWith(_ info:getUserDetail,_ textColor:UIColor){
 
        let image = info.isSelected ? #imageLiteral(resourceName: "select") : #imageLiteral(resourceName: "delete")
        btnSelectRef.setImage(image, for: .normal)
        
        self.imgFlag.sd_setImage(with: URL(string: info.picture), placeholderImage: UIImage(named: "default_pic"))
        
        //   btnSelectRef.isHidden = info.isSelected ? false : true
        
        CustomMethods.shared.provideCornerRadiusTo(imgFlag, 20, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        CustomMethods.shared.provideCornerBorderTo(imgFlag, 2, AppColor.whiteColor)
        lblDetails.numberOfLines = 0
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: info.code, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n(\(info.language))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), textColor))
        
        lblDetails.attributedText = myMutableString
        
    }
    
    
    public func configureCellWithNew(_ info:CountryDataModelCollec,_ textColor:UIColor){
        
        //           let image = info.isSelected ? #imageLiteral(resourceName: "select") : UIImage()
        //           btnSelectRef.setImage(image, for: .normal)
        //           CustomMethods.shared.provideCornerRadiusTo(imgFlag, 20, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        //                  CustomMethods.shared.provideCornerBorderTo(imgFlag, 2, AppColor.whiteColor)
        //           lblDetails.numberOfLines = 0
        //           let myMutableString = NSMutableAttributedString()
        //           myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: info.title, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), textColor))
        //        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(info.titleSub)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0), AppColor.textColor))
        //
        //           lblDetails.attributedText = myMutableString
        
    }
    
    public func configureCellWithNewS(_ info:CountryDataModelCollec,_ textColor:UIColor){
        
        print("defaultLANG",defaultLANG)
        print("Priyanka info.defaultLangCode",info.languageCode ,info.defaultLangCode  )
        
        let image = info.isSelected ? #imageLiteral(resourceName: "select") : UIImage()
        btnSelectRef.setImage(image, for: .normal)

        imgFlag.sd_setImage(with: URL(string: info.profilePic), placeholderImage: UIImage(named: "profile_pic"))
        
        CustomMethods.shared.provideCornerRadiusTo(imgFlag, 20, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        CustomMethods.shared.provideCornerBorderTo(imgFlag, 2, AppColor.whiteColor)
        
        lblDetails.numberOfLines = 0
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: info.name, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), textColor))
       
        lblDetails.attributedText = myMutableString
        
    }
    
    public func configureCellWithNewLang(_ info:LanguageDataModel,_ textColor:UIColor){
        
        let image = info.isSelected ? #imageLiteral(resourceName: "select") : UIImage()
        
        btnSelectRef.setImage(image, for: .normal)
        
        imgFlag.sd_setImage(with: URL(string: info.picture), placeholderImage: UIImage(named: "profile_pic"))
        
        CustomMethods.shared.provideCornerRadiusTo(imgFlag, 20, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerBorderTo(imgFlag, 2, AppColor.whiteColor)
        
        lblDetails.numberOfLines = 0
        
        let myMutableString = NSMutableAttributedString()
        
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: info.language, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), textColor))
        
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n(\(info.code))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), textColor))
        
        lblDetails.attributedText = myMutableString
        
    }
    
    
}
