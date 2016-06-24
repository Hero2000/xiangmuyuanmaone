//
//  CHStatusToolBar.h
//  WB
//
//  Created by 刘生文 on 13/3/28.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHStatus;
@interface CHStatusToolBar : UIImageView
// 工具条的Frame不需要跟内容关联，只需要模型就可以
@property (nonatomic, strong) CHStatus *status;
@end
