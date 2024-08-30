//
//  preciselyCollectionViewCell.swift
//  LikeWise
//
//  Created by Aman Kumar on 01/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class preciselyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func configureCellWithNew(_ info:Morerecisely,_ textColor:UIColor){
        CustomMethods.shared.provideShadowAndCornerRadius(backView, 8.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
        
        print(info.isSelected)
        
        backView.backgroundColor = info.isSelected ? AppColor.themeColorLight : AppColor.whiteColor
        infoLbl.textColor = info.isSelected ?  AppColor.whiteColor : AppColor.placeholderColor
        
        infoLbl.numberOfLines = 0
        infoLbl.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        infoLbl.text = info.converse
        
    }
    
}
