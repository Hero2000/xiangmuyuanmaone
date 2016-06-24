//
//  CHUserParam.h
//  WB
//
//  Created by 刘生文 on 13/3/27.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHUserParam : NSObject

/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  获取命令牌方法
 */
//+ (instancetype)tokenParam;
/**
 *  获取用户标识符方法
 */
//+ (instancetype)uidParam;

@end
