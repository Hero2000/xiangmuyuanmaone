//
//  UIBarButtonItem+Item.m
//  WB
//
//  Created by 刘生文 on 12/01/01.
//  Copyright © 2012年 apple. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    // 创建button样式
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置button背景图片
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    // 设置button高亮状态的背景图片
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    // 设置button的监听方法
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
