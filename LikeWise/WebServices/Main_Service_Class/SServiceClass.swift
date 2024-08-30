//
//  EServiceClass.swift
//
//  Created by Sandeep Vishwakarma on 4/16/18.
//  Copyright © 2018 Sandeep. All rights reserved.
//

import Foundation
import Reachability
import Alamofire
import SwiftyJSON
import ObjectMapper

final class ServiceClass: SBaseService {
    
    static let shared = ServiceClass()
    
    private override init(){}
    
    func serviceJsonEncoding(url:String, method:HTTPMethod, parameters:[String:Any]?, header:[String:String]? = nil, success: @escaping (Any)-> (), failure: @escaping (Error)->()) -> Void
    {
        print(url)
        print(parameters)
        if AppReachability.sharedInstance.isReachAble == false{
            failure(NSError(domain: "",code:1000,userInfo: ["errorMessage":ConstantTexts.noInterNet]))
            return
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
    
        manager.request(URL(string: url)!, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON { response in
                switch(response.result){
                case .success(let value):
                    if let dict = value as? [String:Any]{
                        print(dict)
                        success(dict)
                    }
                    else{
                        if let jsonString = JSON(value).rawString(),
                            let responseModel = Mapper<BaseModel>().map(JSONString: jsonString) {
                            failure(NSError(domain: "",code:1000,userInfo: ["errorMessage":responseModel.message!]))
                        }
                    }
                case .failure(let error):
                    failure(error)
                }
        }
    }
    
    func multipartImageService(url:String, _ data:[Any], withName:[String], fileName:[String], mimeType:[String], header:[String:String]? = nil, parameters:[String:Any]?, success: @escaping (Any)-> (), failure: @escaping (Error)->()) -> Void
    {
        if AppReachability.sharedInstance.isReachAble == false{
            HHelper.showAlert(kNoInterNet)
            return
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.upload(multipartFormData: { (multipartFormData) in
            for (index,item) in data.enumerated() {
                var image = UIImage()
                image = item as! UIImage
                multipartFormData.append(image.jpegData(compressionQuality:  0.60)!, withName: withName[index], fileName: fileName[index], mimeType: mimeType[index])
            }
            guard let param = parameters else {
                return
            }
            for (key,value) in param {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to:URL(string: url)!, headers: header)
        { (result) in
            switch result {
            case .success(let upload, _,_ ):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseData { response in
                    upload.responseJSON {
                        (response) -> Void in
                        switch(response.result){
                        case .success(let value):
                            print(value)
                            if let dict = value as? [String:Any]{
                                success(dict)
                            }
                            else{
                                if let jsonString = JSON(value).rawString(),
                                    let responseModel = Mapper<BaseModel>().map(JSONString: jsonString) {
                                    
                                    failure(NSError(domain: "",code:1000,userInfo: ["errorMessage":responseModel.message!]))
                                }
                            }
                        case .failure(let error):
                            HHelper.showAlert(ConstantTexts.requestTimedOut)
                            failure(error)
                        }
                    }
                }
            case .failure(let error):
                HHelper.showAlert(ConstantTexts.requestTimedOut)
                failure(error)
            }
        }
    }
    
    
    
    func multipartImageServiceWithArrayObject(url:String, _ data:[Any], withName:[String], fileName:[String], mimeType:[String], header:[String:String]? = nil, parameters:[String:Any]?, success: @escaping (Any)-> (), failure: @escaping (Error)->()) -> Void {
        if AppReachability.sharedInstance.isReachAble == false {
            HHelper.showAlert(kNoInterNet)
            return
        }
        
        
        print(data.count)
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.upload(multipartFormData: { (multipartFormData) in
            for (index,item) in data.enumerated() {
                if withName[index] == "resume" {
                    let stringURL =  item as! URL
                    let filename = stringURL.lastPathComponent
                    let splitName = filename.split(separator: ".")
                    /*
                     let name = String(describing: splitName.first)
                     let filetype = String(describing: splitName.last)
                     */
                    
                    let  value = splitName.last ?? ""
                    let mime = "application/" + value
                    let pdfData = try! Data(contentsOf: stringURL )
                    let data : Data = pdfData
                    multipartFormData.append(data as Data, withName:withName[index],fileName: String(value), mimeType:mime)
                    
                } else {
                    if let data = item as? Data{
                        if let image = UIImage(data: data){
                            multipartFormData.append(image.jpegData(compressionQuality:  0.5)!, withName: withName[index], fileName: fileName[index], mimeType: mimeType[index])
                        }
                    }
                    
                    
                }
            }
            guard let param = parameters else {
                return
            }
            
            for (key, value) in param {
                if key == "url" {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                } else if key == "experience"  {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                } else if key == "education"  {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                }  else {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
        }, to:URL(string: url)!,headers: header)
        { (result) in
            switch result {
            case .success(let upload, _,_ ):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseData { response in
                    upload.responseJSON {
                        (response) -> Void in
                        switch(response.result){
                        case .success(let value):
                            print(value)
                            if let dict = value as? [String:Any]{
                                success(dict)
                            }
                            else{
                                if let jsonString = JSON(value).rawString(),
                                    let responseModel = Mapper<BaseModel>().map(JSONString: jsonString) {
                                    failure(NSError(domain: "",code:1000,userInfo: ["errorMessage":responseModel.message!]))
                                }
                            }
                        case .failure(let error):
                            HHelper.showAlert(ConstantTexts.requestTimedOut)
                            failure(error)
                        }
                    }
                }
            case .failure(let error):
                HHelper.showAlert(ConstantTexts.requestTimedOut)
                failure(error)
            }
        }
    }
    
    
    
    func multipartImageServiceWithArrayObjectNew(url:String, _ data:[Any], withName:[String], fileName:[String], mimeType:[String], header:[String:String]? = nil, parameters:[String:Any]?, success: @escaping (Any)-> (), failure: @escaping (Error)->()) -> Void {
        if AppReachability.sharedInstance.isReachAble == false {
            HHelper.showAlert(kNoInterNet)
            return
        }
        
        
        print(data.count)
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 180
        
        manager.upload(multipartFormData: { (multipartFormData) in
            for (index,item) in data.enumerated() {
                if withName[index] == "resume" {
                    let stringURL =  item as! URL
                    let filename = stringURL.lastPathComponent
                    let splitName = filename.split(separator: ".")
                    /*
                    let name = String(describing: splitName.first)
                    let filetype = String(describing: splitName.last)
                    */
                    let  value = splitName.last ?? ""
                    let mime = "application/" + value
                    let pdfData = try! Data(contentsOf: stringURL )
                    let data : Data = pdfData
                    multipartFormData.append(data as Data, withName:withName[index],fileName: String(value), mimeType:mime)
                    
                } else {
                    if let data = item as? UIImage{
                        
                        multipartFormData.append(data.jpegData(compressionQuality:  0.5)!, withName: withName[index], fileName: fileName[index], mimeType: mimeType[index])
                        
                    }
                    
                    
                }
            }
            guard let param = parameters else {
                return
            }
            
            for (key, value) in param {
                if key == "url" {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                } else if key == "experience"  {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                } else if key == "education"  {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                }  else {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
        }, to:URL(string: url)!,headers: header)
        { (result) in
            switch result {
            case .success(let upload, _,_ ):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseData { response in
                    upload.responseJSON {
                        (response) -> Void in
                        switch(response.result){
                        case .success(let value):
                            print(value)
                            if let dict = value as? [String:Any]{
                                success(dict)
                            }
                            else{
                                if let jsonString = JSON(value).rawString(),
                                    let responseModel = Mapper<BaseModel>().map(JSONString: jsonString) {
                                    failure(NSError(domain: "",code:1000,userInfo: ["errorMessage":responseModel.message!]))
                                }
                            }
                        case .failure(let error):
                            HHelper.showAlert(ConstantTexts.requestTimedOut)
                            failure(error)
                        }
                    }
                }
            case .failure(let error):
                HHelper.showAlert(ConstantTexts.requestTimedOut)
                failure(error)
            }
        }
    }
    
    
    
    
    
    func multipartImageServiceWithArrayObjectAndVideo(url:String, _ data:[Any], withName:[String], fileName:[String], mimeType:[String],_ dataVideo:[Any], withNameVideo:[String],fileNameVideo:[String],mimeTypeVideo:[String], header:[String:String]? = nil, parameters:[String:Any]?, success: @escaping (Any)-> (), failure: @escaping (Error)->()) -> Void {
        if AppReachability.sharedInstance.isReachAble == false {
            HHelper.showAlert(kNoInterNet)
            return
        }
        let header = ["Content-Type": "application/json",
                      "accept": "application/json"]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.upload(multipartFormData: { (multipartFormData) in
            for (index,item) in data.enumerated() {
                if withName[index] == "resume" {
                    let stringURL =  item as! URL
                    let filename = stringURL.lastPathComponent
                    let splitName = filename.split(separator: ".")
                    /*
                    let name = String(describing: splitName.first)
                    let filetype = String(describing: splitName.last)
                    */
                    let  value = splitName.last ?? ""
                    let mime = "application/" + value
                    let pdfData = try! Data(contentsOf: stringURL )
                    let data : Data = pdfData
                    multipartFormData.append(data as Data, withName:withName[index],fileName: String(value), mimeType:mime)
                    
                } else {
                    if let data = item as? Data{
                        print(data)
                        if let image = UIImage(data: data){
                            multipartFormData.append(image.jpegData(compressionQuality:  0.2)!, withName: withName[index], fileName: fileName[index], mimeType: mimeType[index])
                        }
                    }
                    
                    
                }
            }
            
            //TODO: For Video
            print(withNameVideo.count)
            print(fileNameVideo.count)
            print(dataVideo.count)
            print(mimeTypeVideo.count)
            
            
            for (index,item) in dataVideo.enumerated() {
                if withNameVideo[index] == "resume" {
                    let stringURL =  item as! URL
                    let filename = stringURL.lastPathComponent
                    let splitName = filename.split(separator: ".")
                    /*
                    let name = String(describing: splitName.first)
                    let filetype = String(describing: splitName.last)
                    */
                    let  value = splitName.last ?? ""
                    let mime = "application/" + value
                    let pdfData = try! Data(contentsOf: stringURL )
                    let data : Data = pdfData
                    multipartFormData.append(data as Data, withName:withNameVideo[index],fileName: String(value), mimeType:mime)
                    
                } else {
                    if let data = item as? Data{
                        multipartFormData.append(data, withName: withNameVideo[index], fileName: fileNameVideo[index], mimeType: mimeTypeVideo[index])
                        
                    }
                    
                    
                }
            }
            
            
            guard let param = parameters else {
                return
            }
            
            for (key, value) in param {
                if key == "url" {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                } else if key == "experience"  {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                } else if key == "education"  {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                }  else {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
        }, to:URL(string: url)!,headers: header)
        { (result) in
            switch result {
            case .success(let upload, _,_ ):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseData { response in
                    upload.responseJSON {
                        (response) -> Void in
                        switch(response.result){
                        case .success(let value):
                            print(value)
                            if let dict = value as? [String:Any]{
                                success(dict)
                            }
                            else{
                                if let jsonString = JSON(value).rawString(),
                                    let responseModel = Mapper<BaseModel>().map(JSONString: jsonString) {
                                    failure(NSError(domain: "",code:1000,userInfo: ["errorMessage":responseModel.message!]))
                                }
                            }
                        case .failure(let error):
                            HHelper.showAlert(ConstantTexts.requestTimedOut)
                            failure(error)
                        }
                    }
                }
            case .failure(let error):
                HHelper.showAlert(ConstantTexts.requestTimedOut)
                failure(error)
            }
        }
    }
    
    
    
    //TODO: For requesting post types url
    /*  func postRequestURLFormData(_ strURL : String, params : [String : AnyObject]!, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
     let urlString = baseURL + (strURL as String)
     print(urlString)
     let urlValue = URL(string: urlString)!
     var request = URLRequest(url: urlValue)
     request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
     
     Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { response in
     switch response.result {
     case .success:
     if let value = response.result.value {
     print(value)
     self.responseCode = 1
     let resJson = JSON(response.result.value!)
     success(resJson)
     }
     case .failure(let error):
     print(error)
     self.responseCode = 2
     let error : Error = response.result.error!
     failure(error)
     }
     }
     } */
    
}

