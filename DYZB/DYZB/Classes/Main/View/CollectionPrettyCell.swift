//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var cityButton: UIButton!
    // 定义主播的模型属性
    override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            //所在城市
            cityButton.setTitle(anchor?.anchor_city, for: .normal)
        }
    }



}
