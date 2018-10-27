//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by mac on 2018/10/27.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Alamofire

class RecommendViewModel{
    // 懒加载属性
    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()

}

extension RecommendViewModel {
    func requestData() -> Void {
        // 1.请求推挤数据
        
        // 2.请求颜值数据
        
        // 3.请求游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=2&offset=0&time=1540608855
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate?limit=2&offset=0&time=\(NSDate.getCurrentSecondTime())") { (result) in
//            print(result)
            // 1.将字典转化成字典类型
            guard let resultDic = result as? [String:NSObject] else {return}
            // 2.根据data的key获取值
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}
            // 3.便利字典数组，将数据变成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups {
                print(group.tag_name)
                for anchor in group.anchors {
                    print("---------\(anchor.nickname)")
                }
            }
            
        }
   
    }
}
