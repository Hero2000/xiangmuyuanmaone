//
//  CHStatusResult.h
//  WB
//
//  Created by 刘生文 on 13/3/26.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface CHStatusResult : NSObject

/**
 *  用户的微博数组（CZStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int total_number;


@end
