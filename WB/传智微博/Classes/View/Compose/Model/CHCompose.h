//
//  CHCompose.h
//  WB
//
//  Created by 刘生文 on 13/3/29.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHCompose : NSObject

// 按钮的图片
@property (nonatomic,copy) NSString *icon;
// 按钮的标题
@property (nonatomic,copy) NSString *title;
// 控制器名称
@property (nonatomic, copy) NSString *classname;
// 存放类的数组
@property (nonatomic, strong) NSArray *array;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)composeWithDic:(NSDictionary *)dic;
+ (NSArray *)composeList;
@end
