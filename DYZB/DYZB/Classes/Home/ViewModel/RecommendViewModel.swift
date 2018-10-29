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
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    private lazy var hotGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    func requestData(finishCallback:@escaping ()->()) -> Void {
        // 创建dispatch_group，用于控制异步线程的同步
        let dispatchGroup = DispatchGroup()
        // 1.请求推荐数据
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1540608855
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom?limit=2&offset=0&time=\(NSDate.getCurrentSecondTime())") { (result) in
            //            print(result)
            // 1.将字典转化成字典类型
            guard let resultDic = result as? [String:NSObject] else {return}
            // 2.根据data的key获取值
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}
            
            self.hotGroup.tag_name = "热门"
            self.hotGroup.icon_url = "home_header_hot"
            // 3.便利字典数组，将数据变成模型对象
            for dict in dataArray {
                self.hotGroup.anchors.append(AnchorModel(dic: dict))
            }
//            for anchor in hotGroup.anchors {
//                print("---------\(anchor.nickname)------\(anchor.anchor_city)")
//            }
            dispatchGroup.leave()
            print("请求到了0的数据")
        }
        // 2.请求颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=2&offset=0&time=1540608855
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=2&offset=0&time=\(NSDate.getCurrentSecondTime())") { (result) in
            //            print(result)
            // 1.将字典转化成字典类型
            guard let resultDic = result as? [String:NSObject] else {return}
            // 2.根据data的key获取值
            guard let dataArray = resultDic["data"] as? [[String:NSObject]] else {return}
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_url = "home_header_phone"
            // 3.便利字典数组，将数据变成模型对象
            for dict in dataArray {
                self.prettyGroup.anchors.append(AnchorModel(dic: dict))
            }
//            for anchor in prettyGroup.anchors {
//                print("---------\(anchor.nickname)------\(anchor.anchor_city)")
//            }
            dispatchGroup.leave()
            print("请求到了1的数据")
        }
        
    
        
        // 3.请求游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=2&offset=0&time=1540608855
        dispatchGroup.enter()
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
            
//            for group in self.anchorGroups {
//                print(group.tag_name)
//                for anchor in group.anchors {
//                    print("---------\(anchor.nickname)")
//                }
//            }
            dispatchGroup.leave()
            print("请求到了2-12的数据")
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            print("请求到了所有的数据")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.hotGroup, at: 0)
            finishCallback()
        }))

   
    }
}
