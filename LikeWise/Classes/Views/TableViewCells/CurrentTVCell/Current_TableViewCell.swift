//
//  Current_TableViewCell.swift
//  LikeWise
//
//  Created by Deepti Sharma on 24/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit
import DYPieChartView

class Current_TableViewCell: BaseTableViewCell {
    
    
    
    @IBOutlet weak var pieChart: DYPieChartView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgFB: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblProgPer: UILabel!
    @IBOutlet weak var viewBGLight: UIView!
    @IBOutlet weak var viewBGDark: UIView!
    @IBOutlet weak var lblTimings: UILabel!
    
    @IBOutlet weak var viewLanguage: UIView!
    @IBOutlet weak var viewLive: UIView!
    @IBOutlet weak var viewPoints: UIView!
    @IBOutlet weak var viewMatch: UIView!
    
    
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblLives: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblMatches: UILabel!
    
    @IBOutlet weak var imgFlag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupCell(withInfo:CurrentGameDataModel){
        viewBG.backgroundColor = AppColor.whiteColor
        CustomMethods.shared.provideShadowAndCornerRadius(viewBG, 10, AppColor.textColor, 2, 2, 0.5, 5, 0, AppColor.clearColor)
        self.backgroundColor = AppColor.clearColor
        
        lblName.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0)
        lblName.textColor = AppColor.textColor
        
        lblDetail.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        lblDetail.textColor = AppColor.textColor
        
        lblTimings.font = AppFont.light.size(AppFontName.SegoeUI, size: 12.0)
        lblTimings.textColor = AppColor.textColor
        
        
        lblProgPer.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblProgPer.textColor = AppColor.textColor
        
        viewBGDark.backgroundColor = AppColor.themeColorDark
        viewBGLight.backgroundColor = AppColor.themeColorLight
        
        viewLanguage.backgroundColor = AppColor.themeColorLight
        viewLive.backgroundColor = AppColor.themeColorLight
        viewPoints.backgroundColor = AppColor.themeColorLight
        viewMatch.backgroundColor = AppColor.themeColorLight
        
        
        lblLanguage.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblLanguage.textColor = AppColor.whiteColor
        
        lblLives.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblLives.textColor = AppColor.whiteColor
        
        lblPoints.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblPoints.textColor = AppColor.whiteColor
        
        lblMatches.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblMatches.textColor = AppColor.whiteColor
        
        CustomMethods.shared.provideCornerRadiusTo(viewBGLight, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
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
        pieChart.animate(toScaleValues: [NSNumber(value: withInfo.LikeWisePersantege/100),NSNumber(value: (100 - withInfo.LikeWisePersantege)/100)], duration: 2)
        //type 2: quickly
        lblName.text = withInfo.name
        lblDetail.text = "\(withInfo.common_game) \(ConstantTexts.CommonGamesLT)"
        lblProgPer.text = "\(withInfo.LikeWisePersantege)\(ConstantTexts.PerLT)"
        
        /// Start **** Formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone?
        /// Formatter **** End
        
        /// Start **** CreatedAt Date
        let createdAt = formatter.date(from: withInfo.createdAt) as? Date ?? Date()
        /// CreatedAt Date **** End
        
        /// Start **** Currnet Date string
        var curr_time = Date()
        curr_time = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()))
        let curr_time_string = formatter.string(from: curr_time)
        print(curr_time_string)
        /// Currnet Date string **** End
        
        lblTimings.text = curr_time.timeAgoSinceDate(date: createdAt as NSDate, numericDates: false)
        
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(withInfo.objectives)", font: AppFont.light.size(AppFontName.SegoeUI, size: 12.0), AppColor.themeColorLight))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "  \(withInfo.morePreciselys)", font: AppFont.light.size(AppFontName.SegoeUI, size: 12.0), AppColor.textColor))
        
        lblDetail.numberOfLines = 0
        lblDetail.attributedText = myMutableString
        
        
        
        lblLanguage.text = withInfo.lang_language
        lblLives.text = ConstantTexts.LivesLT
        
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 8 // Whatever line spacing you want in points
        
        var  myMutableStringNew = NSMutableAttributedString()
        myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(withInfo.PointTotalMatchPersantege)", font:  AppFont.semibold.size(AppFontName.SegoeUI, size: 12), AppColor.whiteColor))
        myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.PointsLT)", font:  AppFont.semibold.size(AppFontName.SegoeUI, size: 12), AppColor.whiteColor))
        
        // *** Apply attribute to string ***
        myMutableStringNew.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableStringNew.length))
        paragraphStyle.alignment = .center
        lblPoints.attributedText = myMutableStringNew
        
        
        
        myMutableStringNew = NSMutableAttributedString()
        myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(withInfo.PointTotalMatchPersantege)", font:  AppFont.semibold.size(AppFontName.SegoeUI, size: 12), AppColor.whiteColor))
        myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(ConstantTexts.PerLT)", font:  AppFont.semibold.size(AppFontName.SegoeUI, size: 8), AppColor.whiteColor))
        myMutableStringNew.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(ConstantTexts.MatchLT)", font:  AppFont.semibold.size(AppFontName.SegoeUI, size: 12), AppColor.whiteColor))
        
        // *** Apply attribute to string ***
        myMutableStringNew.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableStringNew.length))
        paragraphStyle.alignment = .center
        
        lblMatches.attributedText = myMutableStringNew
        
        imgProfile.sd_setImage(with: URL(string: withInfo.profilePic), placeholderImage: UIImage(named: "profile_pic"))
        CustomMethods.shared.provideCornerRadiusTo(imgProfile, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        CustomMethods.shared.provideCornerBorderTo(imgProfile, 2, AppColor.whiteColor)
        
        imgFB.isHidden = (withInfo.user_type == 1) ? false : true
        
        imgFlag.sd_setImage(with: URL(string: withInfo.lang_picture), placeholderImage: UIImage(named: "profile_pic"))
        CustomMethods.shared.provideCornerRadiusTo(imgFlag, imgFlag.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        CustomMethods.shared.provideCornerBorderTo(imgFlag, 1, AppColor.whiteColor)
        
    }
    
    
}
