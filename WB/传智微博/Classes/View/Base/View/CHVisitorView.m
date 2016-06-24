//
//  CHVisitorView.m
//  WB
//
//  Created by 刘生文 on 13/3/24.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHVisitorView.h"
#import "Masonry.h"

@interface CHVisitorView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIImageView *circleView;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation CHVisitorView

#pragma mark - 4、外部调用方法------
- (void)setUpInfo:(NSString *)imageName title:(NSString *)title
{
    self.iconView.hidden = (imageName != nil);
    self.messageLabel.text = title;
    if (imageName != nil) {
        self.circleView.image = [UIImage imageNamed:imageName];
        self.iconView.hidden = YES;
        [self sendSubviewToBack:self.backView];
    }else{
        [self startAnimation];
    }
}
// 开始旋转图标图像动画
- (void)startAnimation {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    // 旋转角度
    anim.toValue = @(2 * M_PI);
    // 重复次数
    anim.repeatCount = MAXFLOAT;
    // 动画时长
    anim.duration = 8;
    // 动画删除时是否删除
    anim.removedOnCompletion = NO;
    [self.circleView.layer addAnimation:anim forKey:nil];
}

#pragma mark - 3、初始化控件------
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 2、控件进行布局------
- (void)setUpUI
{
    self.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self addSubview:self.circleView];
    [self addSubview:self.backView];
    [self addSubview:self.iconView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.loginBtn];
    [self addSubview:self.registerBtn];
    // 图标
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-60);
    }];
    // 圆圈
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.iconView);
    }];
    // 消息
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.circleView);
        make.top.equalTo(self.circleView.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(224, 40));
    }];
    // 注册按钮
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageLabel);
        make.top.equalTo(self.messageLabel.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    // 登录按钮
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.messageLabel);
        make.top.equalTo(self.messageLabel.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    // 背景图片
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.registerBtn.mas_bottom);
    }];
}
#pragma mark - 1、懒加载控件、初始化控件------
// 创建图片
-(UIImageView *)iconView
{
    if (_iconView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"visitordiscover_feed_image_house"];
        imageV.image = image;
        _iconView = imageV;
    }
    return _iconView;
}

// 首页的圆
- (UIImageView *)circleView
{
    if (_circleView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"visitordiscover_feed_image_smallicon"];
        imageV.image = image;
        _circleView = imageV;
    }
    return _circleView;
}
// 显示标签的 Label
- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        UILabel *l = [[UILabel alloc] init];
        l.textColor = [UIColor darkGrayColor];
        l.text = @"关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜";
        l.font = [UIFont systemFontOfSize:14];
        l.textAlignment = UITextAlignmentCenter;
        l.numberOfLines = 0;
        _messageLabel = l;
    }
    return _messageLabel;
}
// 注册按钮
- (UIButton *)registerBtn
{
    if (_registerBtn == nil) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"注册" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"common_button_big_white_disable"] forState:UIControlStateNormal];
        _registerBtn = btn;
    }
    return _registerBtn;
}
// 登录按钮
- (UIButton *)loginBtn
{
    if (_loginBtn == nil) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"common_button_big_white_disable"] forState:UIControlStateNormal];
        _loginBtn = btn;
    }
    return  _loginBtn;
}
// 背景阴影
- (UIImageView *)backView
{
    if (_backView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"visitordiscover_feed_mask_smallicon"];
        imageV.image = image;
        _backView = imageV;
    }
    return _backView;
}

@end
