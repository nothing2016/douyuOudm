//
//  HomeViewController.swift
//  DYZB
//
//  Created by mac on 2018/10/11.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

let kTitleViewHeight : CGFloat = 40
class HomeViewController: UIViewController {

    // 懒加载属性
    private lazy var pageTitleView:PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: kTitleViewHeight)
        let titles = ["推荐","娱乐","游戏","趣味"]
        let pageTitleView = PageTitleView(frame: titleFrame, titles: titles)
//        pageTitleView.backgroundColor = UIColor.purple
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        // 确定pageContent的frame的大小
        let pageContentFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight + kTitleViewHeight, width: kScreenWidth, height: kScreenHeigth - kStatusBarHeight - kNavigationBarHeight - kTitleViewHeight - kTabbarHeight )
        var childViewControllers = [UIViewController]()
        // 先加入推荐控制器
        childViewControllers.append(RecommendViewController())
        for _ in 0..<3 {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
            childViewControllers.append(viewController)
        }
        let pageContentView = PageContentView(frame: pageContentFrame, childViewControllers: childViewControllers, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setUpUI()
        // 添加titleView
        view.addSubview(pageTitleView)
        
        // 添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }

}
// 设置ui界面
extension HomeViewController {
    private func setUpUI() -> Void {
        // 设置导航栏
        setNavigationBar()
    }
    
    private func setNavigationBar() -> Void {
        
        // 设置左边的导航栏
        let btnItem = UIBarButtonItem(imageName: "logo")
        navigationItem.leftBarButtonItem = btnItem
        
        // 设置右边的导航栏
        let size = CGSize(width: 40, height: 40)
        //观看历史
        let historyUIBarButtonItem = UIBarButtonItem(imageName: "image_my_history",highlightedImageName: "Image_my_history_click",size: size)
        
        //搜索
        let searchUIBarButtonItem = UIBarButtonItem(imageName: "btn_search",highlightedImageName: "btn_search_clicked",size: size)
        
        //扫描二维码
        let qrcodeUIBarButtonItem = UIBarButtonItem(imageName: "Image_scan",highlightedImageName: "Image_scan_click",size: size)
        navigationItem.rightBarButtonItems = [historyUIBarButtonItem,searchUIBarButtonItem,qrcodeUIBarButtonItem]
    }
}

extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentLabelIndex(currentLabelIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
