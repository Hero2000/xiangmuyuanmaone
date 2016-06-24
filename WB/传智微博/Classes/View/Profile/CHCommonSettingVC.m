//
//  CHCommonSettingVC.m
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHCommonSettingVC.h"
#import "CHArrowItem.h"
#import "CHGroupItem.h"
#import "CHSwitchItem.h"
#import "CHRowItem.h"
#import "CHFontSizeVC.h"
#import "UIImageView+WebCache.h"
// 跳转到"图像质量"控制器
#import "CHQualityVC.h"

@interface CHCommonSettingVC ()
@property (nonatomic, weak) CHRowItem *fontSize;
@end

@implementation CHCommonSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
    // 添加第4组
    [self setUpGroup4];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChange:) name:fontSizeChangeNote object:nil];
}

// 计算沙盒内文件的大小
- (CGFloat)sizeWithFile:(NSString *)filePath
{
    CGFloat totalSize = 0;
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (isExists) {
        if (isDirectory) {
            NSArray *subPaths =  [mgr subpathsAtPath:filePath];
            for (NSString *subPath in subPaths) {
                NSString *fullPath = [filePath stringByAppendingPathComponent:subPath];
                BOOL isDirectory;
                [mgr fileExistsAtPath:fullPath isDirectory:&isDirectory];
                if (!isDirectory) { // 计算文件尺寸
                    NSDictionary *dict =  [mgr attributesOfItemAtPath:fullPath error:nil];
                    totalSize += [dict[NSFileSize] floatValue];;
                }
            }
        }else{
            NSDictionary *dict =  [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize =  [dict[NSFileSize] floatValue];
        }
    }
    return totalSize;
}

// 删除文件内数据的方法
- (void)removeFile:(NSString *)filePath
{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

// 通知执行方法(带参数，通知参数信息)
- (void)fontSizeChange:(NSNotification *)notication
{
    _fontSize.subTitle = notication.userInfo[CHFontSizeKey];
    [self.tableView reloadData];
}

// 每组的cell内容
- (void)setUpGroup0
{
    // 阅读模式
    CHRowItem *read = [CHRowItem itemWithTitle:@"阅读模式"];
    read.subTitle = @"有图模式";
    // 字体大小
    CHRowItem *fontSize = [CHRowItem itemWithTitle:@"字体大小"];
    _fontSize = fontSize;
    NSString *fontSizeStr =  [CHUserDefaults objectForKey:CHFontSizeKey];
    if (fontSizeStr == nil) {
        fontSizeStr = @"中";
    }
    fontSize.subTitle = fontSizeStr;
    fontSize.descVc = [CHFontSizeVC class];
    // 显示备注
    CHSwitchItem *remark = [CHSwitchItem itemWithTitle:@"显示备注"];
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[read,fontSize,remark];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 图片质量
    CHArrowItem *quality = [CHArrowItem itemWithTitle:@"图片质量" ];
    quality.descVc = [CHQualityVC class];
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[quality];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 声音
    CHSwitchItem *sound = [CHSwitchItem itemWithTitle:@"声音" ];
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[sound];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 多语言环境
    CHRowItem *language = [CHRowItem itemWithTitle:@"多语言环境"];
    language.subTitle = @"跟随系统";
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[language];
    [self.groups addObject:group];
}
- (void)setUpGroup4
{
    // 清空图片缓存
    CHRowItem *clearImage = [CHRowItem itemWithTitle:@"清空图片缓存"];
    // 1、图片文件的大小
    CGFloat fileSize = [SDWebImageManager sharedManager].imageCache.getSize / 1024.0;
    // 设置cell的子标题，显示文件的大小，大于1M，进行处理
    clearImage.subTitle = [NSString stringWithFormat:@"%.fKB",fileSize];
    if (fileSize > 1024) {
        fileSize = fileSize / 1024.0;
        clearImage.subTitle = [NSString stringWithFormat:@"%.1fM",fileSize];
    }
    // 存储沙盒的位置
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 存储沙盒的文件名称
    NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    // 查看文件的大小(暂时没有什么用)
    CGFloat size =  [self sizeWithFile:filePath];
    CHLog(@"%f",size);
    clearImage.option = ^{
        [[SDWebImageManager sharedManager].imageCache clearDisk];
        clearImage.subTitle = nil;
        [self.tableView reloadData];
        // 将缓存文件名下面的数据，清空
        [self removeFile:filePath];
        clearImage.subTitle = @"0KB";
    };
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[clearImage];
    [self.groups addObject:group];
}

- (void)dealloc
{
    CHLog(@"%s",__func__);
}

@end
