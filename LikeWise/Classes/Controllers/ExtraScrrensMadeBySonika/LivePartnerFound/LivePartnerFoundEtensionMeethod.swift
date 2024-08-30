//
//  LivePartnerFoundEtensionMeethod.swift
//  LikeWise
//
//  Created by cst on 25/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit

extension LivePartnerFoundViewController{
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
    }
    
    internal func initialSetUp(){
        
        self.view.backgroundColor = AppColor.themeColorDark
        CustomMethods.shared.provideShadowAndCornerRadius(self.backView, 15.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        lblHeadingRef.font = ConstantFonts.SubmitButtonFont
        lblHeadingRef.textColor = AppColor.whiteColor
        lblHeadingRef.text = ConstantTexts.PartnerFoundLT
        
        
        lblLanguage.numberOfLines = 0
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.PortugeseNewBT, font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n(\(ConstantTexts.PortugalBT))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 8.0), AppColor.textColor))
        
        lblLanguage.attributedText = myMutableString
        
        
        lblPlayerInfo.numberOfLines = 0
        myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "Jack Shukla, 19\(ConstantTexts.YrsLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.MaleLT) India", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 8.0), AppColor.textColor))
        
        lblPlayerInfo.attributedText = myMutableString
    }
}
