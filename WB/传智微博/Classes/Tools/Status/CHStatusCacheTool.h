//
//  CHStatusCacheTool.h
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CHStatusParam;
@interface CHStatusCacheTool : NSObject

+ (void)saveWithStatuses:(NSArray *)statuses;

+ (NSArray *)statusesWithParam:(CHStatusParam *)param;

@end
