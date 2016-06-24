//
//  CHTwoVC.m
//  WB
//
//  Created by 刘生文 on 13/3/22.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHTwoVC.h"
#import "CHQrcodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "UIBarButtonItem+Item.h"

@interface CHTwoVC ()<AVCaptureMetadataOutputObjectsDelegate>
// 冲击波
@property (nonatomic, weak) UIImageView *wave;
// 会话
@property (nonatomic, strong) AVCaptureSession *session;
// 预览界面
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewLayer;
// 定时器
@property (nonatomic, strong) NSTimer *timer;
// 扫描窗口
@property (nonatomic, strong) UIImageView *border;

@end

@implementation CHTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1、添加imageView控件
    [self setUpUI];
    [self setUpNavgationBar];
#pragma mark - 重要属性------
    _border.clipsToBounds = YES;
    // 2、使用定时器自动扫描
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(imageAnimation) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop mainRunLoop];
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    _timer = timer;
    // 3、扫描二维码
//    [self scanQrcode];
}


- (void)scanQrcode
{
    // 1、获取输入设备
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 2、根据输入设备创建输入对象
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:inputDevice error:NULL];
    // 3、创建输出对象
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 4、设置输出对象代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 5、创建回话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    // 6、将输入和输出添加到会话中
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    // 7、输出的类型(一定要在输入对象添加到会话后再设置，否则会报错)
    // 告诉输出对象能够解析什么类型的数据
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    // 设置预览界面
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    _previewLayer = previewLayer;
    // 8、开始聚集数据(扫描二维码是一个持久的操作)
    [session startRunning];
}


#pragma mark - 代理方法------
// 只要解析到了数据就会调用(该方法的调用频率非常高)
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 1、判断是否解析到了数据
    if (metadataObjects.count > 0) {
        // 2、停止
        [self.session stopRunning];
        // 3、移除预览界面
        [_previewLayer removeFromSuperlayer];
        // 4、取出数据
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        // 将二维码数据转换成内容
        CHLog(@"%@",obj.stringValue);
        // 5、停止动画
        [_timer invalidate];
        _timer = nil;
        // 6、显示数据
        UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
        label.numberOfLines = 0;
        label.text = obj.stringValue;
        [self.view addSubview:label];
    }
}


- (void)setUpUI
{
    // 扫描的边境框
    UIImageView *border = [[UIImageView alloc] init];
    border.frame = CGRectMake(0, 0, 218, 218);
    border.backgroundColor = [UIColor lightGrayColor];
    UIImage *image1 = [UIImage imageWithStretchableName:@"qrcode_border"];
    border.image = image1;
    [self.view addSubview:border];
    border.centerX = self.view.centerX;
    border.centerY = self.view.centerY - 30;
    _border = border;
    // 扫描的冲击波
    UIImageView *wave = [[UIImageView alloc] init];
    wave.frame = CGRectMake(0, -170, 218, 170);
    UIImage *image2 = [UIImage imageWithStretchableName:@"qrcode_scanline_qrcode"];
    wave.image = image2;
    [border addSubview:wave];
    _wave = wave;
    // 创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"我的名片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:@"qrcode_button_background"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 470, 85, 28);
    btn.centerX = border.centerX;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(meQrcode) forControlEvents:UIControlEventTouchUpInside];
}

- (void)meQrcode
{
    CHQrcodeVC *meQrcode = [[CHQrcodeVC alloc] init];
    [self.navigationController pushViewController:meQrcode animated:YES];
}

- (void)imageAnimation
{
    _wave.transform = CGAffineTransformMakeTranslation(0,0);
    [UIView animateWithDuration:2.5 animations:^{
        _wave.transform = CGAffineTransformMakeTranslation(0,388);
    }];
}

- (void)setUpNavgationBar
{
    UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
    // 设置导航条的按钮
    self.navigationItem.leftBarButtonItem = left;
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)popToRoot
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)popToPre
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
