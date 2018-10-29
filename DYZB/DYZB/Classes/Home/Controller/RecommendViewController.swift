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
    private lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
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
        // 1.设置UI界面
        setupUI()
        
        // 2.发送网络请求数据
        loadData()
    }
}

// 设置界面内容
extension RecommendViewController {
    private func setupUI() -> Void {
        view.addSubview(collectionView)
    }
}

// 发送网络请求
extension RecommendViewController {
    func loadData() -> Void {
        recommendViewModel.requestData {
            self.collectionView.reloadData()
        }
    }
}

extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recommendViewModel.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 取出对象模型
        let group = recommendViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        let cell : CollectionBaseCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath) as! CollectionPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! CollectionHeaderView
        
        // 取出模型
        headerView.group = recommendViewModel.anchorGroups[indexPath.section]
        
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
