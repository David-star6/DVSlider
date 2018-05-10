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
        static let defaultColor = UIColor.gray.withAlphaComponent(0.4)
        static let normalColor = UIColor.gray
        static let fontColor = UIColor.black
        static let indicateColor = UIColor.red
        static let buttonDefaultColor = UIColor.white
        static let buttonSelectColor = UIColor.red
    }
    
    struct Item {
        static let itemTag = 100
        static let height = 60
        static let lineWith = 80
        static let maxNumber = 4
        static let bottomLineHeight = 1
    }
    
    struct RGBA {
        var r : CGFloat
        var g : CGFloat
        var b : CGFloat
        var a : CGFloat
    }

    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

//extension UIColor {
//    convenience init(rgb: UInt) {
//        self.init(
//            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgb & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
//}

