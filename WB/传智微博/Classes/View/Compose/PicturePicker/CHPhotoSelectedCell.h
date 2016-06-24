//
//  CHPhotoSelectedCell.h
//  WB
//
//  Created by 刘生文 on 13/3/2.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHPhotoSelectedCell;
// 定义cell中删除按钮的代理方法
@protocol CHPhotoSelectedCellDelegate <NSObject>
- (void)photoSelectedCellDidClickDeleteButton:(CHPhotoSelectedCell *)cell;
@end
@interface CHPhotoSelectedCell : UICollectionViewCell
// 在cell中添加的图片
@property (nonatomic, strong) UIImage *image;
// 代理属性
@property (nonatomic, weak) id<CHPhotoSelectedCellDelegate> delegate;
@end
