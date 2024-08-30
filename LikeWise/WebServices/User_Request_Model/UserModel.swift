//
//  UserModel.swift
//  AlkingStoreDealler
//
//  Created by Aman on 24/08/19.
//  Copyright © 2019 Hephaestus. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


class SAuthModel: Mappable {
   
    var status:      String?
    var statusInt:   Int?
    var data:        String?
    var message:     String?
    var authToken:   String?
    var result:      UserModel?
    var resultDict:  NSDictionary?
    var resultArray: NSArray?
    var countryList: NSArray?
    var played:      Int?
    var accuracy:    Int?
    var rank:        Int?
    var patners:     Int?
    var wordCount:   Int?
    var created:     Int?
    var mode:        Int?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        played       <- map["played"]
        accuracy     <- map["accuracy"]
        rank         <- map["rank"]
        patners      <- map["patners"]
        wordCount    <- map["wordCount"]
        created      <- map["created"]
        mode         <- map["mode"]
        
        
        status       <- map["status"]
        statusInt    <- map["status"]
        data         <- map["data"]
        result       <- map["data"]
        resultDict   <- map["data"]
        resultArray  <- map["data"]
        message      <- map["message"]
        authToken    <- map["authToken"]
        countryList  <- map["countryList"]

        
    }
}



class UserModel: Mappable {
    
    var game_id,receiver_id,sender_id,email,username,name,password,deviceType,deviceToken,type,socialId,socialType,profilePic,mobileNumber,gender,aboutus,nationalit,defaultLangCode,state,city,interest,country,dob,notification,message,mode,customInstruction,morePrecisely,objective,languageCode,room_id,id,gameType:String?
    var otp:Int?
    var notificationBool,statusBool,room_status:Bool?
    var languageAny : [String]?
    var countryList,Morerecisely,Objective,fbFriends,laguage : NSArray?

    required init?(map: Map) {
        
    }
    
    init(){
        
    }
    
   
    
    func mapping(map: Map) {
        gameType            <- map["gameType"]
        id                  <- map["id"]
        room_id             <- map["room_id"]
        statusBool          <- map["status"]
        sender_id           <- map["sender_id"]
        receiver_id         <- map["receiver_id"]
        game_id             <- map["game_id"]
        languageCode        <- map["languageCode"]
        morePrecisely       <- map["morePrecisely"]
        objective           <- map["objective"]
        customInstruction   <- map["customInstruction"]
        mode                <- map["mode"]
        Morerecisely        <- map["Morerecisely"]
        Objective           <- map["Objective"]
        fbFriends           <- map["fbFriends"]
        laguage             <- map["laguage"]
        countryList         <- map["countryList"]
        message             <- map["message"]
        notificationBool    <- map["notification"]
        notification        <- map["notification"]
        languageAny         <- map["languageCode"]
        email               <- map["email"]
        username            <- map["username"]
        name                <- map["name"]
        password            <- map["password"]
        deviceType          <- map["deviceType"]
        deviceToken         <- map["deviceToken"]
        type                <- map["type"]
        socialId            <- map["socialId"]
        socialType          <- map["socialType"]
        profilePic          <- map["profilePic"]
        mobileNumber        <- map["mobileNumber"]
        gender              <- map["gender"]
        aboutus             <- map["aboutus"]
        dob                 <- map["dob"]
        nationalit          <- map["nationalit"]
        defaultLangCode     <- map["defaultLangCode"]
        state               <- map["state"]
        city                <- map["city"]
        interest            <- map["interest"]
        country             <- map["country"]



    }
}


