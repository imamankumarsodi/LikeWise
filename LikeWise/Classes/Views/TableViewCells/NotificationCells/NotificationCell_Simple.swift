//
//  NotificationCell_Simple.swift
//  LikeWise
//
//  Created by Aman Kumar on 28/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class NotificationCell_Simple:BaseTableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblDetials: UILabel!
    @IBOutlet weak var lblTimings: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!

    
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
           viewContainer.backgroundColor = AppColor.whiteColor
           CustomMethods.shared.provideShadowAndCornerRadius(viewContainer, 10, AppColor.textColor, 2, 2, 0.5, 5, 0, AppColor.clearColor)
           self.backgroundColor = AppColor.clearColor
           
           lblTimings.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
           lblTimings.textColor = AppColor.placeholderColor
            
         
       
           
          /* lblLanguage.text = ConstantTexts.SpanishLT
           lblLives.text = ConstantTexts.LivesLT
           lblPoints.text = "786\n\(ConstantTexts.PointsLT)"
           lblMatches.text = "74%\n\(ConstantTexts.MatchLT)" */
           
       }
    
    
    
    func configureCellWith(info:NotificationDataModel){
           
           let myMutableString = NSMutableAttributedString()
           myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(info.name)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0), AppColor.textColor))
                     myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(info.description)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.placeholderColor))
           
           lblTimings.text = info.createdAt
           lblDetials.numberOfLines = 0
           lblDetials.attributedText = myMutableString
          
              
           imgProfile.sd_setImage(with: URL(string: info.profilePic), placeholderImage: UIImage(named: "profile_pic"))
           CustomMethods.shared.provideCornerRadiusTo(imgProfile, imgProfile.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
                  CustomMethods.shared.provideCornerBorderTo(imgProfile, 2, AppColor.whiteColor)
        

         /// Start **** Formatter
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
         formatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
         /// Formatter **** End
         
         /// Start **** CreatedAt Date
         let createdAt = formatter.date(from: info.createdAt) as? Date ?? Date()
         /// CreatedAt Date **** End
        
         
          /// Start **** Currnet Date string
         var curr_time = Date()
         curr_time = Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()))
         let curr_time_string = formatter.string(from: curr_time)
         print(curr_time_string)
         /// Currnet Date string **** End
         
         /// Start **** Currnet Date Date
          curr_time = formatter.date(from: curr_time_string) as? Date ?? Date()
         /// Currnet Date Date **** End
         
         print(curr_time.timeAgoSinceDate(date: createdAt as NSDate, numericDates: false))
         lblTimings.text = curr_time.timeAgoSinceDate(date: createdAt as NSDate, numericDates: false)
         
                   
           
       }
       
    
}
