//
//  CHBadgeView.h
//
//  Created by LSW on 12/01/01.
//  Copyright © 2012年 LSW. All rights reserved.
//

#import <UIKit/UIKit.h>
// 对类外部可调用属性进行声明
@interface CHBadgeView : UIButton

// 将小红点内部数字进行保存
@property (nonatomic, copy) NSString *badgeValue;

@end
