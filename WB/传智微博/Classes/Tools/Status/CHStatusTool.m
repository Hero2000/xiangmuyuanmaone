//
//  CHStatusTool.m
//  WB
//
//  Created by 刘生文 on 13/3/26.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHStatusTool.h"
#import "CHStatus.h"
#import "CHStatusParam.h"
#import "CHAccountTool.h"
#import "CHAccount.h"
#import "CHHttpTool.h"
#import "MJExtension.h"
#import "CHStatusResult.h"
#import "CHStatusCacheTool.h"

@implementation CHStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure
{
    // 创建参数模型
    CHStatusParam *param = [[CHStatusParam alloc] init];
    param.access_token = [CHAccountTool account].access_token;
    // 有微博数据，才需要下拉刷新
    if (sinceId) {
        param.since_id = sinceId;
    }
    // 先从数据库里面取数据(取数据从SQLite)
    NSArray *statuses = [CHStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    // 如果从数据库里面没有请求到数据，就向服务器请求
    [CHHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) { // HttpTool请求成功的回调
        // 请求成功代码先保存
        CHStatusResult *result = [CHStatusResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
        // 一定要保存服务器最原始的数据
        // 有新的数据，保存到数据库
        [CHStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void (^)(NSError *error))failure
{
    // 创建参数模型
    CHStatusParam *param = [[CHStatusParam alloc] init];
    param.access_token = [CHAccountTool account].access_token;
    // 有微博数据，才需要下拉刷新
    if (maxId) {
        param.max_id = maxId;
    }
    // 先从数据库里面取数据(取数据从SQLite)
    NSArray *statuses = [CHStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    [CHHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {
        // HttpTool请求成功的回调
        // 请求成功代码先保存
        // 把结果字典，转换成结果模型
        CHStatusResult *result = [CHStatusResult mj_objectWithKeyValues:responseObject];
        if (success) {
            // 数据放在结果模型的 statuses 元素里
            success(result.statuses);
        }
        // 一定要保存服务器最原始的数据
        // 有新的数据，保存到数据库(数据插入到SQLite数据库里)
        [CHStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
