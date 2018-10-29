//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    // 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    // 定义主播的模型属性
    override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            //房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }

}
