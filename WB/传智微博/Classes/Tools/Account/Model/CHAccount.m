//
//  CHAccount.m
//  WB
//
//  Created by 刘生文 on 13/3/25.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHAccount.h"
#import "MJExtension.h"

@implementation CHAccount

// 底层便利当前的类的所有属性，一个一个归档和接档
 MJCodingImplementation
// 通过有效期的set方法计算过期时间
// 过期参数是没有提供的
- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

// 对响应参数进行模型转字典(因为响应的参数是简单的字典，所有使用KVC方法)
+ (instancetype)accountWithDic:(NSDictionary *)dic
{
    CHAccount *account = [[CHAccount alloc] init];
    [account setValuesForKeysWithDictionary:dic];
    return account;
}

@end
