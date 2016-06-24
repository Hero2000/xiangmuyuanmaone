//
//  CHRetweetView.m
//  WB
//
//  Created by 刘生文 on 13/3/28.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHRetweetView.h"
#import "CHStatus.h"
#import "CHStatusFrame.h"
#import "CHPhotosView.h"

@interface CHRetweetView ()

// 昵称
@property (nonatomic, weak) UILabel *nameView;

// 正文
@property (nonatomic, weak) UILabel *textView;

// 配图
@property (nonatomic, weak) CHPhotosView *photosView;

@end

@implementation CHRetweetView

#pragma mark - 2、重写set方法来设置控件的Frame和内容------
- (void)setStatusF:(CHStatusFrame *)statusF
{
    _statusF = statusF;
    CHStatus *status = statusF.status;
    
    // 昵称
    _nameView.frame = statusF.retweetNameFrame;
    _nameView.text = status.retweetName;
    
    // 正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
    
    // 配图
    _photosView.frame = statusF.retweetPhotosFrame;
    
    // 注意：这里一定要转让转发微博的配图数
    _photosView.pic_urls = status.retweeted_status.pic_urls;
    
}

#pragma mark - 1、初始化控件------
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.textColor = [UIColor blueColor];
    nameView.font = CHNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CHTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    // 配图
    CHPhotosView *photosView = [[CHPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

@end
