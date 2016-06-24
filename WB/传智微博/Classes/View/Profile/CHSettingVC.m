//
//  CHSettingVC.m
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHSettingVC.h"
#import "CHBadgeItem.h"
#import "CHGroupItem.h"
#import "CHArrowItem.h"
#import "CHLabelItem.h"
// 跳转到"通用设置"控制器
#import "CHCommonSettingVC.h"

@interface CHSettingVC ()

@end

@implementation CHSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
}

- (void)setUpGroup0
{
    // 账号管理
    CHBadgeItem *account = [CHBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = @"8";
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[account];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 提醒和通知
    CHArrowItem *notice = [CHArrowItem itemWithTitle:@"我的相册" ];
    // 通用设置
    CHArrowItem *setting = [CHArrowItem itemWithTitle:@"通用设置" ];
    setting.descVc = [CHCommonSettingVC class];
    // 隐私与安全
    CHArrowItem *secure = [CHArrowItem itemWithTitle:@"隐私与安全" ];
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[notice,setting,secure];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 意见反馈
    CHArrowItem *suggest = [CHArrowItem itemWithTitle:@"意见反馈" ];
    // 关于微博
    CHArrowItem *about = [CHArrowItem itemWithTitle:@"关于微博"];
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[suggest,about];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 账号管理
    CHLabelItem *layout = [[CHLabelItem alloc] init];
    layout.text = @"退出当前账号";
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[layout];
    [self.groups addObject:group];
}
@end
