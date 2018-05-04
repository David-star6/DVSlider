//
//  DVSliderNavBarItem.swift
//  DVSlider
//
//  Created by jacob on 2018/3/28.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

protocol DVSliderNavBarItemDelegate : NSObjectProtocol {
    func itemHandleWithTap(item:UIButton)
}

class DVSliderNavBarItem: UIButton {
    
    var delegate :DVSliderNavBarItemDelegate?
    
    override func draw(_ rect: CGRect) {
        self.addTarget(self, action:#selector(onClick(item:)), for: UIControlEvents.touchDown)
    }
    
    /*当被点击时发送的代理回调*/
    @objc private func onClick(item:UIButton){
        if (self.delegate != nil){
            self.delegate?.itemHandleWithTap(item: item)
        }
    }

}
