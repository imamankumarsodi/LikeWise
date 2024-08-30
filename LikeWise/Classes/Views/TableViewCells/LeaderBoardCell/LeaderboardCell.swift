//
//  LeaderboardCell.swift
//  LikeWise
//
//  Created by Aman Kumar on 27/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import DYPieChartView

class LeaderboardCell: BaseTableViewCell {
    
    @IBOutlet weak var pieChart: DYPieChartView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgFB: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblProgPer: UILabel!
    @IBOutlet weak var lblGameCount: UILabel!
    @IBOutlet weak var lblTimings: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    internal func setupCell(info:LeaderBoardDataModel){
        viewBG.backgroundColor = AppColor.whiteColor
        CustomMethods.shared.provideShadowAndCornerRadius(viewBG, 10, AppColor.textColor, 2, 2, 0.5, 5, 0, AppColor.clearColor)
        self.backgroundColor = AppColor.clearColor
        
        lblName.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0)
        lblName.textColor = AppColor.textColor
        
        lblDetail.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblDetail.textColor = AppColor.textColor
        
        lblTimings.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 20.0)
        lblTimings.textColor = AppColor.themeColorLight
        
        
        lblGameCount.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblGameCount.textColor = AppColor.textColor
        
        lblProgPer.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblProgPer.textColor = AppColor.textColor
        
        CustomMethods.shared.provideCornerRadiusTo(self.imgProfile, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
               imgProfile.contentMode = .scaleAspectFill
        
        // MARK: - init and setup DYPieChartView
        pieChart.startAngle = -.pi / 2
        pieChart.clockwise = true
        pieChart.lineWidth = 5
        pieChart.backgroundColor = AppColor.whiteColor
        
        pieChart.sectorColors = [
            AppColor.themeColorDark,
            AppColor.placeholderColor
        ]
        
        // MARK: - animations
        //type 1: for duration
        
         self.pieChart.animate(toScaleValues: [NSNumber(value: (Double(info.All_LikeWise_Persantege) ?? 0.0)/100),NSNumber(value: (100 - (Double(info.All_LikeWise_Persantege) ?? 0.0))/100)], duration: 2)
      
        //type 2: quickly
        
      
        lblName.text = info.name
        lblDetail.text = "\(info.totalPoints)"
        lblProgPer.text = "\(info.All_LikeWise_Persantege)\(ConstantTexts.PerLT)"
        lblTimings.text = "\(info.gameCounts)"
        lblGameCount.text = "\(info.All_LikeWise_Number) \(ConstantTexts.GamesLT)"
        imgProfile.sd_setImage(with: URL(string: info.profilePic), placeholderImage: UIImage(named: "profile_pic"))
        imgFB.isHidden = (info.type == 1) ? false : true
        
    }
    
    
    
    internal func setupCellPurple(){
        viewBG.backgroundColor = AppColor.themeColorLight
        CustomMethods.shared.provideShadowAndCornerRadius(viewBG, 10, AppColor.textColor, 2, 2, 0.5, 5, 0, AppColor.clearColor)
        self.backgroundColor = AppColor.clearColor
        
        lblName.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0)
        lblName.textColor = AppColor.whiteColor
        
        lblDetail.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblDetail.textColor = AppColor.whiteColor
        
        lblTimings.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 20.0)
        lblTimings.textColor = AppColor.whiteColor
        
        
        lblGameCount.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblGameCount.textColor = AppColor.whiteColor
        
        lblProgPer.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblProgPer.textColor = AppColor.textColor
        
        
        // MARK: - init and setup DYPieChartView
        pieChart.startAngle = -.pi / 2
        pieChart.clockwise = true
        pieChart.lineWidth = 5
        pieChart.backgroundColor = AppColor.whiteColor
        
        pieChart.sectorColors = [
            AppColor.themeColorDark,
            AppColor.placeholderColor
        ]
        
        // MARK: - animations
        //type 1: for duration
        pieChart.animate(toScaleValues: [NSNumber(value: 0.8),NSNumber(value: 0.2)], duration: 2)
        //type 2: quickly
        lblName.text = "Jack Shukla"
        lblDetail.text = "25800"
        lblProgPer.text = "80%"
        lblTimings.text = "08"
        lblGameCount.text = "43 \(ConstantTexts.GamesLT)"
        
        
        
    }
    
    
}
