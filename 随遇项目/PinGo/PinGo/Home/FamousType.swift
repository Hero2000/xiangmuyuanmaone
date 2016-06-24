//
//  FamousType.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class FamousType: NSObject {
    
    var typeID = 0
    var typeName: String?
    var isPrimary = 0
    var isOfficial = 0
    
    init(dict: [String: AnyObject]?) {
        super.init()
        
        guard dict?.count > 0 else {
            return
        }
        
        for (key, value) in dict! {
            let keyName = key as String
            if keyName == "typeID" {
                if let t = value as? String {
                    setValue(Int(t), forKey: "typeID")
                }else if let t = value as? Int {
                    setValue(t, forKey: "typeID")
                }
                continue
            }
            self.setValue(value, forKey: keyName)
        }
    }
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com