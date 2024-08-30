//
//  Api Utility.swift
//  
//
//  Created by Mahapool on 11/14/18.
//

import UIKit
import Alamofire

//let baseURL = "http://18.224.114.141:8000/mobile/"
let baseURL = "http://3.128.167.18:8000/mobile/"
class Connect: NSObject {
    class func sendRequest(urlPath:String, type:HTTPMethod, parms:Parameters?, success:((_ responseObject:[String : Any],_ suces:Bool)->Void)!, faliure:((_ errCode:Int,_ errorMessage:String)->Void)!) {
        
        let headers:HTTPHeaders! = [:]
        
        let requestURL:URLConvertible = baseURL + urlPath
        
        print(requestURL)
        if !Connect.networkConnected() {
            faliure(-1009,"No Internet Connection.")
            return
        }
        else{     Alamofire.request(requestURL, method:type, parameters:parms, encoding: URLEncoding.default, headers:headers).responseJSON { (response) in
                if let responseObj:[String:Any] = response.value as? [String : Any] {
                    if response.response?.statusCode == 200 {
                        print(responseObj.values)
                        success(responseObj,true)
                        print(responseObj.values)
                    }
                    else {
                        print("error response value \(String(describing: response.value))")
                        if responseObj.keys.contains("message") {
                            if let responseCode : Int = responseObj["code"] as? Int {
                                faliure(responseCode, responseObj["message"] as! String)
                            }
                            else {
                                faliure(500, responseObj["message"] as! String)
                            }
                        }
                        else if responseObj.keys.contains("error") {
                            faliure(responseObj["code"] as! Int, responseObj["error"] as! String)
                        }
                        else {
                        }
                    }
                }
                else {
                    faliure(500,"SomethingWrong")
                }
            }
        }
    }

    class func uploadImage(urlPath:String, parms:Parameters?,image: UIImage, success:((_ responseObject:[String : Any],_ suces:Bool)->Void)!, faliure:((_ errCode:Int,_ errorMessage:String)->Void)!) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(image.pngData()!, withName: "photo", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            for (key, value) in parms! {
                if let data = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: baseURL + urlPath) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                   print(response)
                    if let responseObj:[String:Any] = response.value as? [String : Any] {
                        if response.response?.statusCode == 200 {
                            print(responseObj.values)
                            success(responseObj,true)
                            print(responseObj.values)
                        }
                        else {
                            print("error response value \(String(describing: response.value))")
                            if responseObj.keys.contains("message") {
                                if let responseCode : Int = responseObj["code"] as? Int {
                                    faliure(responseCode, responseObj["message"] as! String)
                                }
                                else {
                                    faliure(500, responseObj["message"] as! String)
                                }
                            }
                            else if responseObj.keys.contains("error") {
                                faliure(responseObj["code"] as! Int, responseObj["error"] as! String)
                            }
                            else {
                            }
                        }
                    }
                    else {
                        faliure(500,"SomethingWrong")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
   class func networkConnected() -> Bool {
    return (NetworkReachabilityManager()?.isReachable)!
    }
}


