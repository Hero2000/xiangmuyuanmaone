//
//  CHNewFeatureVC.m
//  WB
//
//  Created by 刘生文 on 13/3/23.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHNewFeatureVC.h"
#import "CHTabBarVC.h"

@interface CHNewFeatureVC ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIButton *shareBtn;
@property (nonatomic, weak) UIButton *startBtn;
@property (nonatomic, weak) UIPageControl *control;

@end

@implementation CHNewFeatureVC

NSUInteger count = 4;

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = YES;
    // 添加 collectionView 的属性
    [self setupScrollView];
    // 添加 pageController
    [self setUpPageController];
}

//添加UISrollView
- (void)setupScrollView
{
    // 添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //1 动态生成5个imageView
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    //1 动态生成5个imageView
    for (int i = 0; i < count; i++) {
        // 创建UIImageView
        UIImageView *imageV = [[UIImageView alloc] init];
        // 拼接图片名称 3.5寸的是320*480
        if (screenH > 480) {
            NSString *imageN = [NSString stringWithFormat:@"new_feature_%ldbig",i+1];
            imageV.image = [UIImage imageNamed:imageN];
        }else{
            NSString *imageN = [NSString stringWithFormat:@"new_feature_%ld",i+1];
            imageV.image = [UIImage imageNamed:imageN];
        }
        [scrollView addSubview:imageV];
        // 设置frame
        imageV.y = 0;
        imageV.width = imageW;
        imageV.height = imageH;
        imageV.x = i * imageW;
        self.shareBtn.hidden = YES;
        self.startBtn.hidden = YES;
        // 给最后一个imageView添加按钮
        if (i == count - 1) {
            [self setUpLastImageView:imageV];
        }
        CGFloat x = i * imageW;
        //frame
        imageV.frame = CGRectMake(x, 0, imageW, imageH);
    }
    //2 设置滚动范围
    scrollView.contentSize = CGSizeMake(count * imageW, 0);
    _control.numberOfPages = count;
}

- (void)setUpLastImageView:(UIImageView *)lastPage
{
    lastPage.userInteractionEnabled = YES;
    // 分享按钮
    self.shareBtn.center = CGPointMake(lastPage.frame.size.width * 0.5, lastPage.frame.size.height * 0.7);
    // 开始按钮
    self.startBtn.center = CGPointMake(lastPage.frame.size.width * 0.5, lastPage.frame.size.height * 0.78);
    // 最后一页,显示分享和开始按钮
    self.shareBtn.hidden = NO;
    self.startBtn.hidden = NO;
    [lastPage addSubview:_shareBtn];
    [lastPage addSubview:_startBtn];
}

#pragma mark - UIScrollView代理------
// 只要一滚动就调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    NSUInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    // 设置页数
    _control.currentPage = page;
}

// 添加pageController
- (void)setUpPageController
{
    // 添加 pageController，只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = count;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.9);
    [self.view addSubview:control];
    _control = control;
}

#pragma mark - 1、懒加载控件、初始化控件------
// 创建分享按钮
- (UIButton *)shareBtn
{
    if (_shareBtn == nil) {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn1 sizeToFit];
        [btn1 addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
        _shareBtn = btn1;
    }
    return _shareBtn;
}
// 分享按钮的监听方法
- (void)share:(UIButton *)btn
{
    btn.selected = !btn.selected;
}
// 创建开始按钮
- (UIButton *)startBtn
{
    if (_startBtn == nil) {
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setTitle:@"开始微博" forState:UIControlStateNormal];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [btn2 sizeToFit];
        [btn2 addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn2];
        _startBtn = btn2;
    }
    return _startBtn;
}

// 点击开始微博的时候调用
- (void)start
{
    // 进入tabBarVC
    CHTabBarVC *tbVC = [[CHTabBarVC alloc] init];
    // 切换根控制器：可以直接把之前的根控制器清空
    CHKeyWindow.rootViewController = tbVC;
}

@end
















