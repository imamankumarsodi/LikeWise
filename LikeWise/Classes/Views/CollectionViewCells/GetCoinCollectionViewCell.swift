//
//  GetCoinCollectionViewCell.swift
//  LikeWise
//
//  Created by Atendra on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class GetCoinCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var colletionBackGroundView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var lbldollar: UILabel!
    @IBOutlet weak var lblCoins: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    
    internal func setup(){
        CustomMethods.shared.provideShadowAndCornerRadius(backGroundView, 10, AppColor.textColor, 2, 2, 0.5, 5, 0, AppColor.clearColor)
        
        CustomMethods.shared.provideShadowAndCornerRadius(priceView, 10.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        lbldollar.font = AppFont.semibold.size(.SegoeUI, size: 13)
        lbldollar.textColor = AppColor.whiteColor
        
        
        lblCoins.font = AppFont.bold.size(.SegoeUI, size: 14)
        lblCoins.textColor = AppColor.themeColorLight
        
    }
    
    
    public func configureCellWith(_ info:GetCoinsDataModel){
        
        lblCoins.text = info.coins
        lbldollar.text = info.price
        imgView.image = info.image
        
    }
    
}
