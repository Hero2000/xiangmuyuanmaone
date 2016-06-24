//
//  CHQualityVC.m
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHQualityVC.h"
#import "CHGroupItem.h"
#import "CHCheakItem.h"
#import "CHProfileCell.h"

@interface CHQualityVC ()
@property (nonatomic, strong) CHCheakItem *selUploadItem;
@property (nonatomic, strong) CHCheakItem *selDoloadItem;
@end

@implementation CHQualityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = CHColor(225.0, 225.0, 225.0, 255.0);
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
}

- (void)setUpGroup0
{
    // 高清
    CHCheakItem *high = [CHCheakItem itemWithTitle:@"高清"];
    high.subTitle = @"建议在Wifi或3G网络使用";
    __weak typeof(self) vc = self;
    high.option = ^{
        [vc selUploadItem:high];
    };
    // 普通
    CHCheakItem *normal = [CHCheakItem itemWithTitle:@"普通"];
    normal.subTitle = @"上传速度快，省流量";
    normal.option = ^{
        [vc selUploadItem:normal];
    };
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.headerTitle = @"上传图片质量";
    group.items = @[high,normal];
    [self.groups addObject:group];
    // 默认选中第0组的一行
    NSString *upload = [CHUserDefaults objectForKey:CHSelUploadKey];
    if (upload == nil) {
        [self selUploadItem:high];
        return;
    }
    for (CHCheakItem *item in group.items) {
        if ([item.title isEqualToString:upload]) {
            [self selUploadItem:item];
        }
    }
}

- (void)setUpGroup1
{
    // 高清
    CHCheakItem *high = [CHCheakItem itemWithTitle:@"高清"];
    high.subTitle = @"建议在Wifi或3G网络使用";
    __weak typeof(self) vc = self;
    high.option = ^{
        [vc selDoloadItem:high];
    };
    // 普通
    CHCheakItem *normal = [CHCheakItem itemWithTitle:@"普通"];
    normal.subTitle = @"下载速度快，省流量";
    normal.option = ^{
        [vc selDoloadItem:normal];
    };
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.headerTitle = @"下载图片质量";
    group.items = @[high,normal];
    [self.groups addObject:group];
    // 默认选中第0组的一行
    NSString *downLoad = [CHUserDefaults objectForKey:CHSelUploadKey];
    if (downLoad == nil) {
        [self selDoloadItem:high];
        return;
    }
    for (CHCheakItem *item in group.items) {
        if ([item.title isEqualToString:downLoad]) {
            [self selDoloadItem:item];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建自己的cell
    CHProfileCell *cell = [CHProfileCell cellWithTableView:tableView];
    // 获取模型
    CHGroupItem *groupItem = self.groups[indexPath.section];
    CHRowItem *item = groupItem.items[indexPath.row];
    // 设置模型
    cell.item = item;
    // 设置每个cell的头、尾、中的图片，并将图片进行拉伸
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    return cell;
}

- (void)selUploadItem:(CHCheakItem *)item
{
    _selUploadItem.cheak = NO;
    item.cheak = YES;
    _selUploadItem = item;
    [self.tableView reloadData];
    // 数据存储
    [CHUserDefaults setObject:item.title forKey:CHSelUploadKey];
    [CHUserDefaults synchronize];
}

- (void)selDoloadItem:(CHCheakItem *)item
{
    _selDoloadItem.cheak = NO;
    item.cheak = YES;
    _selDoloadItem = item;
    [self.tableView reloadData];
    // 数据存储
    [CHUserDefaults setObject:item.title forKey:CHSelDownloadKey];
    [CHUserDefaults synchronize];
}


@end
