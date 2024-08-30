//
//  NotificationTableViewCell.swift
//  LikeWise
//
//  Created by Aman Kumar on 27/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import UIKit

class NotificationTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblDetials: UILabel!
    @IBOutlet weak var lblTimings: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnAcceptRef: UIButton!
    @IBOutlet weak var btnDeclineRef: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    var timer:Timer?
    var timeLeft = Int()
    
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
        
     //   CustomMethods.shared.provideShadowAndCornerRadius(viewContainer, 10, AppColor.textColor, 2, 2, 0.5, 5, 0, AppColor.clearColor)
        
        self.backgroundColor = AppColor.clearColor
        
        CustomMethods.shared.provideCornerBorderTo(viewContainer, 1, AppColor.placeholderColor)
        
        
        CustomMethods.shared.provideCornerRadiusTo(self.viewContainer, 10,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        lblTimings.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0)
        lblTimings.textColor = AppColor.placeholderColor
        
        lblTimer.backgroundColor = AppColor.timerColor
        CustomMethods.shared.provideCornerRadiusTo(self.lblTimer, self.lblTimer.frame.size.height/2,[.layerMaxXMinYCorner,.layerMaxXMaxYCorner])
        
        lblTimer.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 10.0)
        lblTimer.textColor = AppColor.errorColor
        lblTimer.textAlignment = .center
        
        
        
        CustomMethods.shared.setupButton(btnAcceptRef, AppColor.whiteColor,AppColor.themeColorDark,AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0),ConstantTexts.acceptBT)
        
        CustomMethods.shared.provideCornerRadiusTo(self.btnAcceptRef, 5,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        CustomMethods.shared.setupButton(btnDeclineRef, AppColor.textColor,AppColor.placeholderColor,AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0),ConstantTexts.declineBT)
        
        CustomMethods.shared.provideCornerRadiusTo(self.btnDeclineRef, 5,[.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        
        
        
        
    }
    
    
    @objc func onTimerFires()
    {
        lblTimer.isHidden = false
        timeLeft -= 1
        self.btnAcceptRef.backgroundColor = (timeLeft%2 == 0) ? AppColor.themeColorDark : AppColor.errorColor
        lblTimer.text = "\(timeLeft) sec left"
        
        if timeLeft <= 0 {
            stopTimer()
        }
    }
    
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
        lblTimer.isHidden = true
        timeLeft = Int()
    }
    
    
    func configureCellWith(info:NotificationDataModel){
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\(info.name)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0), AppColor.textColor))
        myMutableString.append(CustomMethods.shared.provideSimpleAttributedText(text: "\n\(info.description)", font: AppFont.semibold.size(AppFontName.SegoeUI, size: 12.0), AppColor.placeholderColor))
        
        lblTimings.text = info.createdAt
        lblDetials.numberOfLines = 0
        lblDetials.attributedText = myMutableString
        lblTimer.text = "\(timeLeft) sec left"
        
        imgProfile.sd_setImage(with: URL(string: info.profilePic), placeholderImage: UIImage(named: "profile_pic"))
        CustomMethods.shared.provideCornerRadiusTo(imgProfile, imgProfile.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        CustomMethods.shared.provideCornerBorderTo(imgProfile, 2, AppColor.whiteColor)
        
        
        /// Start **** Formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone?
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
        
        /// Start **** End Date Date
        var end_time = formatter.date(from: info.createdAt) as? Date ?? Date()
        
        /// End Date Date **** End
        
       
        var secondsFromGMT: Int { return TimeZone.current.secondsFromGMT() }
          // -7200
        
        end_time.addTimeInterval(TimeInterval(secondsFromGMT + 90))
        
        if curr_time.compare(end_time) == .orderedSame {
            print("Both dates are same")
            stopTimer()
            
        }else if curr_time.compare(end_time) == .orderedAscending {
            print("curr_time is smaller then end_time")
            
            stopTimer()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.second], from: curr_time, to: end_time)
            //START---->Count
            if let seconds = components.second{
                timeLeft = seconds
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
            }
            //Count<----END
            
        }else if curr_time.compare(end_time) == .orderedDescending {
            print("curr_time is greater then end_time")
            stopTimer()
        }
        
      
        
       
       /* if info.type == "1"{
            //timer
        }else if info.type == "2"{
            //nontimer
        } */
        
        
      /*  if curr_time == end_time {
            print("Equal\nDo nothing...")
            stopTimer()
        }
        else if curr_time > end_time {
            print("createdAt date > End date\nDo nothing...")
            stopTimer()
        }
        else if curr_time < end_time {
            print("createdAt date < End date\nStart time")
            stopTimer()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.second], from: createdAt ?? Date(), to: end_time ?? Date())
            //START---->Count
            if let seconds = components.second{
                timeLeft = seconds
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
            }
            //Count<----END
            
            
            
        } */
     
    }
    
    
}
