//
//  AnchorModel.swift
//  DYZB
//
//  Created by mac on 2018/10/27.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    // 房间ID
    var room_id : Int = 0
    // 房间图片对应的url地址
    var vertical_src : String = ""
    // 是电脑还是手机直播
    // 1:手机直播，0：电脑直播
    var isVertical : Int = 0
    // 房间名称
    var room_name : String = ""
    // 主播昵称
    var nickname : String = ""
    // 在线人数
    var online : Int = 0
    // 主播城市
    var anchor_city : String = ""
 
    init(dic : [String : NSObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_id" {
            if let room_id_str = value as? String {
                room_id = Int(room_id_str)!
            }else{
                room_id = 0
            }
        }
        if key == "vertical_src" {
            if let vertical_src_str = value as? String{
                vertical_src = vertical_src_str
            }else{
                vertical_src = ""
            }
        }
        if key == "isVertical" {
            if let isVertical_Int = value as? Int{
                isVertical = isVertical_Int
            }else{
                isVertical = 0
            }
        }
        if key == "room_name" {
            if let room_name_str = value as? String{
                room_name = room_name_str
            }else{
                room_name = ""
            }
        }
        if key == "nickname" {
            if let nickname_str = value as? String{
                nickname = nickname_str
            }else{
                nickname = ""
            }
        }
        if key == "online" {
            if let online_Int = value as? Int{
                online = online_Int
            }else{
                if let online_Str = value as? String {
                    online = Int(online_Str) ?? 0
                }
            }
        }
        if key == "anchor_city" {
            if let anchor_city_str = value as? String {
                anchor_city = anchor_city_str
            }else{
                anchor_city = ""
            }
        }
    }
}
