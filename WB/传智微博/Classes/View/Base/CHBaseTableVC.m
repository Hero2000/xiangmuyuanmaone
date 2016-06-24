//
//  CHBaseTableVC.m
//  WB
//
//  Created by 刘生文 on 13/3/24.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHBaseTableVC.h"
#import "CHVisitorView.h"
#import "CHOAuthVC.h"
#import "CHAccountTool.h"

@interface CHBaseTableVC ()
@property (nonatomic, assign) BOOL userLogin;
@property (nonatomic, strong) CHVisitorView *visitorView;
@end

@implementation CHBaseTableVC



// 在这个方法里面判断如果用户没有登录,就不执行 super.loadView, view 让我们自己来定义
- (void)loadView
{
    // 用户是否登录的标记
    _userLogin = [CHAccountTool account];
    _userLogin ? [super loadView] : [self loadVisitorView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 未登录时，对视图进行调用
- (void)loadVisitorView
{
    _visitorView = [[CHVisitorView alloc] init];
    self.view = _visitorView;
}

// 设置界面
- (void)setUpImageName:(NSString *)imageName title:(NSString *)title loginSuccess:(void (^)())loginSuccess {
    // 设置未登录的导航栏信息
    if (!_userLogin) {
        // 设置导航条按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(userRegister)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(userLogin)];
        
        // 设置访客视图
        [self.visitorView setUpInfo:imageName title:title];
        
        // 添加按钮监听方法
        [self.visitorView.registerBtn addTarget:self action:@selector(userRegister) forControlEvents:UIControlEventTouchUpInside];
        [self.visitorView.loginBtn addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];

    } else if (loginSuccess != nil) {
        loginSuccess();
    }
}

- (void)userRegister
{
    DDLog();
}

- (void)userLogin
{
    CHOAuthVC *oauth = [[CHOAuthVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:oauth];
    // 将 self 改为self.view.window.rootViewController不会出现警告
    [self.view.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
