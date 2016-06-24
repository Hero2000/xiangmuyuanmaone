//
//  UIImage+Image.m
//  WB
//
//  Created by 刘生文 on 12/01/01.
//  Copyright © 2012年 apple. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
// 加载最原始的图片，没有渲染
+(instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
// 加载图片时，进行拉伸
+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
