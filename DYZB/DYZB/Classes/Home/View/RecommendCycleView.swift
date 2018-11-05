//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by mac on 2018/10/30.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit
private let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {
    //定时器
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet{
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            var indexPath : IndexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            
            // 无限滚动的位置放在 i* 10 处，这样方便前滚
            collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
            
            // 添加定时器
            removeTimer()
            addTimer()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        // 设置该控件不随父控件的拉伸而拉伸,但这里没有.none的不伸缩的属性
//        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        autoresizingMask = .flexibleWidth
        // 注册cell
//        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: kCycleCellID)
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        
    }
    
    override func layoutSubviews() {
        // 设置collectionView 的layout
//        collectionView.sizeToFit()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.itemSize = collectionView.bounds.size
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kScreenWidth, height: kCycleViewHeight)
        collectionView.isPagingEnabled = true
    }

}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kCycleCellID", for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}

extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % cycleModels!.count
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}

extension RecommendCycleView {
    private func addTimer() -> Void {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    private func removeTimer() -> Void {
        // 从运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc private func scrollToNext(){
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
