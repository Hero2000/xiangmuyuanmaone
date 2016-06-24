//
//  Array+Extension.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/2.
//  Copyright © 2016年 GWL. All rights reserved.
//

import Foundation

extension Array {
    
    func split(startIndex sIndex: Int, endIndex eIndex: Int) -> [Element] {
        return 0.stride(to: eIndex, by: eIndex).map { _ in
            return Array(self[sIndex ..< eIndex])
        }[0]
    }
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com