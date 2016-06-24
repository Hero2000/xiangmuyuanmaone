//
//  CHBasicSettingVC.m
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHBasicSettingVC.h"
#import "CHGroupItem.h"
#import "CHBasicSettingCell.h"
#import "CHRowItem.h"

@interface CHBasicSettingVC ()

@end

@implementation CHBasicSettingVC

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // view的背景
    self.tableView.backgroundColor = CHColor(225.0, 225.0, 225.0, 255.0);
    // 表头的高度
    self.tableView.sectionHeaderHeight = 10;
    // 表尾的高度
    self.tableView.sectionFooterHeight = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    // 表的分割线样式设置
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - TableView 的数据源方法
// 设置cell的头部标题内容(头)
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CHGroupItem *groupItem = self.groups[section];
    return groupItem.headerTitle;
}
// 设置cell的尾部标题内容(尾)
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CHGroupItem *groupItem = self.groups[section];
    return groupItem.footerTitle;
}
// 返回多少组(组)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}
// 返回每组有多少行(行)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CHGroupItem *groupItem = self.groups[section];
    return groupItem.items.count;
}
// 每个cell内容的具体设置(cell)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    CHBasicSettingCell *cell = [CHBasicSettingCell cellWithTableView:tableView];
    // 获取模型
    CHGroupItem *groupItem = self.groups[indexPath.section];
    CHRowItem *rowItem = groupItem.items[indexPath.row];
    // 设置模型
    cell.item = rowItem;
    // 每组前、后、中背景图片设置
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    return cell;
}

// cell被点击时，调用此方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取模型
    CHGroupItem *groupItem = self.groups[indexPath.section];
    CHRowItem *item = groupItem.items[indexPath.row];
    // 回调操作
    if (item.option) {
        item.option(item);
        return;
    }
    // 选择要跳转的控制器
    if (item.descVc) {
        UIViewController *vc = [[item.descVc alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
