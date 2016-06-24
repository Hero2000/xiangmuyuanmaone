//
//  CHUserResult.m
//  WB
//
//  Created by 刘生文 on 13/3/27.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHUserResult.h"

@implementation CHUserResult

/**
 *  消息的总和
 */
- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

/**
 *  未读数的总和
 */
- (int)totoalCount
{
    return self.messageCount + _status + _follower;
}
@end
