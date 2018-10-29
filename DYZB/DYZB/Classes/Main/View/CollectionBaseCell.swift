//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by mac on 2018/10/29.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    // 控件的属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineButton: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel?{
        didSet{
            // 校验anchor的值
            guard let anchor = anchor else {return}
            
            // 在线人数的显示
            var onlineStr : String = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(anchor.online)"
            }
            onlineButton.setTitle(onlineStr, for: .normal)
            
            // 显示昵称
            nickNameLabel.text = anchor.nickname
            
            // 设置封面图片
            guard let iconUrl = URL(string: anchor.vertical_src) else{return}
            iconImageView.kf.setImage(with: iconUrl)
        }
    }
}
