//
//  UIScreen+Extension.h
//  WB
//
//  Created by 刘生文 on 12/01/01.
//  Copyright © 2012年 apple. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIScreen (Extension)

+ (CGSize)ff_screenSize;
+ (BOOL)ff_isRetina;
+ (CGFloat)ff_scale;

@end
