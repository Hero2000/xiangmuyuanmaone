//
//  CHRowItem.m
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHRowItem.h"

@implementation CHRowItem

// 设置cell的主标题、图标
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image
{
    CHRowItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    return item;
}

// 设置cell的主标题
+ (instancetype)itemWithTitle:(NSString *)title
{
    CHRowItem *item = [self itemWithTitle:title image:nil];
    return item;
}

@end
