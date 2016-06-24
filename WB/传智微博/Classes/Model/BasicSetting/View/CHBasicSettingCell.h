//
//  CHBasicSettingCell.h
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHRowItem;
@interface CHBasicSettingCell : UITableViewCell
// 存放cell的模型
@property (nonatomic, strong) CHRowItem *item;
// 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
// 设置cell的背景图片，并进行拉伸
- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)rowCount;
@end
