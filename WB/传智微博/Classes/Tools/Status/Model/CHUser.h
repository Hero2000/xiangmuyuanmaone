//
//  CHUser.h
//  WB
//
//  Created by 刘生文 on 13/3/26.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

/** 是否是会员 */
@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
