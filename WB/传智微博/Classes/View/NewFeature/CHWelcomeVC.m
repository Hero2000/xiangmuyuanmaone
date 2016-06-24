//
//  CHWelcomeVC.m
//  WB
//
//  Created by 刘生文 on 13/3/30.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHWelcomeVC.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "CHAccountTool.h"
#import "CHAccount.h"
#import "UIView+IBExtension.h"

@interface CHWelcomeVC ()
// 用户头像
@property (nonatomic, strong) UIImageView *bgImageView;
// 用户头像
@property (nonatomic, strong) UIImageView *iconView;
// 欢迎标签
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation CHWelcomeVC

- (void)loadView
{
    self.view = self.bgImageView;
    [self setUpUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-(self.view.center.y + 100));
//        make.top.mas_equalTo(self.view).offset(100);
    }];
    
    self.messageLabel.alpha = 0;
    // 执行动画
    // Damping: 阻尼 0-1 --> 阻尼越大,弹性效果越小
    // initialSpringVelocity: 执行弹性动画的初始速度
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:0 animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        // 标签动画
        [UIView animateWithDuration:0.5 animations:^{
            self.messageLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:switchRootVC object:nil];
        }];
    }];
}

#pragma mark - 设置界面
- (void)setUpUI {
    // 1. 添加控件
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.messageLabel];
    // 2. 自动布局
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(-200);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconView);
        make.top.equalTo(self.iconView.mas_bottom).offset(20);
    }];
}

#pragma mark - 懒加载控件
- (UIImageView *)bgImageView {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ad_background"]];
}

- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.cornerRadius = 45;
        _iconView.image = [UIImage imageNamed:@"avatar_default_big"];
        [_iconView sd_setImageWithURL:[CHAccountTool account].profile_image_url placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
    }
    return _iconView;
}

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor darkGrayColor];
        label.text = [CHAccountTool account].name ? [CHAccountTool account].name : @"欢迎归来";
        [label sizeToFit];
        _messageLabel = label;
    }
    return _messageLabel;
}
@end
