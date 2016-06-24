//
//  CHUserTool.m
//  WB
//
//  Created by 刘生文 on 13/3/27.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHUserTool.h"
#import "CHUserParam.h"
#import "CHHttpTool.h"
#import "MJExtension.h"
#import "CHAccountTool.h"
#import "CHAccount.h"
#import "CHUserResult.h"
#import "CHUser.h"

@implementation CHUserTool

/**
 *  请求用户的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void (^)(CHUserResult *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    CHUserParam *param = [[CHUserParam alloc] init];
    param.access_token = [CHAccountTool account].access_token;
    param.uid = [CHAccountTool account].uid;
    [CHHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.mj_keyValues success:^(id responseObject) {
        // 字典转换模型
        CHUserResult *result = [CHUserResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void (^)(CHUser *))success failure:(void (^)(NSError *))failure {
    // 创建参数模型
    CHUserParam *param = [[CHUserParam alloc] init];
    param.access_token = [CHAccountTool account].access_token;
    param.uid = [CHAccountTool account].uid;
    [CHHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.mj_keyValues success:^(id responseObject) {
        // 用户字典转换用户模型
        CHUser *user = [CHUser mj_objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
