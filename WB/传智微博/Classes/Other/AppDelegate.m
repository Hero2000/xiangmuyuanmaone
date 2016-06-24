//
//  AppDelegate.m
//  WB
//
//  Created by 刘生文 on 13/3/14.
//  Copyright © 2013年 刘生文. All rights reserved.
//

#import "AppDelegate.h"
#import "CHTabBarVC.h"
#import "CHAccountTool.h"
#import "CHRootTool.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1、设置窗口的Frame
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 2、选择根控制器
    // 判断有没有授权
    if ([CHAccountTool account]) {
        // 已经授权
        // 根据版本号，选择是否展示新特性控制器，还是进入主页
        [CHRootTool chooseRootViewController:self.window];
    }else{
        // 进行授权(进入未登陆页面)
        CHTabBarVC *oauthVc = [[CHTabBarVC alloc] init];
        // 设置窗口的根控制器
        self.window.rootViewController = oauthVc;
    }
    
    // 4、欢迎页面的通知
//    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:switchRootVC object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        self.window.rootViewController = [[CHTabBarVC alloc] init];
    }];
    // 3、将窗口进行显示
    [self.window makeKeyAndVisible];
    
    // 4、注册通知,用于未知数(提醒接口)
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    #pragma mark - 后台播放三 ------
    // 设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 单独播放一个后台程序
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    [session setActive:YES error:nil];
    
    return YES;
}

#pragma mark - 用于SDWebImage出现内存问题时，进行清除内存------
// 接收到内存警告的时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    // 停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

#pragma mark - 后台播放二 ------
// 002、失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    // 无限播放
    player.numberOfLoops = -1;
    [player play];
    _player = player;
}

#pragma mark - 后台播放一 ------
// 001、进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 开启一个后台任务,时间不确定，优先级比较低，假如系统要关闭应用，首先就考虑
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当后台任务结束的时候调用
        [application endBackgroundTask:ID];
    }];
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    // 微博：在程序即将失去焦点的时候播放静音音乐.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
