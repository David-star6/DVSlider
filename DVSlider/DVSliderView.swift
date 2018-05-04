//
//  DVSliderView.swift
//  DVSlider
//
//  Created by jacob on 2018/3/26.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

struct directions {
   static let right = 1
   static let left = 2
}

protocol SlideDelegate:NSObjectProtocol {
    func getScrollPostion(offsetX:CGFloat)
    func endScrollPostion(page:NSInteger,direction:Int)
}

class DVSliderView: UIScrollView {
    
    weak var slideDelegate: SlideDelegate?
    
    var beginX: CGFloat = 0
    
    var itemCount: CGFloat?
    
    var beginStatue: Bool = false
    
    var directionLeft: Bool!
    
    var delegateControllView: UIViewController?
    
    var item : NSInteger!{
        didSet{
            self.creatTableView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.backgroundColor = UIColor.white
        self.delegate = self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*创建每个tableview*/
    private func creatTableView(){
        self.itemCount = DVSliderTool.Item.maxNumber > self.item ?  CGFloat(self.item) : CGFloat(DVSliderTool.Item.maxNumber)
        for index in 0 ..< Int(self.item) {
            let tableView = UITableView.init(frame: CGRect.init(x: self.frame.size.width  * CGFloat(index), y: 0, width: self.frame.size.width, height: self.frame.size.height))
            tableView.backgroundColor = index == 1 ?  UIColor.gray : UIColor.gray
            tableView.delegate = delegateControllView as? UITableViewDelegate
            tableView.dataSource = delegateControllView  as? UITableViewDataSource
            tableView.isUserInteractionEnabled = false
            self.addSubview(tableView)
        }
        self.contentSize = CGSize.init(width:CGFloat(self.item) * self.frame.size.width, height: self.frame.size.height)
    }
    
    /*向右禁止滑动*/
    private func banScrollViewPanGesture(){
        self.panGestureRecognizer.isEnabled = false
        UIView.animate(withDuration: 0.25, animations: {
            self.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }, completion: { (_) in
            self.panGestureRecognizer.isEnabled = true
            self.beginStatue = false;
        })
    }
    
    func scrollWihtNumber(number:Int){
        self.setContentOffset(CGPoint.init(x: number * Int(self.frame.width), y: 0), animated: true)
    }
}

extension DVSliderView : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginX = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
     
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.beginStatue = false;
        if(beginX == scrollView.contentOffset.x) {return}
        if self.slideDelegate != nil{
            slideDelegate?.endScrollPostion(page:NSInteger(scrollView.contentOffset.x/self.frame.size.width),direction: beginX < scrollView.contentOffset.x ? directions.right : directions.left )
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x;
        if(!self.beginStatue){
            directionLeft = self.beginX - scrollView.contentOffset.x > 0 ? true : false;
            self.beginStatue = true;
        }
        offsetX < 0 && self.directionLeft ? self.banScrollViewPanGesture() : nil
        if self.slideDelegate != nil {
            let offsetX : CGFloat = scrollView.contentOffset.x/itemCount! + (CGFloat(DVSliderTool.screen_width/itemCount!)/2 - CGFloat(DVSliderTool.Item.lineWith/2));
            slideDelegate?.getScrollPostion(offsetX: offsetX)
        }
    }
    
}

