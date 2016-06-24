//
//  CHStatus.m
//  WB
//
//  Created by 刘生文 on 13/3/26.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHStatus.h"
#import "CHPhoto.h";
#import "NSDate+MJ.h"

@implementation CHStatus

/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (NSArray *)ignoredPropertyNames
{
    return @[@"retweetName"];
}

// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[CHPhoto class]};
}

#pragma mark - 响应参数进行设置------
// 创建时间格式进行转换和设置
- (NSString *)created_at
{
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    
    // 设置格式本地化,日期格式字符串需要知道是哪个国家的日期，才知道怎么转换
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    
    // 字符串转换NSDate
    NSDate *created_at = [fmt dateFromString:_created_at];
    // 时间显示设置
    if ([created_at isThisYear]) { // 今年(今天，昨天，前提)
        if ([created_at isToday]) { // 今天
            // 计算跟当前时间差距
            NSDateComponents *cmp = [created_at deltaWithNow];
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else{
                return @"刚刚";
            }
        }else if ([created_at isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return  [fmt stringFromDate:created_at];
        }else{ // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return  [fmt stringFromDate:created_at];
        }
    }else{ // 不是今年(显示年、月、日、时、分)
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    return _created_at;
}
// 微博来源
- (void)setSource:(NSString *)source
{
    //  <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    //  微博 weibo.com</a>
    //  abc>微 3 1
    //  微博 weibo.com
    if (source.length == 0)return;
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自%@",source];
    _source = source;
}

// 转发微博
- (void)setRetweeted_status:(CHStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}

@end
