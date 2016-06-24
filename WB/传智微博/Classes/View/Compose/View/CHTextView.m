//
//  CHTextView.m
//  WB
//
//  Created by 刘生文 on 13/3/30.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHTextView.h"

@interface CHTextView ()
// 存放占位符的标签
@property (nonatomic, weak) UILabel *placeHolderLabel;
@end
@implementation CHTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = font;
    // label的尺寸跟文字一样
    [self.placeHolderLabel sizeToFit];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.placeHolderLabel.text = placeHolder;
    // label的尺寸跟文字一样
    [self.placeHolderLabel sizeToFit];
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    self.placeHolderLabel.hidden = hidePlaceHolder;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}


@end
