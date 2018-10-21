//
//  UIBarButtonItem-extension.swift
//  DYZB
//
//  Created by mac on 2018/10/11.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    /*
    // 创建一个UIBarButtonItem 类方法实现
    class func createItem(imageName:String, highlightedImageName:String, size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named: highlightedImageName), for: UIControlState.highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        let item = UIBarButtonItem(customView: btn)
        return item
    }*/
    
    // 便利构造函数 必须使用convenience关键字，并用self调用内部的构造方法
    convenience init(imageName:String, highlightedImageName:String = "", size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        if highlightedImageName != "" {
            btn.setImage(UIImage(named: highlightedImageName), for: UIControlState.highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
