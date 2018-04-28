//
//  DVSilderNavBar.swift
//  DVSlider
//
//  Created by jacob on 2018/3/26.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

class DVSilderNavBar: UIScrollView {

    var titles:NSArray?{
        didSet
        {
            initWithCreatItem();
        }
    }
    
    var getCallBack:((Int)->(Void))?
    
    
    lazy var indicateLine : UILabel  = {
       var line = UILabel.init()
        line.backgroundColor = DVSliderTool.Colors.indicateColor
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = DVSliderTool.Colors.normalColor
        self.addSubview(indicateLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
       
    }
    
    private func initWithCreatItem(){
        let itemWidth = Int(Int(DVSliderTool.screen_width)/self.titles!.count)
        self.indicateLine.frame = CGRect.init(origin: CGPoint.init(x:(CGFloat(DVSliderTool.screen_width) / CGFloat(self.titles!.count))/2 - CGFloat(DVSliderTool.Item.lineWith/2), y: 59), size: CGSize.init(width: DVSliderTool.Item.height, height: 2))
                    self.addSubview(indicateLine)
        for index in 0..<self.titles!.count {
            let item = DVSliderNavBarItem.init(frame: CGRect.init(x: itemWidth*index, y: 0, width: itemWidth, height:  DVSliderTool.Item.height))
            item.tag = DVSliderTool.Item.itemTag + index
            item.delegate = self as? DVSliderNavBarItemDelegate
            item.setTitle(self.titles![index] as? String, for: UIControlState.normal)
            self.addSubview(item)
        }
    }
    
}


extension DVSilderNavBar: DVSliderNavBarItemDelegate{
    func itemHandleWithTap(item: UIButton) {
        getCallBack!(item.tag - DVSliderTool.Item.itemTag)
    }
}
