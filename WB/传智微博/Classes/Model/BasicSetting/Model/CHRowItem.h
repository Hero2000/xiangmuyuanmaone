//
//  CHRowItem.h
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CHRowItemOption)();

@interface CHRowItem : NSObject
// cell的主标题
@property (nonatomic, copy)  NSString *title;
// cell的副标题
@property (nonatomic, copy)  NSString *subTitle;
// cell的图标
@property (nonatomic, strong)  UIImage *image;
// cell被点击时，调整的控制器类型
@property (nonatomic, assign) Class descVc;
// cell
@property (nonatomic, copy)  CHRowItemOption option;
// 设置cell的主标题
+ (instancetype)itemWithTitle:(NSString *)title;
// 设置cell的主标题、图标
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;
@end
