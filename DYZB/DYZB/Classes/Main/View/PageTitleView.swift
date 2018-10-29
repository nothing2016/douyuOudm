//
//  PageTitleView.swift
//  DYZB
//
//  Created by mac on 2018/10/13.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

// 定义协议
protocol  PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int) -> Void
}
// 定义常量
private let kScrollLineHeight : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// 定义类
class PageTitleView: UIView {

    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    private var titles:[String]
    private var currentLabelIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    private lazy var titleLabels : [UILabel] = [UILabel]()
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setupUI() -> Void {
        // 1.添加scrollVIew
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.设置TitleLabels
        self.setupTitleLabels()
        
        // 3.设置底线和滚动的滑块
        self.setBottomLineAndScrollLine()
        
    }
    
    private func setupTitleLabels() -> Void {
        let labelWidth : CGFloat = frame.width / CGFloat(titles.count)
        let labelHeight : CGFloat = frame.height - kScrollLineHeight
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 创建label
            let label = UILabel()
            
            // 设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
            label.textAlignment = .center
            
            // 设置label的frame
            let labelX : CGFloat = labelWidth * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            
            // 添加label到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 给label添加手势点击事件
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setBottomLineAndScrollLine() -> Void {
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineHeight : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - lineHeight, width: self.frame.width, height: lineHeight)
        addSubview(bottomLine)
        
        // 2.添加滚动的高亮线
        // 2.1 获取第一个label的位置
        guard let firstTitleLabel = titleLabels.first else {return}
        firstTitleLabel.textColor = UIColor(red: kSelectedColor.0, green: kSelectedColor
            .1, blue: kSelectedColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: (firstTitleLabel.frame.origin.x), y: (firstTitleLabel.frame.origin.y) + self.frame.height - kScrollLineHeight, width: (firstTitleLabel.frame.width), height: kScrollLineHeight)
    }
}

extension PageTitleView {
    @objc func titleLabelClick(tapGes : UITapGestureRecognizer) -> Void {
        // 获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return}
        
        // 如果是重复点击，直接返回
        if currentLabel.tag == currentLabelIndex {
            return
        }
        // 获取之前的label
        let oldLabel = titleLabels[currentLabelIndex]
        
        // 修改选中的颜色
        currentLabel.textColor = UIColor(red: kSelectedColor.0, green: kSelectedColor.1, blue: kSelectedColor.2)
        oldLabel.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
        
        // 保存最新label的下标值
        currentLabelIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.1) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 通知代理类
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLabel.tag)
    }
}

// 对外暴露的方法
extension PageTitleView {
    func setTitleProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) -> Void {
        //print("\(progress),\(sourceIndex),\(targetIndex)")
        // 取出sourceLabel和targetLabel
        var sourceLabel = titleLabels[sourceIndex]
        var targetlabel = titleLabels[targetIndex]
        
        let moveTotalX = targetlabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = progress * moveTotalX
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // title颜色渐变
        var colorDelta = (kSelectedColor.0 - kNormalColor.1,kSelectedColor.1 - kNormalColor.0,kSelectedColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(red: kSelectedColor.0 - (progress * colorDelta.0), green: kSelectedColor.1 - (progress * colorDelta.1), blue: kSelectedColor.2 - (progress * colorDelta.2))
        
        targetlabel.textColor = UIColor(red: kNormalColor.0 + (progress * colorDelta.0), green: kNormalColor.1 + (progress * colorDelta.1), blue: kNormalColor.2 + (progress * colorDelta.2))
        
        currentLabelIndex = targetIndex
    }
}
