//
//  CHTabBar.m
//
//  Created by LSW on 12/01/01.
//  Copyright © 2012年 LSW. All rights reserved.
//

#import "CHTabBar.h"
#import "CHTabBarButton.h"

@interface CHTabBar ()

// 加号按钮 存储的属性
@property (nonatomic, weak) UIButton *plusButton;

// tabBar系统属性按钮 存储的属性
@property (nonatomic, strong) NSMutableArray *buttons;

// tabBar系统属性 选择状态 存储的属性
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation CHTabBar

#pragma mark - 4、监听方法------

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

// 点击加号按钮的时候调用
- (void)plusClick
{
    // modal出控制器
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [_delegate tabBarDidClickPlusButton:_plusButton];
    }
}

#pragma mark - 3、用set方法对控件参数进行重新设置------

- (void)setItems:(NSArray *)items {
    _items = items;
    // 遍历模型数组，创建对应tabBarButton
    for (UITabBarItem *item in _items) {
        // 在tabBarItem上创建自己的button
        CHTabBarButton *btn = [CHTabBarButton buttonWithType:UIButtonTypeCustom];
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        // 绑定按钮的tag
        btn.tag = self.buttons.count;
        // 调用按钮的监听方法
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            if (btn.tag == 0) {// 选中第0个
                [self btnClick:btn];
            }
        // 将tabBarItem上按钮添加到tabBarItem上
        [self addSubview:btn];
        // 把按钮添加到按钮数组
        [self.buttons addObject:btn];
    }
}

#pragma mark - 2、给tabBar内部bottom进行位置布局------

// self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
// 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 取得tabBarItem的宽和高
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    // 设置按钮在tabBarItem内部的Frame
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    NSUInteger i = 0;
    // 设置tabBarButton的frame
    for (UIView *tabBarButton in self.buttons) {
        // 将加号按钮的位置腾出来
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    // 设置添加按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
}

#pragma mark - 1、懒加载控件、初始化控件------

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

// 重写加号按钮的getter方法进行赋值
- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
        // 监听按钮的点击
        [btn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        _plusButton = btn;
        [self addSubview:_plusButton];
    }
    return _plusButton;
}

@end





