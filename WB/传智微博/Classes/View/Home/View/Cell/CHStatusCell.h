//
//  CHStatusCell.h
//  WB
//
//  Created by 刘生文 on 13/3/28.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHStatusFrame;
@interface CHStatusCell : UITableViewCell

@property (nonatomic, strong) CHStatusFrame *statusF;
// 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
