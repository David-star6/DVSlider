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
    
    /*下划线滑动条*/
    lazy var indicateLine : UILabel  = {
       var line = UILabel.init()
        line.backgroundColor = DVSliderTool.Colors.indicateColor
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = DVSliderTool.Colors.normalColor
        self.addSubview(indicateLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
       
    }
    
    /*创建每个每个导航title*/
    private func initWithCreatItem(){
        let number = DVSliderTool.Item.maxNumber < self.titles!.count ? DVSliderTool.Item.maxNumber : self.titles!.count
        let itemWidth = Int(Int(DVSliderTool.screen_width)/number)
        let contentWidth = CGFloat(self.titles!.count) * CGFloat(itemWidth) > self.frame.size.width ?  CGFloat(self.titles!.count) * CGFloat(itemWidth) : self.frame.size.width
        self.contentSize = CGSize.init(width: contentWidth, height: self.frame.size.height)
        self.indicateLine.frame = CGRect.init(origin: CGPoint.init(x:(CGFloat(DVSliderTool.screen_width) / CGFloat(number))/2 - CGFloat(DVSliderTool.Item.lineWith/2), y: 59), size: CGSize.init(width: DVSliderTool.Item.height, height: 2))
                    self.addSubview(indicateLine)
        for index in 0..<self.titles!.count {
            let item = DVSliderNavBarItem.init(frame: CGRect.init(x: itemWidth*index, y: 0, width: itemWidth, height:  DVSliderTool.Item.height))
            item.tag = DVSliderTool.Item.itemTag + index
            item.delegate = self as? DVSliderNavBarItemDelegate
            item.setTitle(self.titles![index] as? String, for: UIControlState.normal)
            self.addSubview(item)
        }
    }
    
    /*根据tag判断滑动后选中的导航按钮*/
    func clickItemWithTag(tag:NSInteger){
        let button = self.viewWithTag(tag + DVSliderTool.Item.itemTag)
        self.scrollItemWithButton(item: button as! UIButton)
    }
    
    /*导航按钮点击选中后的滑动效果*/
    private func scrollItemWithButton(item:UIButton){
        if (item.tag - 2 <=  DVSliderTool.Item.itemTag) {
            self.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }else if (item.tag + 2 >= (self.titles?.count)! + DVSliderTool.Item.itemTag){
            
            let sender : UIButton = self.viewWithTag(((self.titles?.count)!/2 + (self.titles?.count)!%2)  +  DVSliderTool.Item.itemTag) as! UIButton
            self.setContentOffset(CGPoint.init(x: sender.frame.origin.x - sender.frame.size.width, y: 0), animated: true)
        }else{
            let sender = self.viewWithTag(item.tag-2)
            self.setContentOffset(CGPoint.init(x: Int((sender?.frame.origin.x)! + item.frame.size.width/2), y: 0), animated: true)
        }
    }
    
}

/*导航按钮点击后的方法*/
extension DVSilderNavBar: DVSliderNavBarItemDelegate{
    func itemHandleWithTap(item: UIButton) {
        self.scrollItemWithButton(item: item)
        getCallBack!(item.tag - DVSliderTool.Item.itemTag)
    }
}
