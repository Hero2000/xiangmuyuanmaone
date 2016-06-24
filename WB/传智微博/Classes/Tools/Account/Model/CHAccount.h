//
//  CHAccount.h
//  WB
//
//  Created by 刘生文 on 13/3/25.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "access_token" = "2.00rgrSmFbkehbC7e6d1c76a9ZumKNB";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5294424581;
 */

@interface CHAccount : NSObject<NSCoding>
/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 *   过期时间 = 当前保存时间+有效期
 */
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  用户的昵称(附加的属性)
 */
@property (nonatomic, copy) NSString *name;

/**
 *  微博头像(附加的属性)
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/**
 *  将请求的数据进行转模型操作
 */
+ (instancetype)accountWithDic:(NSDictionary *)dic;

@end
