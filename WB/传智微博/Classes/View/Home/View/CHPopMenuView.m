//
//  CHPopMenuView.m
//  WB
//
//  Created by 刘生文 on 13/3/17.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHPopMenuView.h"

@implementation CHPopMenuView
// 弹出菜单
// block因为不是对象，所有默认在栈里面，栈里面的数据会自动被系统释放，为了能够保证以后调用block不被系统释放，那么就要将block转移到堆里面
// 只要对block进行copy操作，那么系统就会自动将我们的block保存起来
// 下面的是全局变量，加static，不让其他人用
static UIWindow *_window;
static dismissBlock _dismiss;
static UIViewController *_contentVC;

+ (void)popFrom:(UIView *)fromView content:(UIView *)content dismiss:(dismissBlock)dismiss
{
    [self popFromRect:fromView.frame inView:fromView.superview content:content dismiss:dismiss];
}


+ (void)popFrom:(UIView *)fromView contentVC:(UIViewController *)contentVC dismiss:(dismissBlock)dismiss
{
    // 保命
    _contentVC = contentVC;
    // 显示
    [self popFrom:fromView content:_contentVC.view dismiss:dismiss];
    
}

+ (void)popFromRect:(CGRect)fromRect inView:(UIView *)inView content:(UIView *)content dismiss:(dismissBlock)dismiss
{
    _dismiss = [dismiss copy];
    // 1、创建window
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.hidden = NO;
    _window.windowLevel = UIWindowLevelAlert;
    
    // 2、创建蒙板
    UIButton *cover = [[UIButton alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3、创建菜单的容器
    UIImageView *menuView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageWithStretchableName:@"popover_background"];
    menuView.image = image;
    #pragma mark - 存放容器的view要进行交互，在它上面的控件才能进行交互------
    menuView.userInteractionEnabled = YES;
    
    // 4、设置菜单内容的Frome
    // 设置内容的X和Y(间隙)，留个四方的边
    content.x = 15;
    content.y = 18;
    CGFloat menuViewW = CGRectGetMaxX(content.frame) + content.x;
    CGFloat menuViewH = CGRectGetMaxY(content.frame) + content.y;
    
    // 将fromView.frame的坐标系从fromVie.superview 转换到 _window中
    CGRect resultFrom = [_window convertRect:fromRect fromView:inView];
    
    // 设置菜单的Y值
    CGFloat menuViewY = CGRectGetMaxY(resultFrom);
    // 设置菜单的X值
    CGFloat menuViewX = CGRectGetMaxX(resultFrom) - (fromRect.size.width * 0.5) -(menuViewW * 0.5);
    // 设置控件的Frame
    menuView.frame = CGRectMake(menuViewX,menuViewY, menuViewW, menuViewH);
    
    // 5、添加控件到UI上
    // 将蒙板添加到window上
    [_window addSubview:cover];
    // 将菜单添加到蒙板上
    [cover addSubview:menuView];
    // 将内容添加到菜单上
    [menuView addSubview:content];
}
+ (void)coverClick:(UIButton *)btn
{
    _window.hidden = YES;
    _window = nil;
    if (_dismiss != nil ) {
        _dismiss();
    }
}

@end
