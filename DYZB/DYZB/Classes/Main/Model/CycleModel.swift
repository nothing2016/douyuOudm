//
//  CycleModel.swift
//  DYZB
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    var title : String = ""
    // 图片地址
    var pic_url : String = ""
    // 主播对于的字典
    var room : [String : NSObject]?{
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dic: room)
        }
    }
    // 主播对于的模型对象
    var anchor : AnchorModel?
    
    init(dic : [String : NSObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
    override func setValue(_ value: Any?, forKey key: String) {

        if key == "title" {
            if let title_str = value as? String{
                title = title_str
            }else{
                title = ""
            }
        }
        if key == "pic_url" {
            if let pic_url_str = value as? String{
                pic_url = pic_url_str
            }else{
                pic_url = ""
            }
        }
        if key == "room" {
            if let roomDic = value as? [String : NSObject] {
                anchor = AnchorModel(dic: roomDic)
            }
        }
        
    }
}
