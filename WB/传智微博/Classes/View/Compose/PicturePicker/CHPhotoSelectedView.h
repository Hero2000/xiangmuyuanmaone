//
//  CHPhotoSelectedVC.h
//  WB
//
//  Created by 刘生文 on 13/3/2.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHPhotoSelectedView : UICollectionView

// 照片数组
@property (nonatomic, strong) NSMutableArray *pictures;
// 添加一张照片
@property (nonatomic, strong) UIImage *image;

/* 实例化视图，并指定添加照片回调
 *
 * @param addImageCallBack 添加照片后要回调
 */
- (instancetype)initWithAddImageCallBack:(void (^)())addImageCallBack;
@end
