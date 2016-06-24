//
//  CHAccountTool.m
//  WB
//
//  Created by 刘生文 on 13/3/25.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHAccountTool.h"
#import "CHAccountParam.h"
#import "CHHttpTool.h"
#import "CHAccount.h"
#import "MJExtension.h"

#define CHAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation CHAccountTool

// 类方法一般用静态变量代替成员属性
static CHAccount *_account;

// 通过模型类，将过期时间转为真假，用于token是否过期，判断是否需要登录
+ (CHAccount *)account
{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:CHAccountFileName];
        // 判断下账号是否过期，如果过期直接返回Nil
        // 当前时间大于过期时间(Ascend表示升序)，返回为nil
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    return _account;
}

// 将转换成的模型数据保存到用户偏好中
+ (void)saveAccount:(CHAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:CHAccountFileName];
}

// 使用code码进行网络请求，获取用户消息及token，进行保存
+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)())failure
{
    // 创建参数模型
    CHAccountParam *param = [[CHAccountParam alloc] init];
    param.client_id = CHClient_id;
    param.client_secret = CHClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = CHRedirect_uri;
    [CHHttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.mj_keyValues success:^(id responseObject) {
        // 成功网络请求后，将响应字典
        // 字典转模型
        CHLog(@"%@",responseObject);
        CHAccount *account = [CHAccount accountWithDic:responseObject];
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        [CHAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end








