//
//  CHStatusFrame.m
//  WB
//
//  Created by 刘生文 on 13/3/28.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHStatusFrame.h"
#import "CHStatus.h"
#import "CHUser.h"

@implementation CHStatusFrame

#pragma mark - 4、计算原创微博
- (void)setStatus:(CHStatus *)status
{
    _status = status;
    // 计算原创微博
    [self setUpOriginalViewFrame];
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    // 转发微博
    if (status.retweeted_status) {
        // 计算转发微博
        [self setUpRetweetViewFrame];
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = CHScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame) + 10;
}

#pragma mark - 1、计算原创微博
- (void)setUpOriginalViewFrame
{
    // 头像
    CGFloat imageX = CHStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + CHStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:CHNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + CHStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + CHStatusCellMargin;
    
    CGFloat textW = CHScreenW - 2 * CHStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:CHTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + CHStatusCellMargin;
    // 配图
    if (_status.pic_urls.count) {
        CGFloat photosX = CHStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + CHStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + CHStatusCellMargin;
    }
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = CHScreenW;
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
}
#pragma mark - 2、计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4 ? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * CHStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * CHStatusCellMargin;
    return CGSizeMake(w, h);
}

#pragma mark - 3、计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = CHStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweetName sizeWithFont:CHNameFont];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + CHStatusCellMargin;
    CGFloat textW = CHScreenW - 2 * CHStatusCellMargin;
    // 注意：一定要是转发微博的正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:CHTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + CHStatusCellMargin;
    // 配图
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = CHStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + CHStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + CHStatusCellMargin;
    }
    // 转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = CHScreenW;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
}

@end
