//
//  CHSearchBar.m
//  WB
//
//  Created by 刘生文 on 13/3/17.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHSearchBar.h"

@implementation CHSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1、设置UITextField的样式
        self.borderStyle = UITextBorderStyleRoundedRect;
        // 2、设置提醒文本
        self.placeholder = @"请输入搜索内容";
        // 3、添加放大镜
        // 如果通过UIImageView方法创建图片容器，不需要设置frame，默认图片的frame就是image的宽高
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        icon.width = 30;
        icon.contentMode = UIViewContentModeCenter;
        // 4、默认是不能显示出来的，必须设置leftModel
        self.leftView = icon;
        self.leftViewMode = UITextFieldViewModeAlways;
        // 5、设置清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (void)setLeftViewName:(NSString *)leftViewName
{
    _leftViewName = leftViewName;
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftViewName]];
    icon.width = 30;
    icon.contentMode = UIViewContentModeCenter;
    self.leftView = icon;
}

@end
