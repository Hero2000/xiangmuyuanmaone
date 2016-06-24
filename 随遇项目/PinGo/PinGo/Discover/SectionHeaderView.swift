//
//  SectionHeaderView.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    @IBOutlet private var label: UILabel!
    
    var showText: String? {
        didSet {
            label.text = showText
        }
    }
    
    class func loadFromNib() -> SectionHeaderView {
        return NSBundle.mainBundle().loadNibNamed("SectionHeader", owner: self, options: nil).last as! SectionHeaderView
    }
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com