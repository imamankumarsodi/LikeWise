//
//  SelectLangugeDataModel.swift
//  LikeWise
//
//  Created by Deepti Sharma on 20/02/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit


class getUserDetail {
    var _id = String()
    var code = String()
    var description = String()
    var language = String()
    var picture = String()
    var status = String()
    var isSelected = Bool()
    
    init(_id:String,code:String,description:String,language:String,picture:String,status:String,isSelected:Bool){
        
        self._id = _id
        self.code = code
        self.description = description
        self.language = language
        self.picture = picture
        self.status = status
        self.isSelected = isSelected
    }
    
}

class CountryDataModelMain {
    
    var title = String()
    var array = [CountryDataModel]()
    init(title:String,array:[CountryDataModel]){
        
        self.title = title
        self.array = array
    }
}



class CountryDataModel {
    
    var picture = String()
    var _id = String()
    var code = String()
    var description = String()
    var language = String()
    var __v = String()
    var isSelected = Bool()
    
    init(picture:String,_id:String,code:String,description:String,language:String,__v:String,isSelected:Bool){
        self.picture = picture
        self._id = _id
        self.code = code
        self.description = description
        self.language = language
        self.__v = __v
        self.isSelected = isSelected
    }
}


class GetCoinsDataModel {
    var _id = String()
    var image = UIImage()
    var coins = String()
    var price = String()
    
    var coinsInt = Int()
    var priceInt = Int()
    
    init(_id:String,image:UIImage,coins:String,price:String,coinsInt:Int,priceInt:Int){
        self._id = _id
        self.image = image
        self.coins = coins
        self.price = price
        self.coinsInt = coinsInt
        self.priceInt = priceInt
    }
}


class CountryDataModelCollec {
    
    
    var __v = String()
    var _id = String()
    var coinStatus = String()
    var coins = String()
    var dob = String()
    var email = String()
    var jwtToken = String()
    var languageCode = String()
    var name = String()
    var notificationStatus = String()
    var profilePic = String()
    var status = String()
    var totalPoints = String()
    var username = String()
    var type = String()
    
    var country = String()
    var defaultLangCode = String()
    
    var nationalit = String()
    var state = String()
    
    var aboutus = String()
    var city = String()
    var interest = String()
    var gender = String()
    var password = String()
    var descriptionUser = String()
    var socialId = String()
    var isSelected = Bool()
    
    init(__v:String,_id:String,coinStatus:String,dob:String,email:String,jwtToken:String,languageCode:String,name:String,notificationStatus:String,profilePic:String,status:String,totalPoints:String,username:String,type:String,country:String,defaultLangCode:String,nationalit:String,state:String,aboutus:String,city:String,interest:String,gender:String,password:String,descriptionUser:String,socialId:String,isSelected:Bool,coins:String){
        self.__v = __v
        self._id = _id
        self.coins = coins
        self.coinStatus = coinStatus
        self.dob = dob
        self.email = email
        self.jwtToken = jwtToken
        self.languageCode = languageCode
        self.name = name
        self.notificationStatus = notificationStatus
        self.profilePic = profilePic
        self.status = status
        self.totalPoints = totalPoints
        self.username = username
        self.type = type
        
        self.country = country
        self.defaultLangCode = defaultLangCode
        
        self.nationalit = nationalit
        self.state = state
        
        self.aboutus = aboutus
        self.city = city
        self.interest = interest
        self.gender = gender
        self.password = socialId
        self.socialId = password
        self.descriptionUser = descriptionUser
        self.isSelected = isSelected
    }
    
    
    
    
    
}


class CountryDataModelCollecSelected {
    var selected_image = UIImage()
    var unselected_image = UIImage()
    var title = String()
    var titleSub = String()
    var isSelected = Bool()
    init(selected_image:UIImage,unselected_image:UIImage,title:String,titleSub:String,isSelected:Bool){
        self.selected_image = selected_image
        self.unselected_image = unselected_image
        self.title = title
        self.isSelected = isSelected
        self.titleSub = titleSub
        
    }
    
}


class MorePreciselyDataModel {
    
    var title = String()
    var isSelected = Bool()
    init(title:String,isSelected:Bool){
        
        self.title = title
        self.isSelected = isSelected
        
    }
    
    
    
}



class SettingsDataModel {
    
    var title = String()
    var subtitle = String()
    var isSelected = Bool()
    var isHidden = Bool()
    init(title:String,subtitle:String,isSelected:Bool,isHidden:Bool){
        
        self.title = title
        self.subtitle = subtitle
        self.isSelected = isSelected
        self.isHidden = isHidden
        
    }
    
}


class FAQDataModel {
    
    var title = String()
    var subtitle = String()
    var isSelected = Bool()
    init(title:String,subtitle:String,isSelected:Bool){
        
        self.title = title
        self.subtitle = subtitle
        self.isSelected = isSelected
        
    }
    
}



class LanguageDataModel {
    
    var __v  = String()
    var _id  = String()
    var code = String()
    var createdAt = String()
    var description = String()
    var language = String()
    var picture = String()
    var status = String()
    var isSelected = Bool()
    
    init(__v:String,_id:String,code:String,createdAt:String,description:String,language:String,picture:String,status:String,isSelected:Bool){
        self.__v  = __v
        self._id  = _id
        self.code = code
        self.createdAt = createdAt
        self.description = description
        self.language = language
        self.picture = picture
        self.status = status
        self.isSelected = isSelected
    }
}



class Objective{
    
    var __v  = String()
    var _id  = String()
    var explanation = String()
    var createdAt = String()
    var pictureSelected = String()
    var pictureUnSelected = String()
    var MorereciselyArray = [Morerecisely]()
    var isSelected = Bool()
    init(__v:String,_id:String,explanation:String,createdAt:String,pictureSelected:String,pictureUnSelected:String,MorereciselyArray:[Morerecisely],isSelected:Bool){
        self.__v  = __v
        self._id  = _id
        self.explanation = explanation
        self.createdAt = createdAt
        self.pictureSelected = pictureSelected
        self.pictureUnSelected = pictureUnSelected
        self.MorereciselyArray = MorereciselyArray
        self.isSelected = isSelected
    }
    
    
}

class Morerecisely {
    var __v  = String()
    var _id  = String()
    var converse = String()
    var createdAt = String()
    var explanation_id = String()
    var isSelected = Bool()
    
    
    init(__v:String,_id:String,converse:String,createdAt:String,explanation_id:String,isSelected:Bool){
        self.__v  = __v
        self._id  = _id
        self.converse = converse
        self.createdAt = createdAt
        self.explanation_id = explanation_id
        self.isSelected = isSelected
    }
    
}

class selectImage{
    var _id  = String()
    var images  = String()
    var themeName  = String()
    var image = UIImage()
    var withName = String()
    var fileName = String()
    var mimeType = String()
    var isSelected = Bool()
    
    init(_id:String,images:String,themeName:String,image:UIImage,isSelected:Bool,withName:String,fileName:String,mimeType:String){
        self._id  = _id
        self.images  = images
        self.themeName  = themeName
        self.image = image
        self.withName  = withName
        self.fileName  = fileName
        self.mimeType  = mimeType
        self.isSelected = isSelected
    }
    
}
