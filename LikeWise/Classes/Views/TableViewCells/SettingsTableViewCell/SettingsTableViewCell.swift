//
//  SettingsTableViewCell.swift
//  LikeWise
//
//  Created by Aman Kumar on 02/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class SettingsTableViewCell: BaseTableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var switchBtn: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    public func configureSettingsWith(_ info:SettingsDataModel){
        lblTitle.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblTitle.textColor = AppColor.textColor
        lblTitle.text = info.title
        
        lblSubTitle.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblSubTitle.textColor = AppColor.textColor
        lblSubTitle.text = info.subtitle
        
        switchBtn.isHidden = info.isHidden
        switchBtn.setOn(info.isSelected, animated: true)
        
        /*For on state*/
        switchBtn.onTintColor = AppColor.themeColorDark

        /*For off state*/
        switchBtn.tintColor = AppColor.textColor
        switchBtn.layer.cornerRadius = switchBtn.frame.height / 2
        switchBtn.backgroundColor = AppColor.textColor
        
    }
}
