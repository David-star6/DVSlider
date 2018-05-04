//
//  DVSliderManager.swift
//  DVSlider
//
//  Created by jacob on 2018/3/26.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

class DVSliderManager: NSObject {

    static let sharedInstance = DVSliderManager()
    
    var titles : NSArray?
    
    var delegateController : UIViewController?
    
    /*滑动视图*/
    lazy var views : UIView = {
        var views = UIView.init(frame: CGRect.init(x: 0, y: 0, width: DVSliderTool.screen_width, height: DVSliderTool.screen_height))
        views.addSubview(sliderView)
        views.addSubview(sliderNavBar)
        return views;
    }()
    
    /*滑动内容栏*/
    lazy var sliderView : DVSliderView = {
        var slider = DVSliderView()
        slider.frame = CGRect.init(x: 0, y: CGFloat(DVSliderTool.Item.height), width: DVSliderTool.screen_width, height: DVSliderTool.screen_height-CGFloat(DVSliderTool.Item.height))
        slider.delegateControllView = delegateController
        slider.slideDelegate = self;
        slider.item = self.titles?.count;
        return slider
    }()
    
    /*滑动导航栏*/
    lazy var sliderNavBar : DVSilderNavBar = {
        var sliderNav = DVSilderNavBar.init(frame: CGRect.init(x: 0, y: 0, width: DVSliderTool.screen_width, height: 60))
        sliderNav.titles = self.titles
        sliderNav.getCallBack={(result) -> Void in
            self.clickItem(number:result)
        }
        return sliderNav
    }()
    
    /*获取每个tableview*/
    func getScrollTabeleView(tableView:(UITableView)->(Void)){
        for view in self.sliderView.tableviewArr!{
            tableView(view as! UITableView)
        }
    }
    func creatSlideView(vc:UIViewController,title:NSArray){
        self.titles = title
        self.delegateController = vc
        vc.view.addSubview(self.views)
    }
    
    private func clickItem(number:Int){
        self.sliderView.scrollWihtNumber(number: number)
    }
    
    private override init() {
        
    }
    
}


/*DVSliderView滑动后产生的回调*/
extension DVSliderManager : SlideDelegate{
    
    func endScrollPostion(page: NSInteger, direction: Int) {
        self.sliderNavBar.clickItemWithTag(tag:page)
    }
    
    func getScrollPostion(offsetX: CGFloat) {
        self.sliderNavBar.indicateLine.frame = CGRect.init(origin: CGPoint.init(x: offsetX, y: self.sliderNavBar.indicateLine.frame.origin.y), size: self.sliderNavBar.indicateLine.frame.size)
    }
    
}


