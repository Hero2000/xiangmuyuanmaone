//
//  CHComposeParam.h
//  WB
//
//  Created by 刘生文 on 13/3/30.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHComposeParam : NSObject
/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
// 上传的文本内容
@property (nonatomic, copy) NSString *status;
@end
