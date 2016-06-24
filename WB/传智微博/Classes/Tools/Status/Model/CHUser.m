//
//  CHUser.m
//  WB
//
//  Created by 刘生文 on 13/3/26.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHUser.h"

@implementation CHUser

// 会员类型
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}
@end
