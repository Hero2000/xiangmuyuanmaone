//
//  CHTabBarButton.m
//
//  Created by LSW on 12/01/01.
//  Copyright © 2012年 LSW. All rights reserved.
//

#import "CHTabBarButton.h"
#import "CHBadgeView.h"
#define CHImageRidio 0.7

// 对类内部可调用属性进行声明
@interface CHTabBarButton ()

// 小红点按钮的保存属性
@property (nonatomic, weak) CHBadgeView *badgeView;

@end

@implementation CHTabBarButton

#pragma mark - 3、监听tabBarItem内部属性------

// 传递UITabBarItem给tabBarButton,给tabBarButton内容赋值
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    // KVO：时刻监听一个对象的属性有没有改变
    // 给谁添加观察者
    // Observer:按钮
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

// 只要监听的属性一有新值，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    // 设置badgeValue
    self.badgeView.badgeValue = _item.badgeValue;
}

#pragma mark - 2、控件进行布局------

// 修改按钮内部子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * CHImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 5;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 3.badgeView
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}

#pragma mark - 1、懒加载控件、初始化控件------

// 懒加载badgeView
- (CHBadgeView *)badgeView
{
    if (_badgeView == nil) {
        CHBadgeView *btn = [CHBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _badgeView = btn;
    }
    return _badgeView;
}

// 初始化控件的状态
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

// 重写setHighlighted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted
{
}

@end
