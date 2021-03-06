//
//  DVSilderNavBar.swift
//  DVSlider
//
//  Created by jacob on 2018/3/26.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit


class DVSilderNavBar: UIScrollView {

    var buttonWith : CGFloat?
    var currenItem : UIButton?

    
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
    
    /*增加一条底部边框的细线*/
    lazy var bottomLine : UILabel = {
       var line = UILabel.init(frame: CGRect.init(x: 0, y: self.frame.size.height - CGFloat(DVSliderTool.Item.bottomLineHeight), width: self.contentSize.width, height: CGFloat(DVSliderTool.Item.bottomLineHeight)))
        line.backgroundColor = DVSliderTool.Colors.defaultColor
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = DVSliderTool.Colors.defaultColor
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
        self.indicateLine.frame = CGRect.init(origin: CGPoint.init(x:(CGFloat(DVSliderTool.screen_width) / CGFloat(number))/2 - CGFloat(DVSliderTool.Item.lineWith/2), y: 59), size: CGSize.init(width: DVSliderTool.Item.lineWith, height: 2))
                    self.addSubview(indicateLine)
        self.buttonWith = CGFloat(itemWidth);
        for index in 0..<self.titles!.count {
            let item = DVSliderNavBarItem.init(frame: CGRect.init(x: itemWidth*index, y: 0, width: itemWidth, height:  DVSliderTool.Item.height))
            item.tag = DVSliderTool.Item.itemTag + index
            item.delegate = self as? DVSliderNavBarItemDelegate
            item.setTitle(self.titles![index] as? String, for: UIControlState.normal)
            item.setTitleColor(DVSliderTool.Colors.buttonDefaultColor, for: UIControlState.normal)
            item.setTitleColor(DVSliderTool.Colors.buttonSelectColor, for: UIControlState.selected)
            self.addSubview(item)
        }
        let button : DVSliderNavBarItem = self.viewWithTag(DVSliderTool.Item.itemTag) as! DVSliderNavBarItem
        self.scrollItemWithButton(item: button)
        self.addSubview(bottomLine)
        self.addSubview(indicateLine)
    }

    
    /*根据tag判断滑动后选中的导航按钮*/
    func clickItemWithTag(tag:NSInteger){
        let button : UIButton = self.viewWithTag(tag + DVSliderTool.Item.itemTag) as! UIButton
        self.scrollItemWithButton(item: button)
    }
    
    /*导航按钮点击选中后的滑动效果*/
    private func scrollItemWithButton(item:UIButton){
        self.currenItem?.isSelected = false
        item.isSelected = true
        if (item.tag - 2 <= DVSliderTool.Item.itemTag) {
            self.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }else if (item.tag + 2 >= (self.titles?.count)! + DVSliderTool.Item.itemTag){
            let sender : UIButton = self.viewWithTag(((self.titles?.count)!/2 + (self.titles?.count)!%2)  +  DVSliderTool.Item.itemTag) as! UIButton
            self.setContentOffset(CGPoint.init(x: sender.frame.origin.x - sender.frame.size.width, y: 0), animated: true)
        }else{
            let sender = self.viewWithTag(item.tag-2)
            self.setContentOffset(CGPoint.init(x: Int((sender?.frame.origin.x)! + item.frame.size.width/2), y: 0), animated: true)
        }
        self.currenItem = item

    }
    
    /*根据滑动位置更改指使线条和item*/
    func scrollWithoffsetX(offsetX : CGFloat,isLeft:Bool){
        self.indicateLine.frame = CGRect.init(origin: CGPoint.init(x: offsetX, y: self.indicateLine.frame.origin.y), size: self.indicateLine.frame.size)
    }
    
}

/*导航按钮点击后的方法*/
extension DVSilderNavBar: DVSliderNavBarItemDelegate{
    func itemHandleWithTap(item: UIButton) {
        self.scrollItemWithButton(item: item)
        getCallBack!(item.tag - DVSliderTool.Item.itemTag)
    }
}


