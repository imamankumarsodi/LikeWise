//
//  GetCoinsvc_CustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 28/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Custom Methods
extension GetCoinsvc {
    func initiallizers() {
        collectionView.register(nib: GetCoinCollectionViewCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.referFriendView, 24.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(self.watchVideoView,24.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        
        lblHeaderTitle.font = ConstantFonts.SubmitButtonFont
        lblHeaderTitle.textColor = AppColor.whiteColor
        lblHeaderTitle.text = ConstantTexts.GetCoinsLT
        
        
        lblBuy.font = ConstantFonts.SubmitButtonFont
        lblBuy.textColor = AppColor.whiteColor
        lblBuy.text = ConstantTexts.BuyLT
        
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "  \(ConstantTexts.ReferAFriendLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "  +\(0) (\(ConstantTexts.CoinsLT))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0), AppColor.themeColorDark))
        
        btnReferfriends.setAttributedTitle(myMutableString, for: .normal)
        
        
        myMutableString = NSMutableAttributedString()
        
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "  \(ConstantTexts.WatchAVideoLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "  +\(0) (\(ConstantTexts.CoinsLT))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0), AppColor.themeColorDark))
        
        btnWatchCoinsRef.setAttributedTitle(myMutableString, for: .normal)
        
        
        lblInstruction.font = ConstantFonts.TitleNewFont
        lblInstruction.textColor = AppColor.whiteColor
        lblInstruction.text = "\(ConstantTexts.BuyLT) 3 \(ConstantTexts.coinsForLT) 300 \(ConstantTexts.pointsYouScoreLT)"
        lblInstruction.isHidden = true
        
        gelistMobileCoinApi()
        
    }
    
    
    
    internal func gelistMobileCoinApi(){
        
        
        let headers = ["Content-Type": "application/json",
                       "accept": "application/json"]
        
        print(headers)
        
        CustomMethods.shared.showLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
        SAuthService().getTypeService(serviceName: SAuthApi.listMobileCoin, header: headers).done { (response) in
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            print(response)
            
            if self.getCoinsDataModelArray.count > 0{
                self.getCoinsDataModelArray.removeAll()
            }
            
            if let dataDict = response.resultDict as? NSDictionary{
                if let coinScreenDataArray = dataDict.value(forKey: "coinModel") as? NSArray{
                    if coinScreenDataArray.count > 0{
                        
                        if let details = coinScreenDataArray.object(at: 0) as? NSDictionary{
                            var myMutableString = NSMutableAttributedString()
                            if let referFriend = details.value(forKey: "referFriend") as? Int{
                                myMutableString = NSMutableAttributedString()
                                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "  \(ConstantTexts.ReferAFriendLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
                                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "  +\(referFriend) (\(ConstantTexts.CoinsLT))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0), AppColor.themeColorDark))
                                
                                self.btnReferfriends.setAttributedTitle(myMutableString, for: .normal)
                            }
                            
                            if let watchVideo = details.value(forKey: "watchVideo") as? Int{
                                
                                myMutableString = NSMutableAttributedString()
                                
                                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "  \(ConstantTexts.WatchAVideoLT)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
                                myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "  +\(watchVideo) (\(ConstantTexts.CoinsLT))", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0), AppColor.themeColorDark))
                                
                                self.btnWatchCoinsRef.setAttributedTitle(myMutableString, for: .normal)
                            }
                            
                            
                        }
                    }
                }
                
                if let coinPayArray = dataDict.value(forKey: "coinPay") as? NSArray{
                    for index in 0..<coinPayArray.count{
                        if let coinDict = coinPayArray[index] as? NSDictionary{
                            if index == 0{
                                let c_item = GetCoinsDataModel(_id: String(), image: #imageLiteral(resourceName: "a"), coins: String(), price: String(), coinsInt: Int(), priceInt: Int())
                                
                                if let _id = coinDict.value(forKey: "_id") as? String{
                                    c_item._id = _id
                                }
                                
                                if let coin = coinDict.value(forKey: "coin") as? Int{
                                    c_item.coinsInt = coin
                                    c_item.coins = "+\(coin) \(ConstantTexts.CoinsLT)"
                                }
                                
                                if let dollar = coinDict.value(forKey: "dollar") as? Int{
                                    c_item.priceInt = dollar
                                    c_item.price = "\(ConstantTexts.CurLT)\(dollar)"
                                }
                                
                                self.getCoinsDataModelArray.append(c_item)
                                
                                
                            }else if index == 1{
                                let c_item = GetCoinsDataModel(_id: String(), image: #imageLiteral(resourceName: "b"), coins: String(), price: String(), coinsInt: Int(), priceInt: Int())
                                
                                if let _id = coinDict.value(forKey: "_id") as? String{
                                    c_item._id = _id
                                }
                                
                                if let coin = coinDict.value(forKey: "coin") as? Int{
                                    c_item.coinsInt = coin
                                    c_item.coins = "+\(coin) \(ConstantTexts.CoinsLT)"
                                }
                                
                                if let dollar = coinDict.value(forKey: "dollar") as? Int{
                                    c_item.priceInt = dollar
                                    c_item.price = "\(ConstantTexts.CurLT)\(dollar)"
                                }
                                
                                self.getCoinsDataModelArray.append(c_item)
                                
                            }else if index == 2{
                                let c_item = GetCoinsDataModel(_id: String(), image: #imageLiteral(resourceName: "c"), coins: String(), price: String(), coinsInt: Int(), priceInt: Int())
                                
                                if let _id = coinDict.value(forKey: "_id") as? String{
                                    c_item._id = _id
                                }
                                
                                if let coin = coinDict.value(forKey: "coin") as? Int{
                                    c_item.coinsInt = coin
                                    c_item.coins = "+\(coin) \(ConstantTexts.CoinsLT)"
                                }
                                
                                if let dollar = coinDict.value(forKey: "dollar") as? Int{
                                    c_item.priceInt = dollar
                                    c_item.price = "\(ConstantTexts.CurLT)\(dollar)"
                                }
                                
                                self.getCoinsDataModelArray.append(c_item)
                                
                            }else{
                                let c_item = GetCoinsDataModel(_id: String(), image: #imageLiteral(resourceName: "d"), coins: String(), price: String(), coinsInt: Int(), priceInt: Int())
                                
                                if let _id = coinDict.value(forKey: "_id") as? String{
                                    c_item._id = _id
                                }
                                
                                if let coin = coinDict.value(forKey: "coin") as? Int{
                                    c_item.coinsInt = coin
                                    c_item.coins = "+\(coin) \(ConstantTexts.CoinsLT)"
                                }
                                
                                if let dollar = coinDict.value(forKey: "dollar") as? Int{
                                    c_item.priceInt = dollar
                                    c_item.price = "\(ConstantTexts.CurLT)\(dollar)"
                                }
                                
                                self.getCoinsDataModelArray.append(c_item)
                            }
                        }
                        
                        self.collectionView.reloadData()
                    }
                }
                
                
            }
            
            
        }.catch { (error) in
            
            CustomMethods.shared.hideLoader(view: self.view, nav: (self.navigationController?.navigationBar)!)
            
            let nsError = error as NSError
            HHelper.showAlert(nsError.userInfo["errorMessage"] as! String)
        }
    }
    
}
