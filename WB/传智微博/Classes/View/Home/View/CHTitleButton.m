//
//  CHTitleButton.m
//  WB
//
//  Created by 刘生文 on 13/3/17.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHTitleButton.h"

@implementation CHTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 进行一次性的初始化
        // 设置图片
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
        // 设置颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置图片居中
        self.titleLabel.contentMode = NSTextAlignmentCenter;
        // 设置标题居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 高亮状态时不需要调整图片
        self.adjustsImageWhenHighlighted = NO;
        // 设置Frame(如果是设置titleView，那么x/y无效)
        [self sizeToFit];
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.currentImage == nil) return;
    [super layoutSubviews];
    // 交换两个控件的位置，只需要将x值进行调整
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}
@end











