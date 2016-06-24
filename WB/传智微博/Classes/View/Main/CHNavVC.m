//
//  CHNavVC.m
//  WB
//
//  Created by 刘生文 on 13/3/15.
//  Copyright © 2013年 刘生文. All rights reserved.
//


#import "CHNavVC.h"
#import "UIBarButtonItem+Item.h"
#import "SVProgressHUD.h"
#import "CHTabBar.h"

@interface CHNavVC ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;
@end

@implementation CHNavVC
// 初始化控制器时进行设置
+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    // 设置navigation的代理方法
    self.delegate = self;
}

// 重写 push 方法中的内容进行自定义
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count != 0) {
        // 不是根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = right;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - 导航控制器代理方法------
// 导航控制器跳转完成的时候调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 显示根控制器
    if (viewController == self.viewControllers[0]) {
        // 还原滑动返回手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        // 不是显示根控制器
        // 实现滑动返回功能
        // 清空滑动返回手势代理，就可以实现滑动返回
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[CHTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
}


@end
