//
//  HomeVC_Root_CustomMethods.swift
//  LikeWise
//
//  Created by Deepti Sharma on 21/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


//MARK: - Extension Custom methods
extension HomeVC_Root{
    
    //TODO: Setup navigation method
    internal func setupNavigation(){
        super.transparentNavigation()
        super.hideNavigationBar(true)
        headerHeight.constant = CustomMethods.shared.provideTopHeight()
        viewHeader.backgroundColor = AppColor.clearColor
    }
    
    
    //TODO: Initial setup method
    internal func initialSetup(){
        imgBackgroud.image = AppImages.bgImage
        CustomMethods.shared.provideCornerRadiusTo(self.viewButtonStack, self.viewButtonStack.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        
        lblHeading.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 16.0)
        lblHeading.textColor = AppColor.whiteColor
        
        
        lblPlay.font = ConstantFonts.SubmitButtonFont
        lblPlay.textColor = AppColor.whiteColor
        
        
        lblCentre.numberOfLines = 0
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.FeelsEmptyLT, font:  ConstantFonts.SubmitButtonFont, AppColor.searchColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\n\n\(ConstantTexts.TimeToStartGameLT)", font: ConstantFonts.SubmitButtonFont, AppColor.whiteColor))
        lblCentre.attributedText = myMutableString
        
        
        lblCreate.font = ConstantFonts.SubmitButtonFont
        lblCreate.textColor = AppColor.whiteColor
        
        self.lblPlay.isHidden = true
        self.lblCreate.isHidden = true
        self.imgArrow.isHidden =  true
        self.lblCentre.isHidden = true
        
        
        lblPlay.numberOfLines = 0
        myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.PlayLT, font:  ConstantFonts.SubmitButtonFont, AppColor.whiteColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.WithARandomLT)", font: ConstantFonts.HeaderButtonFont, AppColor.whiteColor))
        lblPlay.attributedText = myMutableString
        
        
        lblCreate.numberOfLines = 0
        myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: ConstantTexts.CreateLT, font:  ConstantFonts.SubmitButtonFont, AppColor.whiteColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.AGameForLT)", font: ConstantFonts.HeaderButtonFont, AppColor.whiteColor))
        lblCreate.attributedText = myMutableString
        
        
        viewButtonStackNewOutHeader.backgroundColor = AppColor.themeColorLight
        CustomMethods.shared.provideCornerRadiusTo(self.viewButtonStackNewOutHeader, self.viewButtonStackNewOutHeader.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        print(lblHeading.frame.size.width)
        
        
        
        
        
        
        CustomMethods.shared.provideCornerRadiusTo(self.btnAllRef, self.btnAllRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        
        
        CustomMethods.shared.provideCornerRadiusTo(self.btnCurrentRef, self.btnCurrentRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        
        CustomMethods.shared.provideCornerRadiusTo(self.btnCompletedRef, self.btnCompletedRef.frame.size.height/2,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        getUserData()
        
        NSLayoutConstraint.activate([
            notificationsButton.widthAnchor.constraint(equalToConstant: 34),
            notificationsButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        //  showBadge(withCount: 10)
        
        
        
        changeHeader()
        
        self.scrollView.contentSize = CGSize(width: 3*self.view.frame.width,height: self.scrollView.frame.height);
        
        /*self.addChildViewController(ScreenManager.getMyOrderNoralUserPendingVC())*/
        let allVC = AppStoryboard.home.instantiateViewController(withIdentifier: AllScreenVC.className) as! AllScreenVC
        let currentVC = AppStoryboard.home.instantiateViewController(withIdentifier: CurrentVC.className) as! CurrentVC
        let completedVC = AppStoryboard.home.instantiateViewController(withIdentifier: CompletedVC.className) as! CompletedVC
        
        
        currentVC.callBackData = { (count) -> Void in
            self.currentCount = count
            print(self.currentCount)
            self.imgBackgroud.image = (self.currentCount > 0) ? #imageLiteral(resourceName: "bckgd") : #imageLiteral(resourceName: "bg_blank")
            self.lblPlay.isHidden = (self.currentCount > 0) ? true : false
            self.imgArrow.isHidden = (self.currentCount > 0) ? true : false
            self.lblCentre.isHidden = (self.currentCount > 0) ? true : false
            self.lblCreate.isHidden = (self.currentCount > 0) ? true : false
        }
        
        allVC.callBackData = { (count) -> Void in
            self.allCount = count
            
        }
        
        completedVC.callBackData = { (count) -> Void in
            self.completedCount = count
            
        }
        
        self.addChild(allVC)
        self.addChild(currentVC)
        self.addChild(completedVC)
        
        self.loadScrollView()
        
        
        
        /*  NotificationCenter.default.addObserver(
         self,
         selector: #selector(self.batteryLevelChanged),
         name: UIDevice.batteryLevelDidChangeNotification,
         object: nil) */
        
        
        
        UserDefaults.standard.set(isSelectLikeWise, forKey: "MATCH_BTN")
        
        showBadgeCount()
        hitDailyCoinsApiApi()
    }
    
    
    func showBadgeCount(){
        
        let badgeCount = UILabel(frame: CGRect(x: 16, y: 1, width: 15, height: 15))
        badgeCount.layer.borderColor = UIColor.clear.cgColor
        badgeCount.layer.borderWidth = 2
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .red
        notificationsButton.addSubview(badgeCount)
        if let badge = UserDefaults.standard.value(forKey: "BADGE") as? Int{
            if badge == 0{
                badgeCount.isHidden = true
            }else{
                badgeCount.isHidden = false
                badgeCount.text = "\(badge)"
            }
        }else{
            badgeCount.isHidden = true
            
            
        }
        
    }
    
    
    func getUserData(){
        let realm = try! Realm()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                
                
                CustomMethods.shared.setupButton(btnCollectedCoinRef, AppColor.textColor,AppColor.whiteColor, AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), " \((user.totalPoints == Double()) ? "0" : "\(Int(round(user.totalPoints)))") \(ConstantTexts.PointsLT)")
                CustomMethods.shared.setupButton(btnGoldenCoinRef, AppColor.textColor,AppColor.whiteColor,AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0), "   \((user.coins == Double()) ? "0" : "\(Int(round(user.coins)))")")
                
            }
            
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }
    
    
    
    
    //TODO: Api for hit daily coins
    internal func hitDailyCoinsApiApi(){
        newProfile = false
        var token = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        let headers = ["authorization":token,
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(token)
        
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        SAuthService().getTypeService(serviceName: SAuthApi.dailyCheckCoin, header: headers).done { (response) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
        
                if let dataDict = response.resultDict{
                    let resCode = dataDict.value(forKey: "responseCode") as? Int ?? 0
                    
                    print("resCode" ,resCode)
                    if let result = dataDict.value(forKey: "result") as? Int{
                        if result == 1{
                            let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: DailyCoinsInCheckVC.className) as! DailyCoinsInCheckVC
                            vc.homeCallBack = { [weak self] in
                                self?.getUserData()
                            }
                            self.navigationController?.present(vc, animated: true, completion: nil)
                            
                        }
                    }
                    
                    if let result = dataDict.value(forKey: "result") as? String{
                        
                        if result == "1"{
                            let vc = AppStoryboard.sideBar.instantiateViewController(withIdentifier: DailyCoinsInCheckVC.className) as! DailyCoinsInCheckVC
                            
                            vc.homeCallBack = { [weak self] in
                                self?.getUserData()
                            }
                            
                            self.navigationController?.present(vc, animated: true, completion: nil)
                        }
                    }
                    
                    
                }

          
        }.catch { (error) in
            
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            let nsError = error as NSError
            HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
        }
    }
    
    
    
    internal func changeHeader(){
        if isSelectLikeWise{
            
            
            self.imgBackgroud.image = (self.allCount > 0) ? #imageLiteral(resourceName: "bckgd") : #imageLiteral(resourceName: "bg_blank")
            self.lblPlay.isHidden = (self.allCount > 0) ? true : false
            self.imgArrow.isHidden = (self.allCount > 0) ? true : false
            self.lblCreate.isHidden = (self.allCount > 0) ? true : false
            self.lblCentre.isHidden  = (self.allCount > 0) ? true : false
            lblHeading.text = ConstantTexts.MyMathcesLT
            self.btnAllRef.isHidden = false
            self.btnCurrentRef.isHidden = false
            self.btnCompletedRef.isHidden = false
            self.btnLikeWiseRef.setImage(#imageLiteral(resourceName: "match_selected"), for: .normal)
            
            CustomMethods.shared.setupButton(btnAllRef, AppColor.whiteColor,AppColor.themeColorDark,ConstantFonts.HeaderFont,ConstantTexts.allBT)
            
            CustomMethods.shared.setupButton(btnCurrentRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.friendsBT)
            
            
            CustomMethods.shared.setupButton(btnCompletedRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.randomBT)
            
            animateScrollViewHorizontally(destinationPoint: CGPoint(x: 0 * self.view.frame.width, y: 0), andScrollView: self.scrollView, andAnimationMargin: 0)
            
            
        }else{
            self.imgBackgroud.image = (self.currentCount > 0) ? #imageLiteral(resourceName: "bckgd") : #imageLiteral(resourceName: "bg_blank")
            self.lblPlay.isHidden = (self.currentCount > 0) ? true : false
            self.imgArrow.isHidden = (self.currentCount > 0) ? true : false
            self.lblCentre.isHidden  = (self.currentCount > 0) ? true : false
            self.lblCreate.isHidden = (self.currentCount > 0) ? true : false
            
            lblHeading.text = ConstantTexts.MyGAMESLT
            self.btnAllRef.isHidden = true
            self.btnCurrentRef.isHidden = false
            self.btnCompletedRef.isHidden = false
            self.btnLikeWiseRef.setImage(#imageLiteral(resourceName: "match"), for: .normal)
            
            CustomMethods.shared.setupButton(btnAllRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.allBT)
            
            CustomMethods.shared.setupButton(btnCurrentRef, AppColor.whiteColor,AppColor.themeColorDark,ConstantFonts.HeaderFont,ConstantTexts.currentBT)
            
            CustomMethods.shared.setupButton(btnCompletedRef, AppColor.whiteColor,AppColor.themeColorLight,ConstantFonts.HeaderFont,ConstantTexts.completedBT)
            
            animateScrollViewHorizontally(destinationPoint: CGPoint(x: 1 * self.view.frame.width, y: 0), andScrollView: self.scrollView, andAnimationMargin: 0)
            
        }
        
    }
    
    
    
    //TODO: animateScrollViewHorizontally method
    internal func animateScrollViewHorizontally(destinationPoint destination: CGPoint, andScrollView scrollView: UIScrollView, andAnimationMargin margin: CGFloat) {
        
        var change: Int = 0;
        let diffx: CGFloat = destination.x - scrollView.contentOffset.x;
        var _: CGFloat = destination.y - scrollView.contentOffset.y;
        
        if(diffx < 0) {
            
            change = 1
        }
        else {
            
            change = 2
            
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3);
        UIView.setAnimationCurve(.easeIn);
        switch (change) {
            
        case 1:
            scrollView.contentOffset = CGPoint(x: destination.x - margin, y: destination.y);
        case 2:
            scrollView.contentOffset = CGPoint(x: destination.x + margin, y: destination.y);
        default:
            return;
        }
        
        UIView.commitAnimations();
        
        let firstDelay: Double  = 0.3;
        let startTime: DispatchTime = DispatchTime.now() + Double(Int64(firstDelay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: startTime, execute: {
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2);
            UIView.setAnimationCurve(.linear);
            switch (change) {
                
            case 1:
                scrollView.contentOffset = CGPoint(x: destination.x + margin, y: destination.y);
            case 2:
                scrollView.contentOffset = CGPoint(x: destination.x - margin, y: destination.y);
            default:
                return;
            }
            
            UIView.commitAnimations();
            let secondDelay: Double  = 0.2;
            let startTimeSecond: DispatchTime = DispatchTime.now() + Double(Int64(secondDelay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: startTimeSecond, execute: {
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.1);
                UIView.setAnimationCurve(.easeInOut);
                scrollView.contentOffset = CGPoint(x: destination.x, y: destination.y);
                UIView.commitAnimations();
                
            })
        })
    }
    
    //TODO: loadScrollView method
    internal func loadScrollView()
    {
        print(self.children)
        for index in 0 ..< self.children.count
        {
            self.loadScrollViewWithPage(index);
        }
    }
    
    //TODO: loadScrollViewWithPage method
    func loadScrollViewWithPage(_ page : Int) -> Void
    {
        if(page < 0)
        {
            return
        }
        if page >= self.children.count
        {
            return
        }
        let viewController: UIViewController? = (self.children as NSArray).object(at: page) as? UIViewController
        if(viewController == nil)
        {
            return
        }
        if(viewController?.view.superview == nil){
            
            var frame: CGRect  = self.scrollView.frame
            frame.origin.x = self.view.frame.width*CGFloat(page)
            frame.origin.y = 0;
            viewController?.view.frame = frame;
            self.scrollView.addSubview(viewController!.view);
        }
    }
    
    
    func badgeLabel(withCount count: Int) -> UILabel {
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.tag = badgeTag
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .systemRed
        badgeCount.text = String(count)
        return badgeCount
    }
    
    func showBadge(withCount count: Int) {
        let badge = badgeLabel(withCount: count)
        notificationsButton.addSubview(badge)
        
        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: notificationsButton.leftAnchor, constant: 12),
            badge.topAnchor.constraint(equalTo: notificationsButton.topAnchor, constant: 2),
            badge.widthAnchor.constraint(equalToConstant: badgeSize),
            badge.heightAnchor.constraint(equalToConstant: badgeSize)
        ])
    }
    
    
    
}

