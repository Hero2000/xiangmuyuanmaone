//
//  CHUserResult.h
//  WB
//
//  Created by 刘生文 on 13/3/27.
//  Copyright © 2013年 apple. All rights reserved.
//
/*
 * status	       int  新微博未读数
 * follower	       int  新粉丝数
 * cmt	           int  新评论数
 * dm	           int  新私信数
 * mention_status  int  新提及我的微博数
 * mention_cmt	   int  新提及我的评论数
 */
#import <Foundation/Foundation.h>

@interface CHUserResult : NSObject
/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;
/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;
/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;
/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;
/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;
/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  消息的总和
 */
- (int)messageCount;

/**
 *  未读数的总和
 */
- (int)totoalCount;

@end
