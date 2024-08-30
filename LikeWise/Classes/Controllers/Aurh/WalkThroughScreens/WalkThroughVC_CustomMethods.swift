//
//  WalkThroughVC_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 16/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView

//MARK: - Extension Custom methods
extension WalkThroughVC{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
    }
    
    
    //TODO: Initial setup method
    internal func initialSetup(){
        // Create a pager view
        pager_View.dataSource = self
        pager_View.delegate = self
        pager_View.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        page_controller_ref.tintColor = AppColor.themeColorLight
        page_controller_ref.currentPageIndicatorTintColor = AppColor.whiteColor
        
        
        CustomMethods.shared.setupButton(btnSkipRef, AppColor.whiteColor,AppColor.clearColor,ConstantFonts.SubmitButtonFont, ConstantTexts.skipBT)
        
        CustomMethods.shared.setupButton(btnLetPlayRef, AppColor.themeColorDark,AppColor.whiteColor,ConstantFonts.SubmitButtonFont, ConstantTexts.letPlayBT)
        
        CustomMethods.shared.provideCornerRadiusTo(btnLetPlayRef, btnLetPlayRef.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        btnSkipRef.isHidden = false
        btnLetPlayRef.isHidden = true
        
        lblTopDetails.numberOfLines = 0
        lblTopDetails.textAlignment = NSTextAlignment.center
        
        lblBottomDetails.textColor = UIColor.white
        lblBottomDetails.font = ConstantFonts.HeaderFont
        lblBottomDetails.numberOfLines = 0
        lblBottomDetails.textAlignment = NSTextAlignment.center
        
        
    }
    
}

//MARK: - Extension FSPagerViewDataSource
extension WalkThroughVC:FSPagerViewDelegate,FSPagerViewDataSource{
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        page_controller_ref.numberOfPages = imageArray.count
        return imageArray.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.isUserInteractionEnabled = false
        cell.imageView?.image = imageArray[index]
        page_controller_ref.currentPage = index
        btnIndex = index
        if index == 0{
            
            btnSkipRef.isHidden = false
            btnLetPlayRef.isHidden = false
            lblTopDetails.isHidden = false
            lblBottomDetails.isHidden = true
            lblTopDetails.attributedText =  CustomMethods.shared.provideAttributedTextToControlLeftAllignCenter(title: "\(ConstantTexts.welcomeToChatLT)\n\n", subtitle: ConstantTexts.willPairedLT, titleFont: ConstantFonts.SubmitButtonFont, subtitleFont: ConstantFonts.HeaderFont, titleColor: UIColor.white, subtitleColor: UIColor.white, "")
            
            CustomMethods.shared.setupButton(btnLetPlayRef, AppColor.clearColor,AppColor.clearColor,ConstantFonts.SubmitButtonFont, "")
            
            
        }else if index == 1{
            btnSkipRef.isHidden = false
            btnLetPlayRef.isHidden = false
            lblTopDetails.isHidden = false
            lblBottomDetails.isHidden = false
            lblTopDetails.attributedText =  CustomMethods.shared.provideAttributedTextToControlLeftAllignCenter(title: "\(ConstantTexts.matchChatTimeLT)\n\n", subtitle: ConstantTexts.earnExtaPointsForLT, titleFont: ConstantFonts.SubmitButtonFont, subtitleFont: ConstantFonts.HeaderFont, titleColor: UIColor.white, subtitleColor: UIColor.white, "")
            lblBottomDetails.text = ConstantTexts.earnPointEachTimeLT
            
            CustomMethods.shared.setupButton(btnLetPlayRef, AppColor.clearColor,AppColor.clearColor,ConstantFonts.SubmitButtonFont, "")
            
        }else if index == 2{
            btnSkipRef.isHidden = false
            btnLetPlayRef.isHidden = false
            lblTopDetails.isHidden = true
            lblTopDetails.textColor = UIColor.white
            lblBottomDetails.isHidden = true
            
            
            CustomMethods.shared.setupButton(btnLetPlayRef, AppColor.clearColor,AppColor.clearColor,ConstantFonts.SubmitButtonFont, "")
            
        }else{
            btnSkipRef.isHidden = true
            btnLetPlayRef.isHidden = false
            lblTopDetails.isHidden = false
            lblBottomDetails.isHidden = true
            lblTopDetails.font = ConstantFonts.SubmitButtonFont
            lblTopDetails.text = ConstantTexts.howWellLT
            lblTopDetails.textColor = UIColor.white
            
            CustomMethods.shared.setupButton(btnLetPlayRef, AppColor.themeColorDark,AppColor.whiteColor,ConstantFonts.SubmitButtonFont, ConstantTexts.letPlayBT)
            
            
        }
        
        return cell
    }
    
}
