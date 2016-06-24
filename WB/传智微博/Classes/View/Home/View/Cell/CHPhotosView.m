//
//  CHPhotosView.m
//  WB
//
//  Created by 刘生文 on 13/3/28.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHPhotosView.h"
#import "CHPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "CHPhoteView.h"

@implementation CHPhotosView

#pragma mark - 1、初始化控件------
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加9个子控件
        [self setUpAllChildView];
    }
    return self;
}

// 添加9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
        CHPhoteView *imageV = [[CHPhoteView alloc] init];
        imageV.tag = i;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
}

#pragma mark - 点击图片的时候调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    // 2、将自己的CHPhoto -> 转变为MJPhoto
    UIImageView *tapView = tap.view;
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (CHPhoto *photo in _pic_urls) {
        // 2、所有的图片对象MJPhoto
        MJPhoto *p = [[MJPhoto alloc] init];
        // 对URL进行处理
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        // 设置MJPhoto的URL，索引，来源
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    // 弹出图片浏览器
    // 1、创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    // 2、所有的图片对象MJPhoto
    brower.photos = arrM;
    // 3、当前展示的图片索引
    brower.currentPhotoIndex = tapView.tag;
    // 4、显示
    [brower show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    int count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        CHPhoteView *imageV = self.subviews[i];
        if (i < _pic_urls.count) { // 显示
            imageV.hidden = NO;
            // 获取CZPhoto模型
            CHPhoto *photo = _pic_urls[i];
            imageV.photo = photo;
        }else{
            imageV.hidden = YES;
        }
    }
}

// 计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count == 4 ? 2 : 3;
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
}

@end
