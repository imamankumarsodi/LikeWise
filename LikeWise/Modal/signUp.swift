//
//  signUp.swift
//  LikeWise
//
//  Created by cst on 12/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import RealmSwift

class UserDataModel:Object{
    
    @objc dynamic var __v = String()
    @objc dynamic var _id = String()
    @objc dynamic var coinStatus = Double()
    @objc dynamic var coins = Double()
    @objc dynamic var dob = String()
    @objc dynamic var email = String()
    @objc dynamic var jwtToken = String()
    @objc dynamic var languageCode = String()
    @objc dynamic var name = String()
    @objc dynamic var notificationStatus = String()
    @objc dynamic var profilePic = String()
    @objc dynamic var status = String()
    @objc dynamic var totalPoints = Double()
    @objc dynamic var username = String()
    @objc dynamic var type = String()
    
    @objc dynamic var country = String()
    @objc dynamic var defaultLangCode = String()
    @objc dynamic var interest1 = String()
    @objc dynamic var interest2 = String()
    @objc dynamic var interest3 = String()
    @objc dynamic var nationalit = String()
    @objc dynamic var state = String()

    @objc dynamic var aboutus = String()
    @objc dynamic var city = String()
    @objc dynamic var interest = String()
    @objc dynamic var gender = String()
    @objc dynamic var password = String()
    @objc dynamic var descriptionUser = String()
  
}


