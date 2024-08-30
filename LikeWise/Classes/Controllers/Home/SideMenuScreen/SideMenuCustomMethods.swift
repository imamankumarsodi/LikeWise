//
//  SideMenuCustomMethods.swift
//  LikeWise
//
//  Created by Aman Kumar on 28/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import SDWebImage
import RealmSwift

// MARK: - Custom Methods
extension SideMenuVC {
    func initiallizers() {
        
        self.view.backgroundColor = AppColor.whiteColor
        tblVw.registerMultiple(nibs: [SideMenuCell.className])
        tblVw.hideEmptyCells()
        tblVw.separatorStyle = .singleLine
        tblVw.backgroundColor = AppColor.whiteColor
        tblVw.separatorInset.left = 70
        tblVw.isScrollEnabled = false
        
        CustomMethods.shared.provideCornerRadiusTo(self.imgUser, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        imgUser.contentMode = .scaleAspectFill
        
        lblName.font = AppFont.semibold.size(AppFontName.SegoeUI, size: 15.0)
        lblName.textColor = AppColor.textColor
        getUserData()
        
    }
}


//MARK:- retriving data from realm
extension SideMenuVC{
    func getUserData(){
         let realm = try! Realm()
        do{
            if let user = realm.objects(UserDataModel.self).first{
                self.lblName.text = user.name
                self.imgUser.sd_setImage(with: URL(string: user.profilePic), placeholderImage: UIImage(named: "profile_pic"))
            }
         }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }
}
