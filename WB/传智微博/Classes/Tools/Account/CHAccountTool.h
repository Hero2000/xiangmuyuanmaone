//
//  CHAccountTool.h
//  WB
//
//  Created by 刘生文 on 13/3/25.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CHAccount;

@interface CHAccountTool : NSObject

// 将转换成的模型数据保存到用户偏好中
+ (void)saveAccount:(CHAccount *)account;

// 通过模型类，将过期时间转为真假，用于token是否过期，判断是否需要登录
+ (CHAccount *)account;

// 使用code码进行网络请求，获取用户消息及token，进行保存
+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)())failure;

@end
