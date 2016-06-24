//
//  CHStatusResult.m
//  WB
//
//  Created by 刘生文 on 13/3/26.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHStatusResult.h"
#import "CHStatus.h"
#import "CHUser.h"
#import "CHPhoto.h"

@implementation CHStatusResult
/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class
 */
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses":[CHStatus class]};
}
@end






