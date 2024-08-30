//
//  BaseModel.swift
//
//  Created by Sandeep Vishwakarma on 4/16/18.
//  Copyright © 2018 Sandeep. All rights reserved.
//


import Foundation
import ObjectMapper

class BaseModel : Mappable {
    
    var status: Int?
    var message: String?
    var result:Any?
    var error: ErrorModel?
    
    required init?(map: Map) {
        
    }
    
    init(){
        
    }
    
    func mapping(map: Map) {
        status <- map["status_code"]
        result <- map["result"]
        error <- map["error"]
    }
}

class ErrorModel : Mappable {
    
    var errorCode: Int?
    var message:String?
    
    required init?(map: Map) {
        
    }
    
    init(){
        
    }
    
    func mapping(map: Map) {
        errorCode <- map["errorCode"]
        message <- map["message"]
    }
}
