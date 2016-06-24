//
//  VisitorHeaderView.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class VisitorHeaderView: UIView {
    
    @IBOutlet private weak var visitorCountLabel: UILabel!
    @IBOutlet private weak var vistorTodayLabel: UILabel!
    
    var num: (Int, Int)? {
        didSet {
            visitorCountLabel.text = "\(num!.0)"
            vistorTodayLabel.text = "\(num!.1)"
        }
    }
    
    class func loadFromNib() -> VisitorHeaderView {
        return NSBundle.mainBundle().loadNibNamed("VisitorHeader", owner: self, options: nil).last as! VisitorHeaderView
    }
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com