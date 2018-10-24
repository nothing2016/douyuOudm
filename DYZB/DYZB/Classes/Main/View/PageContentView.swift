//
//  PageContentView.swift
//  DYZB
//
//  Created by mac on 2018/10/14.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

let ContentCellID = "ContentCellID"
protocol PageContentViewDelegate : class {
    func pageContentView(pageContentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int) -> Void
}
class PageContentView: UIView {
    // 自定义属性
    private var childViewControllers : [UIViewController]
    // 使用弱引用，防止循环引用内存泄露
    private weak var parentViewController : UIViewController?
    weak var delegate : PageContentViewDelegate?
    // 左右滑动的偏移量
    
    private var startContentOffsetX : CGFloat!
    private var isForbidScrollDelegate : Bool = false
    // 懒加载属性
    private lazy var collectionView : UICollectionView = { [weak self] in
        // 先创建layout
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建collectionView
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    // 自定义构造函数
    init(frame: CGRect, childViewControllers:[UIViewController], parentViewController:UIViewController?) {
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    private func setupUI() -> Void {
        // 1. 将所有子控制器加到父控制器中
        for childViewController in childViewControllers {
            parentViewController?.addChildViewController(childViewController)
        }
        
        // 添加UIcollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// 遵循UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.  创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let chilViewController = childViewControllers[indexPath.item]
        chilViewController.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(chilViewController.view)
        return cell
    }
}

// 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startContentOffsetX = scrollView.contentOffset.x
        isForbidScrollDelegate = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {return}
        
        // 定义需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        
        if currentOffsetX > startContentOffsetX {
            // 左滑
            progress = currentOffsetX/scrollViewWidth - floor(currentOffsetX/scrollViewWidth)
            // 计算sourceIndex
            sourceIndex = Int(currentOffsetX/scrollViewWidth)
            // 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childViewControllers.count {
                targetIndex = childViewControllers.count - 1
            }
            // 如果完全滑过去
            if currentOffsetX - startContentOffsetX == scrollViewWidth {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            // 右滑
            progress = 1 - (currentOffsetX/scrollViewWidth - floor(currentOffsetX/scrollViewWidth))
            // 计算targetIndex
            targetIndex = Int(currentOffsetX/scrollViewWidth)
            // 计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childViewControllers.count {
                sourceIndex = childViewControllers.count - 1
            }
            // 如果完全滑过去
            if startContentOffsetX - currentOffsetX  == scrollViewWidth {
                progress = 1
                sourceIndex = targetIndex
            }
        }
        // 将progress，sourceIndex，targetIndex传到titleView
        //print("\(progress),\(sourceIndex),\(targetIndex)")
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
// 对外暴露的方法
extension PageContentView {
    
    func setCurrentLabelIndex(currentLabelIndex : Int) -> Void {
        // 记录什么时候需要禁止代理方法
        isForbidScrollDelegate = true
        let offsetx = CGFloat(currentLabelIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetx, y: 0), animated: true)
    }
}
