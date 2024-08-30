//
//  CreategameObjectiveCollectionViewCell.swift
//  LikeWise
//
//  Created by Aman Kumar on 01/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class CreategameObjectiveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var choiceNmae: UILabel!
    @IBOutlet weak var choiceImg: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func configureCellWithNew(_ info:Objective,_ textColor:UIColor){
 
        CustomMethods.shared.provideShadowAndCornerRadius(backView, 8.0, AppColor.textColor, 5, 5, 0.5, 10, 0, AppColor.clearColor)
      
        let imageurl = info.isSelected ? info.pictureSelected : info.pictureUnSelected
        choiceImg.sd_setImage(with: URL(string: imageurl), placeholderImage: UIImage(named: "default_pic"))
        backView.backgroundColor = info.isSelected ? AppColor.themeColorLight : AppColor.whiteColor
        choiceNmae.textColor = info.isSelected ? AppColor.placeholderColor : AppColor.whiteColor
        choiceNmae.numberOfLines = 0
        choiceNmae.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 13.0)
        choiceNmae.text = info.explanation
        
    }
    
    
}
