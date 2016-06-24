//
//  CHUserParam.m
//  WB
//
//  Created by 刘生文 on 13/3/27.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHUserParam.h"
#import "CHAccountTool.h"
#import "CHAccount.h"

@implementation CHUserParam

/**
 *  获取命令牌方法
 */
+ (instancetype)tokenParam
{
    CHUserParam *tokenParam = [[CHUserParam alloc] init];
    tokenParam.access_token = [CHAccountTool account].access_token;
    return tokenParam;
}

/**
 *  获取用户标识符方法
 */
+ (instancetype)uidParam
{
    CHUserParam *uidParam = [[CHUserParam alloc] init];
    uidParam.uid = [CHAccountTool account].uid;
    return uidParam;
}

@end
