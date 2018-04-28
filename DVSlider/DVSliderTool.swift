//
//  DVSliderTool.swift
//  DVSlider
//
//  Created by jacob on 2018/3/27.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit


class DVSliderTool: NSObject {
    
    static let screen_width = UIScreen.main.bounds.size.width;
    
    static let screen_height = UIScreen.main.bounds.size.height;

    struct Colors {
        static let normalColor = UIColor.gray
        static let fontColor = UIColor.black
        static let indicateColor = UIColor.red
    }
    
    struct Item {
        static let itemTag = 100
        static let height = 60
        static let lineWith = 60
    }
    
}
