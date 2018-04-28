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
    
    var delegateController : ViewController?
    
    lazy var views : UIView = {
        var views = UIView.init(frame: CGRect.init(x: 0, y: 0, width: DVSliderTool.screen_width, height: DVSliderTool.screen_height))
        sliderView.delegateView = delegateController
        sliderView.slideDelegate = self;
        views.addSubview(sliderView)
        views.addSubview(sliderNavBar)
        return views;
    }()
    
    lazy var sliderView : DVSliderView = {
        var slider = DVSliderView()
        slider.frame = CGRect.init(x: 0, y: 60, width: DVSliderTool.screen_width, height: DVSliderTool.screen_height-60)
        slider.item = self.titles?.count;
        return slider
    }()
    
    lazy var sliderNavBar : DVSilderNavBar = {
        var sliderNav = DVSilderNavBar.init(frame: CGRect.init(x: 0, y: 0, width: DVSliderTool.screen_width, height: 60))
        sliderNav.titles = self.titles
        sliderNav.getCallBack={(result) -> Void in
            self.itemWithClick(number:result)
        }
        return sliderNav
    }()
    
    private func itemWithClick(number:Int){
        self.sliderView.scrollWihtNumber(number: number)
    }
    
    private override init() {
        
    }
    
}

extension DVSliderManager : SlideDelegate{
    func getScrollPostion(offsetX: CGFloat) {
        self.sliderNavBar.indicateLine.frame = CGRect.init(origin: CGPoint.init(x: offsetX, y: self.sliderNavBar.indicateLine.frame.origin.y), size: self.sliderNavBar.indicateLine.frame.size)
    }
}


