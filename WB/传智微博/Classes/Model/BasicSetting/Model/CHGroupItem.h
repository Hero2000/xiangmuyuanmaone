//
//  CHGroupItem.h
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHGroupItem : NSObject
// 存放不同cell的模型
@property (nonatomic, strong) NSArray *items;
// 头部标题
@property (nonatomic, copy) NSString *headerTitle;
// 尾部标题
@property (nonatomic, copy) NSString *footerTitle;
@end
