//
//  CHOriginaView.h
//  WB
//
//  Created by 刘生文 on 13/3/28.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHStatusFrame;
@interface CHOriginaView : UIImageView

// 转发微博内容会变动，使用VM模型
@property (nonatomic, strong) CHStatusFrame *statusF;
@end
