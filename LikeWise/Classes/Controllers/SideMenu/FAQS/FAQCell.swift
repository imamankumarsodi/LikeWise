//
//  FAQCell.swift
//  LikeWise
//
//  Created by Mobulous on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var vwOuter: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    public func configureSettingsWith(_ info:FAQDataModel){
        
        CustomMethods.shared.provideCornerRadiusTo(vwOuter, 6, [.layerMaxXMaxYCorner,.layerMinXMaxYCorner])
        
        lblDescription.font = AppFont.light.size(AppFontName.SegoeUI, size: 15.0)
        lblDescription.textColor = AppColor.textColor
        lblDescription.text = info.subtitle
    }
}
