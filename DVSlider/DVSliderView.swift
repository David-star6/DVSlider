//
//  DVSliderView.swift
//  DVSlider
//
//  Created by jacob on 2018/3/26.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

protocol SlideDelegate:NSObjectProtocol {
    func getScrollPostion(offsetX:CGFloat)
}

class DVSliderView: UIScrollView {
    
    weak var slideDelegate: SlideDelegate?
    
    var currentScrollViewOfferX : CGFloat! = 0
    
    var scrollViewOfferX : CGFloat! = 0
    
    var isPanGestureEnabled : Bool! = true
    
    var itemCount: CGFloat?
    
    
    var item : NSInteger!{
        didSet{
         self.creatTableView()
        }
    }
    
    var delegateView:UIViewController?
    
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
    
   private func creatTableView(){
    self.itemCount = CGFloat(self.item)
    for index in 0 ..< Int(self.item) {
        let tableView = UITableView.init(frame: CGRect.init(x: self.frame.size.width  * CGFloat(index), y: 0, width: self.frame.size.width, height: self.frame.size.height))
        tableView.backgroundColor = index == 1 ?  UIColor.gray : UIColor.gray;
//        tableView.delegate = delegateView as? UITableViewDelegate;
        self.addSubview(tableView)
    }
    self.contentSize = CGSize.init(width:CGFloat(self.item) * self.frame.size.width, height: self.frame.size.height)
    }
    
    private func banScrollViewPanGesture(bools:Bool){
        self.isPanGestureEnabled = bools
        self.panGestureRecognizer.isEnabled = bools
    }
    
     func scrollWihtNumber(number:Int){
       self.setContentOffset(CGPoint.init(x: number * Int(self.frame.width), y: 0), animated: true)
    }
}

extension DVSliderView : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
  
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        !self.isPanGestureEnabled ? self.banScrollViewPanGesture(bools:true) : nil
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentScrollViewOfferX = scrollView.contentOffset.x
//        if currentScrollViewOfferX > scrollViewOfferX {
//
//            currentScrollViewOfferX + self.frame.size.width  > scrollView.contentSize.width ? (self.banScrollViewPanGesture(bools: false)) : nil
//
//        } else if(currentScrollViewOfferX < scrollViewOfferX){
//
//            currentScrollViewOfferX < 0  ? (self.banScrollViewPanGesture(bools: false)) : nil
//        }
        
        if self.slideDelegate != nil {
            let offsetX : CGFloat = scrollView.contentOffset.x/itemCount! + (CGFloat(DVSliderTool.screen_width/itemCount!)/2 - CGFloat(DVSliderTool.Item.lineWith/2));
            slideDelegate?.getScrollPostion(offsetX: offsetX)
        }
        scrollViewOfferX = currentScrollViewOfferX
    }
    
}

