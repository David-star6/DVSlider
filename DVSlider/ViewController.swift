//
//  ViewController.swift
//  DVSlider
//
//  Created by jacob on 2018/3/24.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initWitFrame()
    }
    
    private func initWitFrame(){
        DVSliderManager.sharedInstance.titles = ["商品1","商品2","商品3","商品4"]
        DVSliderManager.sharedInstance.delegateController=self
        self.view .addSubview(DVSliderManager.sharedInstance.views)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

