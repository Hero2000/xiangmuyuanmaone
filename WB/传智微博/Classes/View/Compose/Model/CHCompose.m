//
//  CHCompose.m
//  WB
//
//  Created by 刘生文 on 13/3/29.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHCompose.h"

@implementation CHCompose

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)composeWithDic:(NSDictionary *)dic;
{
    return [[self alloc] initWithDic:dic];
}

+ (NSArray *)composeList
{
    // 1、加载plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"compose" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    // 2、字典转模型
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in dicArray) {
        CHCompose *compose = [CHCompose composeWithDic:dic];
        [array addObject:compose];
    }
    return array;
}
@end
