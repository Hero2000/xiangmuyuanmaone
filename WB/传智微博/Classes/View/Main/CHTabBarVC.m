//
//  CHTabBarVC.m
//  WB
//
//  Created by 刘生文 on 13/3/14.
//  Copyright © 2013年 刘生文. All rights reserved.
//
#import "CHTabBarVC.h"
#import "CHHomeVC.h"
#import "CHMessageVC.h"
#import "CHDiscoverVC.h"
#import "CHProfileVC.h"
#import "CHTabBar.h"
#import "CHNavVC.h"
#import "CHUserTool.h"
#import "CHUserResult.h"
#import "CHAccountTool.h"
#import "SVProgressHUD.h"
#import "CHComposeVC.h"

@interface CHTabBarVC ()<CHTabBarDelegate>
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) CHHomeVC *home;
@property (nonatomic, weak) CHMessageVC *message;
@property (nonatomic, weak) CHProfileVC *profile;
@end

@implementation CHTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1、添加所有子控制器
    [self setUpChildVC];
    // 2、自定义tabBar
    [self setUpTabBar];
    // 3、每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
}

// 请求未读数
- (void)requestUnread
{
    // 请求微博的未读数
    [CHUserTool unreadWithSuccess:^(CHUserResult *result) {
        // 设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        // 设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        // 设置应用程序所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition:YES animated:animated];
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

#pragma mark - 4、当点击tabBar上的按钮时调用------

- (void)tabBarDidClickPlusButton:(CHTabBar *)tabBar
{
    // 创建发送微博控制器
    CHComposeVC *composeVc = [[CHComposeVC alloc] init];
    CHNavVC *nav = [[CHNavVC alloc] initWithRootViewController:composeVc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)tabBar:(CHTabBar *)tabBar didClickButton:(NSInteger)index
{
    // 点击首页，刷新
    if (index == 0 && self.selectedIndex == index) {
        [_home refresh];
    }
    self.selectedIndex = index;
}

#pragma mark - 3、添加自定义tabBar------
- (void)setUpTabBar
{
    // 1、创建自定义的CHTabBar;
    CHTabBar *tabBar = [[CHTabBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    // 2、设置CHTabBar的Frame
    tabBar.frame = self.tabBar.bounds;
    // 设置代理
    tabBar.delegate = self;
    tabBar.items = self.items;
    // 3、添加CHTabBar到父控件
    [self.tabBar addSubview:tabBar];
}

#pragma mark - 2、添加所有的子控制器------

// 添加所有的子控制器
- (void)setUpChildVC
{
    // 首页
    CHHomeVC *home = [[CHHomeVC alloc] init];
    [self setUpOneChildVC:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
    // 消息
    CHMessageVC *massage = [[CHMessageVC alloc] init];
    [self setUpOneChildVC:massage image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    _message = massage;
    // 发现
    CHDiscoverVC *discover = [[CHDiscoverVC alloc] init];
    [self setUpOneChildVC:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    CHProfileVC *profile = [[CHProfileVC alloc] init];
    [self setUpOneChildVC:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    _profile = profile;
}

// 封装创建控制器方法
- (void)setUpOneChildVC:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectdeImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectdeImage;
    [self.items addObject:vc.tabBarItem];
    CHNavVC *nav = [[CHNavVC alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - 1、懒加载控件、初始化控件------

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

// 自定义了TabBarController 之后必须实现以下方法，

// 解决Unbalanced calls to begin/end appearance transitions for <>警告

-(void) viewDidAppear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}
-(void) viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}
@end


