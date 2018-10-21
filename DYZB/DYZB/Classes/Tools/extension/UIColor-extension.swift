//
//  UIColor-extension.swift
//  DYZB
//
//  Created by mac on 2018/10/14.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: green/255.0, alpha: 1.0)
    }
}
