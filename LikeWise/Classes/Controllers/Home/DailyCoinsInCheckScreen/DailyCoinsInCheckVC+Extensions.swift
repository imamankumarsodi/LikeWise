//
//  DailyCoinsInCheckVC+Extensions.swift
//  LikeWise
//
//  Created by CST on 7/6/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import RealmSwift
import GoogleMobileAds
extension DailyCoinsInCheckVC {
    
    
    
    internal func initialSetup(){
        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
        
        rewardedAd?.load(GADRequest()) { error in
            if let error = error {
                // Handle ad failed to load case.
            } else {
                // Ad successfully loaded.
            }
        }
        CustomMethods.shared.provideCornerRadiusTo(self.emailBtn, 22.0, [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMaxYCorner])
        
        CustomMethods.shared.provideCornerRadiusTo(self.facebookBtn, 22.0, [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner,.layerMinXMaxYCorner])
        
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:ConstantTexts.DailyCheckInLT, font:  ConstantFonts.TitleNewFont, AppColor.textColor))
        
        headingLbl.numberOfLines = 0
        headingLbl.attributedText = myMutableString
        
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:"\(0) \(ConstantTexts.CoinsLT)", font:  ConstantFonts.TitleNewFont, AppColor.textColor))
        
        headingCoin.numberOfLines = 0
        headingCoin.attributedText = myMutableString
        
        
        CustomMethods.shared.provideCornerRadiusTo(self.mainView, 20,[.layerMinXMinYCorner,.layerMaxXMinYCorner])
        
        self.emailBtn.titleLabel?.font =  ConstantFonts.TitleNewFont
        self.facebookBtn.titleLabel?.font =  ConstantFonts.TitleNewFont
        
        self.emailBtn.setTitleColor(AppColor.whiteColor, for: .normal)
        self.facebookBtn.setTitleColor(AppColor.whiteColor, for: .normal)
        
        self.emailBtn.backgroundColor = AppColor.themeColorDark
        self.facebookBtn.backgroundColor = AppColor.errorColor
        
        self.facebookBtn.setTitle(ConstantTexts.collectBT, for: .normal)
        self.emailBtn.setTitle(ConstantTexts.doubleMyEarnBT, for: .normal)
        
        self.viewCoin.backgroundColor = AppColor.clearColor
        
        
        gelistMobileCoinApi()
    }
    
    
    
    internal func gelistMobileCoinApi(){
        
        
        let headers = ["Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        SAuthService().getTypeService(serviceName: SAuthApi.listMobileCoin, header: headers).done { (response) in
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            
            print(response)
            
            if let dataDict = response.resultDict as? NSDictionary{
                if let coinScreenDataArray = dataDict.value(forKey: "coinModel") as? NSArray{
                    if coinScreenDataArray.count > 0{
                        
                        if let details = coinScreenDataArray.object(at: 0) as? NSDictionary{
                            
                            var myMutableString = NSMutableAttributedString()
                            
                            if let watchVideo = details.value(forKey: "watchVideo") as? Int{
                                
                                self.watchVideo = "\(watchVideo)"
                            }
                            
                            if let dailyCollection = details.value(forKey: "dailyCollection") as? Int{
                                
                                self.coinsAmt = "\(dailyCollection)"
                                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:"\(dailyCollection) \(ConstantTexts.CoinsLT)", font:  ConstantFonts.TitleNewFont, AppColor.textColor))
                                
                                self.headingCoin.attributedText = myMutableString
                            }
                            
                        }
                    }
                }
            }
            
        }.catch { (error) in
            
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            
            let nsError = error as NSError
            HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
        }
    }
    
    
    
    internal func addCoinsApi(coinsAmt:String,type:String){
        
        var token = String()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                token = user.jwtToken
                
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        let headers = ["Authorization":token ,
                       "Content-Type": "application/json",
                       "accept": "application/json"]
        
        let prams = ["coin":coinsAmt] as [String:Any]
        
        print(headers)
        
        CustomMethods.shared.showLoaderPresent(view: self.view)
        SAuthService().postService(parameters: prams, serviceName: SAuthApi.addCoins, header: headers).done { (response) -> Void  in
            
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            print(response)
            
            if let dataDict = response.resultDict{
                
                let myMutableString = NSMutableAttributedString()
                if let coins = dataDict.value(forKey: "coins") as? Int {
                    
                    if type == "GET_COIN"{
                        do{
                            try self.realm.write {
                                
                                if let user = self.realm.objects(UserDataModel.self).first{
                                    self.coinsAmt = "\(coins)"
                                    user.coins = Double(coins)
                                    self.startCoinAnimation()
                                }
                            }
                        }catch{
                            print("error")
                        }
                        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:"\(coins) \(ConstantTexts.CoinsLT)", font:  ConstantFonts.TitleNewFont, AppColor.textColor))
                        
                        self.headingCoin.attributedText = myMutableString
                    }else{
                        self.dismiss(animated: true) {
                            
                            do{
                                try self.realm.write {
                                    
                                    if let user = self.realm.objects(UserDataModel.self).first{
                                        self.coinsAmt = "\(coins)"
                                        user.coins = Double(coins)
                                        self.startCoinAnimation()
                                    }
                                }
                            }catch{
                                print("error")
                            }
                            myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text:"\(coins) \(ConstantTexts.CoinsLT)", font:  ConstantFonts.TitleNewFont, AppColor.textColor))
                            
                            self.headingCoin.attributedText = myMutableString
                            
                        }
                    }
                  
                }
            }
            
        }.catch { (error) in
            
            CustomMethods.shared.hideLoaderPresent(view: self.view)
            
            let nsError = error as NSError
            HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
        }
        
    }
    
    
    internal func animateView(){
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.25,
                       initialSpringVelocity: 8.00,
                       options: .allowUserInteraction,
                       animations: {
                        self.viewCoin.transform = CGAffineTransform.identity
        })
        
        
        
    }
    
    
}



extension DailyCoinsInCheckVC : GADRewardedAdDelegate {
    
    
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        addCoinsApi(coinsAmt: watchVideo, type: "Ads")
        
    }
    
    
    
    // Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        
        print("Rewarded ad presented.")
        
    }
    
    
    // Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        
        rewardedAd.load(GADRequest()) { error in
            if let error = error {
                
            } else {
                
            }
        }
        
        
        
    }
    /// Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        
        print("Rewarded ad failed to present.")
        
    }
    
    
}


extension DailyCoinsInCheckVC{
    internal func startCoinAnimation(){
        CustomMethods.shared.showLoaderPresentCoins(view: self.viewCoin, animationName: "18089-gold-coin")
        self.viewCoin.isHidden = false
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            
            guard let viewPoints = self.viewCoin.superview?.convert(self.viewCoin.frame.origin, to: nil) else{
                print("No lblPoints co-ordinates...")
                return
            }
            
            let points = self.distance(CGPoint(x: self.view.frame.size.width / 2,y: 0.0), viewPoints)
            
            self.viewCoin.transform = CGAffineTransform(translationX: points.0, y: points.1)
            
        }){(done) in
            self.facebookBtn.stopBlink()
            self.viewCoin.transform = CGAffineTransform.identity
            self.viewCoin.isHidden = true
            self.homeCallBack!()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    func distance(_ a: CGPoint, _ b: CGPoint) -> (CGFloat,CGFloat) {
        return (CGFloat(a.x - b.x),CGFloat(a.y - b.y))
    }
}
