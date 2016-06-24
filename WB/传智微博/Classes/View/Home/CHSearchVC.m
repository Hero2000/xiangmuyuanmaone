//
//  CHSearchTabBarVC.m
//  WB
//
//  Created by 刘生文 on 13/3/22.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHSearchVC.h"
#import "CHNavVC.h"
#import "CHOneVC.h"
#import "CHTwoVC.h"
#import "UIBarButtonItem+Item.h"

@interface CHSearchVC ()

@end

@implementation CHSearchVC

+ (void)initialize
{
    // 获取当前这个类下面的所有tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    // 设置选择状态tabBarItem的颜色
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有子控制器
    [self setUpAllChildViewController];
}

- (void)setUpAllChildViewController
{
    // 二维码
    CHTwoVC *two = [[CHTwoVC alloc] init];
    [self setUpOneChildViewController:two image:[UIImage imageNamed:@"qrcode_tabbar_icon_qrcode"] selectedImage:[UIImage imageWithOriginalName:@"qrcode_tabbar_icon_qrcode_highlighted"] title:@"二维码"];
    
    // 条形码
    CHOneVC *one = [[CHOneVC alloc] init];
    [self setUpOneChildViewController:one image:[UIImage imageNamed:@"qrcode_tabbar_icon_barcode"] selectedImage:[UIImage imageWithOriginalName:@"qrcode_tabbar_icon_barcode_highlighted"] title:@"条形码"];
}

- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.navigationItem.title = title;
    vc.view.backgroundColor = [UIColor clearColor];
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    [vc.navigationController.navigationBar setBackgroundImage:[UIImage imageWithStretchableName:@"qrcode_navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    [vc.tabBarController.tabBar setBackgroundImage:[UIImage imageWithStretchableName:@"qrcode_tabbar_background"]];
    CHNavVC *nav = [[CHNavVC alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
