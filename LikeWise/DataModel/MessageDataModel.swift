//
//  MessageDataModel.swift
//  LikeWise
//
//  Created by Aman Kumar on 22/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import UIKit
class MessageDataModel {
    
    var createdAt = String()
    var message = String()
    var message_Encrypted = String()
    var read_status = String()
    var receiver_id = String()
    var room_id = String()
    var sender_id = String()
    var status = String()
    var type = String()
    var userId = String()
    var isEncryped = Bool()
    var isMatched = Bool()
    var isMe = Bool()
    var pointId = Double()
    
    var score = Double()
    var point = Double()
    var bonus = Double()
    var streaks = Double()
    var all_matched = Double()
    
    var wordCount = Int()
    
    
    init(createdAt:String,message:String,message_Encrypted:String,read_status:String,userId:String,receiver_id:String,room_id:String,sender_id:String,status:String,type:String,isMatched:Bool,isEncryped:Bool,isMe:Bool,pointId:Double,score:Double,point:Double,bonus:Double,streaks:Double,all_matched:Double,wordCount:Int) {
        
        self.createdAt = createdAt
        self.message = message
        self.message_Encrypted = message_Encrypted
        self.read_status = read_status
        self.receiver_id = receiver_id
        self.room_id = room_id
        self.sender_id = sender_id
        self.status = sender_id
        self.type = type
        self.userId = userId
        self.isEncryped = isEncryped
        self.isMatched = isMatched
        self.isMe = isMe
        self.pointId = pointId
        self.wordCount = wordCount
        
        self.score = Double()
        self.point = Double()
        self.bonus = Double()
        self.streaks = Double()
        self.all_matched = Double()
        
        
    }
}


class ParentMessageDataModeForShow{
    var Image = String()
    var card = Int()
    var MessageDataModeForShowArray = [MessageDataModeForShow]()
    init(Image:String,card:Int,MessageDataModeForShowArray:[MessageDataModeForShow]){
        self.Image = Image
        self.card = card
        self.MessageDataModeForShowArray = MessageDataModeForShowArray
    }
}



class MessageDataModeForShow{
    var _id = String()
    var game_id = String()
    var languageCode = String()
    var image = String()
    
    var createdAt = String()
    var message = String()
    var message_Encrypted = String()
    var read_status = String()
    var receiver_id = String()
    var room_id = String()
    var sender_id = String()
    var status = String()
    var type = String()
    var userId = String()
    var isEncryped = Bool()
    var isMatched = Bool()
    var isMe = Bool()
    var pointId = Double()
    
    var score = Double()
    var point = Double()
    var bonus = Double()
    var streaks = Double()
    var all_matched = Double()
    
    var wordCount = Int()
    var card = Int()
    
    init(_id:String,image:String,game_id:String,languageCode:String,createdAt:String,message:String,message_Encrypted:String,read_status:String,userId:String,receiver_id:String,room_id:String,sender_id:String,status:String,type:String,isMatched:Bool,isEncryped:Bool,isMe:Bool,pointId:Double,score:Double,point:Double,bonus:Double,streaks:Double,all_matched:Double,wordCount:Int,card:Int) {
        
        self.image = image
        self._id = _id
        self.game_id = game_id
        self.languageCode = languageCode
        
        
        self.createdAt = createdAt
        self.message = message
        self.message_Encrypted = message_Encrypted
        self.read_status = read_status
        self.receiver_id = receiver_id
        self.room_id = room_id
        self.sender_id = sender_id
        self.status = sender_id
        self.type = type
        self.userId = userId
        self.isEncryped = isEncryped
        self.isMatched = isMatched
        self.isMe = isMe
        self.pointId = pointId
        self.wordCount = wordCount
        
        self.score = score
        self.point = point
        self.bonus = bonus
        self.streaks = streaks
        self.all_matched = all_matched
        self.card = card
        
        
        
        
    }
    
    
}


class NotificationDataModel{
    var name  = String()
    var description  = String()
    
    var __v  = String()
    var _id  = String()
    var gameId = String()
    var profilePic = String()
    var receiverId = String()
    var type = String()
    var createdAt = String()
    var userId = String()
    var status = String()
    var startDate = Date()
    var endDate = Date()
    
    init(name:String,description:String,__v:String,_id:String,gameId:String,profilePic:String,createdAt:String,userId:String,receiverId:String,type:String,status:String,startDate:Date,endDate:Date){
        self.name  = name
        self.description  = description
        
        self.__v  = __v
        self._id  = _id
        self.gameId = gameId
        self.profilePic = profilePic
        self.receiverId = receiverId
        self.type = type
        self.createdAt = createdAt
        self.userId = userId
        self.status = status
        
        self.startDate = startDate
        self.endDate = endDate
    }
    
    
    
}


class CurrentGameDataModel{
    
    var _id = String()
    var description = String()
    
    var createdAt = String()
    var current_card = Int()
    var game_id = String()
    
    
    var lang_id = String()
    var lang_code = String()
    var lang_description = String()
    var lang_language = String()
    var lang_picture = String()
    var lang_status = Int()
    
    var lives = Int()
    var mode = Int()
    var morePreciselys = String()
    var name = String()
    var objectives = String()
    
    var LikeWisePersantege = Int()
    var PointTotalMatchPersantege = Int()
    var TotalMatch = Int()
    
    var profilePic = String()
    var receiver_id = String()
    var room_id = String()
    var sender_id = String()
    var user_type = Int()
    
    var common_game = String()
    init(_id:String,description:String,createdAt:String,current_card:Int,game_id:String,lang_id:String,lang_code:String,lang_description:String,lang_language:String,lang_picture:String,lang_status:Int,lives:Int,mode:Int,morePreciselys:String,name:String,objectives:String,LikeWisePersantege:Int,PointTotalMatchPersantege:Int,TotalMatch:Int,profilePic:String,receiver_id:String,room_id:String,sender_id:String,user_type:Int,common_game:String){
        
        self.description = description
        self._id = _id
        self.createdAt = createdAt
        self.current_card = current_card
        self.game_id = game_id
        
        
        self.lang_id = lang_id
        self.lang_code = lang_code
        self.lang_description = lang_description
        self.lang_language = lang_language
        self.lang_picture = lang_picture
        self.lang_status = lang_status
        
        self.lives = lives
        self.mode = mode
        self.morePreciselys = morePreciselys
        self.name = name
        self.objectives = objectives
        
        self.LikeWisePersantege = LikeWisePersantege
        self.PointTotalMatchPersantege = PointTotalMatchPersantege
        self.TotalMatch = TotalMatch
        
        self.profilePic = profilePic
        self.receiver_id = receiver_id
        self.room_id = room_id
        self.sender_id = sender_id
        self.user_type = user_type
        self.common_game = common_game
        
    }
  
}



class PlayGameUserModel{
    var All_LikeWise_Number = String()
    var All_LikeWise_Persantege = String()
    
    var _id = String()
    var gender = String()
    
    var name = String()
    var profilePic = String()
    var userValue = String()
    
    
    init(All_LikeWise_Number:String,All_LikeWise_Persantege:String,_id:String,gender:String,name:String,profilePic:String,userValue:String){
        
        self.All_LikeWise_Number = All_LikeWise_Number
        self.All_LikeWise_Persantege = All_LikeWise_Persantege
        
        self._id = _id
        self.gender = gender
        
        self.name = name
        self.profilePic = profilePic
        self.userValue = userValue
        
    }
}

class RandomImagesModel{
    var Image = String()
    var count = String()
    init(Image:String,count:String){
        
        self.Image = Image
        self.count = count
       
        
    }
}

class LeaderBoardDataModel{
    var gameCounts = Int()
    var likewisePer = Int()
    var scores = Int()
    
    var All_LikeWise_Number = String()
    var All_LikeWise_Persantege = String()
    
    var _id = String()
    var gender = String()
    
    var name = String()
    var aboutus = String()
    var profilePic = String()
    var userValue = String()
    
    var city = String()
    var coinDate = String()
    var coinStatus = Int()
    var coins = Int()
    var country = String()
    var createdAt = String()
    var defaultLangCode = String()
    var dob = String()
    var email = String()
    var interest = String()
    var languageCode = String()
    var mobileNumber = String()
    var nationalit = String()
    var notification = Int()
    var socialId = String()
    var socialType = String()
    var state = String()
    var status = Int()
    var totalPoints = Int()
    var type = Int()
    var username = String()
    
    init(gameCounts:Int,likewisePer:Int,scores:Int,All_LikeWise_Number:String,All_LikeWise_Persantege:String,_id:String,gender:String,name:String,aboutus:String,profilePic:String,userValue:String,city:String,coinDate:String,coinStatus:Int,coins:Int,country:String,createdAt:String,defaultLangCode:String,dob:String,email:String,interest:String,languageCode:String,mobileNumber:String,nationalit:String,notification:Int,socialId:String,socialType:String,state:String,status:Int,totalPoints:Int,type:Int,username:String){
        
        
        self.gameCounts = gameCounts
        self.likewisePer = likewisePer
        self.scores = scores
        
        self.All_LikeWise_Number = All_LikeWise_Number
        self.All_LikeWise_Persantege = All_LikeWise_Persantege
        
        self._id = _id
        self.gender = gender
        
        self.name = name
        self.aboutus = aboutus
        self.profilePic = profilePic
        self.userValue = userValue
        
        self.city = city
        self.coinDate = coinDate
        self.coinStatus = coinStatus
        self.coins = coins
        self.country = country
        self.createdAt = createdAt
        self.defaultLangCode = defaultLangCode
        self.dob = dob
        self.email = email
        self.interest = interest
        self.languageCode = languageCode
        self.mobileNumber = mobileNumber
        self.nationalit = nationalit
        self.notification = notification
        self.socialId = socialId
        self.socialType = socialType
        self.state = state
        self.status = status
        self.totalPoints = totalPoints
        self.type = type
        self.username = username
        
        
    }
    
}


class FriendsCommanDataModel{
    var room_id = String()
    var sender_id = String()
    var game_id = String()
    var profilePic = String()
    var receiver_id = String()
    var name = String()
    var createdAt = String()
    var user_type = Int()
    var key = String()
    var PointTotalMatchPersantege = Double()
    var count = Int()
    
    init(room_id:String,sender_id:String,game_id:String,profilePic:String,receiver_id:String,name:String,createdAt:String,user_type:Int,key:String,PointTotalMatchPersantege:Double,count:Int){
        
        
        self.room_id = room_id
        self.sender_id = sender_id
        self.game_id = game_id
        self.profilePic = profilePic
        self.receiver_id = receiver_id
        self.name = name
        self.createdAt = createdAt
        self.user_type = user_type
        self.key = key
        self.PointTotalMatchPersantege = PointTotalMatchPersantege
        self.count = count
        
    }
    
    
    
}



