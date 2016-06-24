//
//  CHRootTool.m
//  WB
//
//  Created by 刘生文 on 13/3/25.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHRootTool.h"
#import "CHNewFeatureVC.h"
#import "CHWelcomeVC.h"
#define CHVersionKey @"version"

@implementation CHRootTool

// 选择根控制器的方法
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 1、获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 2、获取上一次的版本号(通过键从用户偏好里取)
    // 偏好设置传出的好处：1、不需要关心文件名；2、快速进行键值对存储；
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:CHVersionKey];
    // 3、判断当前是否有新版本
    if ([currentVersion isEqualToString:lastVersion]) {
        // 相等的话没有新的版本号
        // 创建tabBarVC
        CHWelcomeVC *tb = [[CHWelcomeVC alloc] init];
        // 设置窗口的根控制器
        window.rootViewController = tb;
    }else{
        // 有新的版本号
        // 创建新特性界面
        CHNewFeatureVC *vc = [[CHNewFeatureVC alloc] init];
        // 设置窗口的根控制器
        window.rootViewController = vc;
        // 保持当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:CHVersionKey];
    }
}

@end
