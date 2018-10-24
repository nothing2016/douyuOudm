//
//  RecommendViewController.swift
//  DYZB
//
//  Created by mac on 2018/10/22.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kItemWidth : CGFloat = ( kScreenWidth - 3*kItemMargin )/2
private let kNormalItemHeight : CGFloat = kItemWidth * 3/4
private let kPrettyItemHeight : CGFloat = kItemWidth * 4/3
private let kNormalID : String = "kNormalID"
private let kPrettyID : String = "kPrettyID"
private let kHeaderID : String = "kHeaderID"
private let kHeaderViewHeight : CGFloat = 50
class RecommendViewController: UIViewController {

    // 懒加载属性
    private lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.先创建布局
        var collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        collectionViewLayout.minimumLineSpacing = 1
        collectionViewLayout.minimumInteritemSpacing = kItemMargin
        collectionViewLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewHeight)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建collectionView
        var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyID)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)
        collectionView.delegate = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension RecommendViewController {
    private func setupUI() -> Void {
        view.addSubview(collectionView)
    }
}

extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 12
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.定义cell
        let cell : UICollectionViewCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kPrettyItemHeight)
        }else {
            return CGSize(width: kItemWidth, height: kNormalItemHeight)
        }
    }
}
