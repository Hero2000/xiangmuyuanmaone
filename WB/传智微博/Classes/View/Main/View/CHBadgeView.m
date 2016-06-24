//
//  CHBadgeView.m
//
//  Created by LSW on 12/01/01.
//  Copyright © 2012年 LSW. All rights reserved.
//

#import "CHBadgeView.h"
#define CHBadgeViewFont [UIFont systemFontOfSize:11]

// 实现类可调用方法
@implementation CHBadgeView

#pragma mark - 2、小红点内容的设置------

// 重写setter方法，对属性进行操作和具体设置
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    // 判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) { // 没有内容或者空字符串,等于0
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    CGSize size = [badgeValue sizeWithFont:CHBadgeViewFont];
    // 文字的尺寸大于控件的宽度
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}

#pragma mark - 1、懒加载控件(初始化控件)------

// 初始化内部控件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        // 设置字体大小
        self.titleLabel.font = CHBadgeViewFont;
        [self sizeToFit];
    }
    return self;
}

@end
