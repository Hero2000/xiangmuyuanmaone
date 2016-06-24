//
//  CHStatusFrame.h
//  WB
//
//  Created by 刘生文 on 13/3/28.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CHStatus;

@interface CHStatusFrame : NSObject

/**
 *  微博数据
 */
@property (nonatomic, strong) CHStatus *status;

// 原创微博frame(总和)
@property (nonatomic, assign) CGRect originalViewFrame;

/**
 *  原创微博子控件frame
 */
// 头像Frame
@property (nonatomic, assign) CGRect originalIconFrame;

// 昵称Frame
@property (nonatomic, assign) CGRect originalNameFrame;

// vipFrame
@property (nonatomic, assign) CGRect originalVipFrame;

// 时间Frame
@property (nonatomic, assign) CGRect originalTimeFrame;

// 来源Frame
@property (nonatomic, assign) CGRect originalSourceFrame;

// 正文Frame
@property (nonatomic, assign) CGRect originalTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect originalPhotosFrame;

// 转发微博frame(总和)
@property (nonatomic, assign) CGRect retweetViewFrame;

/**
 *  转发微博子控件frame
 */
// 昵称Frame
@property (nonatomic, assign) CGRect retweetNameFrame;

// 正文Frame
@property (nonatomic, assign) CGRect retweetTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect retweetPhotosFrame;

// 工具条frame
@property (nonatomic, assign) CGRect toolBarFrame;

// cell的高度(总和)
@property (nonatomic, assign) CGFloat cellHeight;

@end
