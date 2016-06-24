//
//  CHMessageVC.m
//  WB
//
//  Created by 刘生文 on 13/3/14.
//  Copyright © 2013年 刘生文. All rights reserved.
//

#import "CHMessageVC.h"

@interface CHMessageVC ()

@end

@implementation CHMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpImageName:@"visitordiscover_image_message" title:@"登陆后，别人评论的微博，发给你的消息，都会在这里收到通知" loginSuccess:^{
        // 创建导航条
        [self setUpNavgationBar];
    }];
}

- (void)setUpNavgationBar
{
    // 设置UIBarButtonItem
    UIBarButtonItem *chat = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天"  style:UIBarButtonItemStyleBordered target:self action:@selector(chat)];
    // 设置为右边按钮
    self.navigationItem.rightBarButtonItem = chat;
}

// 按钮监听方法
- (void)chat
{
    DDLog();
}

@end
