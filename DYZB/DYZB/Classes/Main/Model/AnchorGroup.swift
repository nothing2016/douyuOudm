//
//  AnchorGroup.swift
//  DYZB
//
//  Created by mac on 2018/10/27.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
// 主播组的model
class AnchorGroup: NSObject {
    // 该组对应的房间的list
    var room_list : [[String : NSObject]]?
    // 显示该组的标题
    var tag_name : String = ""
    //组显示的图标
    var icon_url : String = "home_header_normal"
    // 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        super.init()
    }
    
    init(dict : [String : NSObject]) {
        super.init()
//        self.room_list = dict["room_list"] as? [[String : NSObject]]
//        self.tag_name = dict["tag_name"] as! String
//        self.icon_name = dict["icon_url"] as! String
        setValuesForKeys(dict)  //使用该方法无效，暂时自己解析
    }
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String : NSObject]] {
                for dic in dataArray {
                    anchors.append(AnchorModel(dic: dic))
                }
            }
        }
        if key == "tag_name" {
            if let tag_name_str = value as? String {
                tag_name = tag_name_str
            }else{
                tag_name = ""
            }
        }
        if key == "icon_url" {
            if let icon_url_str = value as? String {
                icon_url = icon_url_str
            }else{
                icon_url = "home_header_normal"
            }
        }
    }
}
