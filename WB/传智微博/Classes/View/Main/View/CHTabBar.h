//
//  CHTabBar.h
//
//  Created by LSW on 12/01/01.
//  Copyright © 2012年 LSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHTabBar;

@protocol CHTabBarDelegate <NSObject>

@optional

// 点击tabBarButton按钮的时候调用
- (void)tabBar:(CHTabBar *)tabBar didClickButton:(NSInteger)index;

// 点击加号按钮的时候调用
- (void)tabBarDidClickPlusButton:(CHTabBar *)tabBar;

@end

@interface CHTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

// tabBar上按钮进行监听的代理属性
@property (nonatomic, weak) id<CHTabBarDelegate> delegate;

@end
