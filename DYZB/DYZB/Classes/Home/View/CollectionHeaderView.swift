//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by mac on 2018/10/22.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionHeaderView: UICollectionReusableView {

    // 控件属性
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // 定义模型group属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            var imageName = group?.icon_url ?? "home_header_normal"
            if "home_header_hot" == imageName || "home_header_normal" == imageName || "home_header_phone" == imageName {
                iconImageView.image = UIImage(named: imageName)
            }else{
                let url = URL(string: imageName)
                iconImageView.kf.setImage(with: url)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
