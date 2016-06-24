//
//  CHOAuthVC.m
//  WB
//
//  Created by 刘生文 on 13/3/24.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHOAuthVC.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "CHAccountTool.h"
#import "CHRootTool.h"

@interface CHOAuthVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation CHOAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载webView的登录网页
    [self loadOAuthView];
    [self setUpUI];
//    [self test];
    
}
- (void)setUpUI
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissInput)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"自动填充" style:UIBarButtonItemStylePlain target:self action:@selector(autoFull)];
    self.navigationItem.title = @"微博登录";
}

- (void)dismissInput
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)autoFull
{
    NSString *js = @"document.getElementById('userId').value = 'daoge10000@sina.cn';" \
    "document.getElementById('passwd').value = 'qqq123';";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}
// 加载webView的登录网页
- (void)loadOAuthView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    // 简单的GET请求
    // 用ID和回调的URL，进行请求
    // 1、拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",CHBaseUrl,CHClient_id,CHRedirect_uri];
    // 2、创建请求的URL
    NSURL *url = [NSURL URLWithString:urlStr];
    // 3、创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4、加载网络请求
    [webView loadRequest:request];
    // 5、在代理方法中进行处理
    webView.delegate = self;
    _webView = webView;
}

#pragma mark - UIWebView的代理------
// webview加载开始的时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 提示用户正在加载...
    [SVProgressHUD showWithStatus:@"正在加载..."];
}
// webview加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

// webview加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
}

//webView.stringByEvaluatingJavaScriptFromString(jsString)
// 拦截webView请求
// 当Webview需要加载一个请求的时候，就会调用这个方法，询问下是否请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 获取所有拦截的数据
    NSString *urlStr = request.URL.absoluteString;
    // 从 code= 标识处进行截取
    // 获取指定短字符串在长字符串中的开始，结尾索引值；
    NSRange range = [urlStr rangeOfString:@"code="];
    // 有 code= 时，开始进行处理
    if (range.length) {
        // 从字符串的开头一直截取到指定的位置，但不包括该位置的字符
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        // 换取accessToken(获取标识钥匙)
        [self accessTokenWithCode:code];
        // 不会去加载回调界面
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    [CHAccountTool accountWithCode:code success:^{
        // 工具类网络请求响应成功后，通过保存的响应数据选择根控制器
        [CHRootTool chooseRootViewController:CHKeyWindow];
    } failure:^{

    }];
}

//"access_token" = "2.00ml8IrF6dP8NE58556ed6cef3SP7C";
//"expires_in" = 157679999;
//"remind_in" = 157679999;
//uid = 5365823342;

- (void)test
{
    NSString *urlStr = @"http://127.0.0.1/login.php";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"password" : @"a8d9ca0dcdc4a08e09be837cde0b7b13", @"username" : @"zhangsan"};
    // GET方法
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@  %@", responseObject, [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end















