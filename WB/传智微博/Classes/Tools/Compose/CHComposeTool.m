//
//  CHComposeTool.m
//  WB
//
//  Created by 刘生文 on 13/3/30.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHComposeTool.h"
#import "CHComposeParam.h"
#import "CHAccountTool.h"
#import "CHAccount.h"
#import "CHHttpTool.h"
#import "MJExtension.h"
#import "CHUpLoadParam.h"

@implementation CHComposeTool

/**
 *  发送文字
 *
 *  @param status  发送微博内容
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    CHComposeParam *param = [[CHComposeParam alloc] init];
    param.access_token = [CHAccountTool account].access_token;
    param.status = status;
    
    [CHHttpTool Post:@"https://api.weibo.com/2/statuses/update.json" parameters:param.mj_keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  发送图片
 *
 *  @param status   发送微博文字内容
 *  @param image    发送微博图片内容
 *  @param success  成功的回调
 *  @param failure  失败的回调
 */
+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    CHComposeParam *param = [[CHComposeParam alloc] init];
    param.access_token = [CHAccountTool account].access_token;
    param.status = status;
    
    // 创建上传的模型
    CHUpLoadParam *uploadP = [[CHUpLoadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    // 注意：以后如果一个方法，要传很多参数，就把参数包装成一个模型
    [CHHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.mj_keyValues uploadParam:uploadP success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }]; 
}

@end
