//
//  NetworkTools.swift
//  HelloWorld
//
//  Created by mac on 2018/10/27.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}
class NetworkTools {
    class func requestData(type:MethodType, urlString:String,parameters:[String: Any]? = nil, finishedCallback: @escaping (_ result:Any)->()) {
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            guard let result = response.value else{
                print(response.error)
                return
            }
            finishedCallback(result)
//            print(result)
        
        }
    }
}
