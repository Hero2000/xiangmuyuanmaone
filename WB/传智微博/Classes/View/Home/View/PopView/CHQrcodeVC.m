//
//  CHQrcodeVC.m
//  WB
//
//  Created by 刘生文 on 13/3/23.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHQrcodeVC.h"
#import <CoreImage/CoreImage.h>

@interface CHQrcodeVC ()

@property (nonatomic, weak) UIImageView *qrcodeImageView;

@end

@implementation CHQrcodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self produceQrcode];
}

// 将数据生成二维码进行绘制
- (void)produceQrcode
{
    // 1、创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2、还原滤镜默认属性
    [filter setDefaults];
    // 3、将需要生成二维码的数据转换为二进制
    NSData *data = [@"我想你了，亲爱的！" dataUsingEncoding:NSUTF8StringEncoding];
    // 4、给滤镜设置数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 5、生成图片
    CIImage *qrcodeImage = [filter outputImage];
    // 6、显示图片
    self.qrcodeImageView.image = [self createNonInterpolatedUIImageFormCIImage:qrcodeImage withSize:200];
    // 7、将图标放到生成的二维码上
    UIImageView *icon = [[UIImageView alloc] init];
    icon.frame = CGRectMake(70, 70, 60, 60);
    icon.backgroundColor = [UIColor lightGrayColor];
    UIImage *image = [UIImage imageNamed:@"spider"];
    icon.image = image;
    [self.qrcodeImageView addSubview:icon];
}

// 将二维码按照尺寸进行清晰化
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1、创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2、保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

// 创建视图控件
- (void)setUpUI
{
    // 二维码生成框
    UIImageView *qrcode = [[UIImageView alloc] init];
    qrcode.frame = CGRectMake(0, 0, 200, 200);
    qrcode.backgroundColor = [UIColor grayColor];
    UIImage *image = [UIImage imageWithStretchableName:@"qrcode_embeddedimage_shadow"];
    qrcode.image = image;
    [self.view addSubview:qrcode];
    qrcode.centerX = self.view.centerX;
    qrcode.centerY = self.view.centerY - 140;
    _qrcodeImageView = qrcode;
    // 创建标签一
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(0, 0, 100, 30);
//    label1.backgroundColor = [UIColor redColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.centerX = self.view.centerX;
    label1.centerY = self.view.centerY - 5;
    label1.font = [UIFont systemFontOfSize:16];
    label1.numberOfLines = 0;
    label1.text = @"极客江南";
    [self.view addSubview:label1];
    // 创建标签二
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(0, 0, 200, 20);
//    label2.backgroundColor = [UIColor redColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.centerX = self.view.centerX;
    label2.centerY = self.view.centerY + 20;
    label2.font = [UIFont systemFontOfSize:12];
    label2.numberOfLines = 0;
    label2.text = @"扫一扫二维码，关注微吧";
    [self.view addSubview:label2];
}


@end
