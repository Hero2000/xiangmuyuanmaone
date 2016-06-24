//
//  UIView+IBExtension.h
//  WB
//
//  Created by 刘生文 on 12/01/01.
//  Copyright © 2012年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (IBExtension)

// 边线颜色
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

// 边线宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

// 脚半径
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@end
