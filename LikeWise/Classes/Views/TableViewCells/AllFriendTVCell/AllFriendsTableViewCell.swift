//
//  AllFriendsTableViewCell.swift
//  LikeWise
//
//  Created by Deepti Sharma on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import DYPieChartView

class AllFriendsTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var pieChart: DYPieChartView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgFB: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblProgPer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    internal func setupCell(){
        viewBG.backgroundColor = AppColor.whiteColor
        CustomMethods.shared.provideShadowAndCornerRadius(viewBG, 10, AppColor.textColor, 2, 2, 0.5, 5, 0, AppColor.clearColor)
        self.backgroundColor = AppColor.clearColor
        
        lblName.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0)
        lblName.textColor = AppColor.textColor
        
        lblDetail.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        lblDetail.textColor = AppColor.textColor
        
        lblProgPer.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblProgPer.textColor = AppColor.textColor
        
        
        // MARK: - init and setup DYPieChartView
        pieChart.startAngle = -.pi / 2
        pieChart.clockwise = true
        pieChart.lineWidth = 5
        
        pieChart.sectorColors = [
            AppColor.themeColorDark,
             AppColor.placeholderColor
        ]
        
        
    }
    
    func configureCellWith(info:FriendsCommanDataModel){
        // MARK: - animations
         //type 1: for duration
        pieChart.animate(toScaleValues: [NSNumber(value: info.PointTotalMatchPersantege/100),NSNumber(value: (100 - info.PointTotalMatchPersantege)/100)], duration: 2)
         //type 2: quickly
        lblName.text = info.name
        lblDetail.text = "\(info.count) \(ConstantTexts.CommonGamesLT)"
        lblProgPer.text = "\(Int(info.PointTotalMatchPersantege))\(ConstantTexts.PerLT)"
    }
    

}
