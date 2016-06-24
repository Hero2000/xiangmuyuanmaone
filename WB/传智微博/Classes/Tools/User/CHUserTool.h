//
//  CHUserTool.h
//  WB
//
//  Created by 刘生文 on 13/3/27.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CHUserResult,CHUser;

@interface CHUserTool : NSObject

/**
 *  请求用户的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(CHUserResult *result))success failure:(void(^)(NSError *error))failure;
/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(CHUser *user))success failure:(void(^)(NSError *error))failure;

@end
