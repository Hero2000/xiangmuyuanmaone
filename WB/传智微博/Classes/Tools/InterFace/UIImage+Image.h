//
//  UIImage+Image.h
//  WB
//
//  Created by 刘生文 on 12/01/01.
//  Copyright © 2012年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;
// 加载图片时，进行拉伸
+ (instancetype)imageWithStretchableName:(NSString *)imageName;
@end
