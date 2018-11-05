//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var cycleModel:CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            // 设置封面图片
            guard let iconUrl = URL(string: cycleModel?.pic_url ?? "Img_default") else{return}
//            iconImageView.kf.setImage(with: iconUrl)
            iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "Img_default"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
