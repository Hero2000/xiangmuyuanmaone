//
//  CHTextView.h
//  WB
//
//  Created by 刘生文 on 13/3/30.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTextView : UITextView
// 占位字符
@property (nonatomic, copy) NSString *placeHolder;
// 是否隐藏占位符
@property (nonatomic, assign) BOOL hidePlaceHolder;
@end
