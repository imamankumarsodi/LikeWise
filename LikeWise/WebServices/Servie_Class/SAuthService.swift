//
//  SAuthService.swift
//  LikeWise
//
//  Created by cst on 12/03/20.
//  Copyright © 2020 cst. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit
import ObjectMapper
import XCGLogger

class SAuthService: SBaseService {
    func formDataService(_ data:[Any],withName: [String] ,fileName:[String],mimeType:[String],parameters:[String:Any]?,serviceName:String,header:[String:String]?) -> Promise<SAuthModel> {
        return Promise { seal in
            
            print(parameters)
            ServiceClass.shared.multipartImageServiceWithArrayObjectNew(url: SBaseService().getServiceHostURL() + serviceName, data, withName: withName, fileName: fileName, mimeType: mimeType, header:header, parameters: parameters, success: { (data) in
                
                if let dict = data as? [String:Any],
                    let status = dict["responseCode"] as? Int,
                    status == 200 {
                    if let dict = data as? [String:Any],
                        let model = Mapper<SAuthModel>().map(JSON: dict){
                        seal.fulfill(model)
                    }
                    else{
                        seal.reject(NSError(domain: ConstantTexts.AppName,code:1000,userInfo: ["errorMessage":ConstantTexts.requestTimedOut]))
                    }
                }else{
                    if let dict = data as? [String:Any],
                        let message = dict["message"] as? String{
                        seal.reject(NSError(domain: ConstantTexts.AppName,code:200 ,userInfo: ["errorMessage":message]))
                    }
                }
            }, failure: { (error) in
                seal.reject(NSError(domain: ConstantTexts.AppName,code:1000,userInfo: ["errorMessage":ConstantTexts.requestTimedOut]))
            })
        }
    }
    
    
    
    
    
    
    
    
    //MARK: for get type api
    func getTypeService(serviceName:String,header:[String:String]?) -> Promise<SAuthModel> {
        print(serviceName)
        // http://justclubbing.com:3012/api/v1/user/checkEmail?email=abhishekarya8055@gmail.com
        return Promise { seal in
            ServiceClass.shared.serviceJsonEncoding(url: SBaseService().getServiceHostURL() + serviceName, method: .get, parameters: nil, header:header, success: { (data) in
                
                if let dict = data as? [String:Any],
                    let status = dict["responseCode"] as? Int,
                    status == 200 {
                    if let dict = data as? [String:Any],
                        let model = Mapper<SAuthModel>().map(JSON: dict){
                        seal.fulfill(model)
                    }
                    else{
                        seal.reject(NSError(domain: ConstantTexts.AppName,code:1000,userInfo: ["errorMessage":ConstantTexts.requestTimedOut]))
                    }
                }else{
                    if let dict = data as? [String:Any],
                        let message = dict["message"] as? String{
                        
                        if serviceName == "dailyCheckCoin" {
                            print("No error")
                        }else{
                             seal.reject(NSError(domain: ConstantTexts.AppName,code:200 ,userInfo: ["errorMessage":message]))
                        }
                        
                      
                        
                    }
                }
            }, failure: { (error) in
                seal.reject(NSError(domain: ConstantTexts.AppName,code:1000,userInfo: ["errorMessage":ConstantTexts.requestTimedOut]))
            })
        }
    }
    
    
    
    func postService(parameters:[String:Any]?,serviceName:String,header:[String:String]?) -> Promise<SAuthModel> {
        print(parameters)
        return Promise { seal in
            ServiceClass.shared.serviceJsonEncoding(url: SBaseService().getServiceHostURL() + serviceName, method: .post, parameters: parameters, header:header, success: { (data) in
                
                
                
                if let dict = data as? [String:Any],
                    let status = dict["responseCode"] as? Int,
                    status == 200 {
                    if let dict = data as? [String:Any],
                        let model = Mapper<SAuthModel>().map(JSON: dict){
                        seal.fulfill(model)
                    }
                    else{
                        seal.reject(NSError(domain: ConstantTexts.AppName,code:1000,userInfo: ["errorMessage":ConstantTexts.requestTimedOut]))
                    }
                }else{
                    if let dict = data as? [String:Any],
                        let message = dict["message"] as? String{
                        
                        if serviceName == "getFindPatner" {
                            
                            let statusT = dict["responseCode"] as? Int
                            if statusT == 406 {
                                if let dict = data as? [String:Any],
                                    let model = Mapper<SAuthModel>().map(JSON: dict){
                                    seal.fulfill(model)
                                }
                            }else{
                                seal.reject(NSError(domain: ConstantTexts.AppName,code:200 ,userInfo: ["errorMessage":message]))
                            }
                            
                        }else{
                           seal.reject(NSError(domain: ConstantTexts.AppName,code:200 ,userInfo: ["errorMessage":message]))
                        }
                        
                    }
                }
            }, failure: { (error) in
                seal.reject(NSError(domain: ConstantTexts.AppName,code:1000,userInfo: ["errorMessage":ConstantTexts.requestTimedOut]))
            })
        }
    }
    
}
