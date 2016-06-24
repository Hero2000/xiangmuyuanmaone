//
//  CHDiscoverVC.m
//  WB
//
//  Created by 刘生文 on 13/3/17.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHDiscoverVC.h"
#import "CHSearchBar.h"

@interface CHDiscoverVC ()<UITextFieldDelegate>

@property (nonatomic, weak) CHSearchBar *searchTF;

@end

@implementation CHDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpImageName:@"visitordiscover_image_message" title:@"登陆后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过" loginSuccess:^{
        // 创建导航条搜索框
        [self setUpSearchBar];
    }];
}

- (void)setUpSearchBar
{
    // 1、创建自定义的searchBar
    CHSearchBar *searchTF = [[CHSearchBar alloc] init];
    searchTF.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
    // 2、把自定义的View放到navigationItem上
    self.navigationItem.titleView = searchTF;
    // 3、监听输入框的代理
    searchTF.delegate = self;
    // 4、把自定义的View保存到控制器内
    _searchTF = searchTF;
}

#pragma mark - 输入框开始编辑时调用(代理方法)------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 1、添加按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancle)];
    // 2、替换leftView
    self.searchTF.leftViewName = @"settings_statistic_triangle";
}


// 监听取消按钮事件
- (void)cancle
{
    // 1、清除取消按钮
    self.navigationItem.rightBarButtonItem = nil;
    // 2、关闭键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    // 3、还原leftView
    self.searchTF.leftViewName = @"searchbar_textfield_search_icon";

}

#pragma mark - 监听scrollView拖拽时调用(代理方法)------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 1、关闭键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
@end

