//
//  CHProfileVC.m
//  WB
//
//  Created by 刘生文 on 13/3/14.
//  Copyright © 2013年 刘生文. All rights reserved.
//

#import "CHProfileVC.h"
#import "CHRowSettingHeader.h"
#import "CHProfileCell.h"
#import "CHGroupItem.h"
#import "CHSettingVC.h"
#import "CHNavVC.h"

@interface CHProfileVC ()
// 存放所有cell内容的对象
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation CHProfileVC

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
    [self setUpImageName:@"visitordiscover_image_profile" title:@"登陆后，你的微博、相册、个人资料会显示在这里，展示给别人" loginSuccess:^{
        // 创建导航条
        [self setUpNavgationBar];
        // 设置自己的tableView
        self.tableView.backgroundColor = CHColor(225.0, 225.0, 225.0, 255.0);
        self.tableView.sectionHeaderHeight = 10;
        self.tableView.sectionFooterHeight = 0;
        self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 添加第0组
        [self setUpGroup0];
        // 添加第1组
        [self setUpGroup1];
        // 添加第2组
        [self setUpGroup2];
        // 添加第3组
        [self setUpGroup3];
    }];
}

- (void)setUpGroup0
{
    // 新的好友
    CHArrowItem *friend = [CHArrowItem itemWithTitle:@"新的好友" image:[UIImage imageNamed:@"new_friend"]];
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[friend];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 我的相册
    CHArrowItem *album = [CHArrowItem itemWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    album.subTitle = @"(12)";
    // 我的收藏
    CHArrowItem *collect = [CHArrowItem itemWithTitle:@"我的收藏" image:[UIImage imageNamed:@"collect"]];
    collect.subTitle = @"(0)";
    // 赞
    CHArrowItem *like = [CHArrowItem itemWithTitle:@"赞" image:[UIImage imageNamed:@"like"]];
    like.subTitle = @"(0)";
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[album,collect,like];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 微博支付
    CHArrowItem *pay = [CHArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    // 个性化
    CHArrowItem *vip = [CHArrowItem itemWithTitle:@"个性化" image:[UIImage imageNamed:@"vip"]];
    vip.subTitle = @"微博来源、皮肤、封面图";
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[pay,vip];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 我的二维码
    CHArrowItem *card = [CHArrowItem itemWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    // 草稿箱
    CHArrowItem *draft = [CHArrowItem itemWithTitle:@"草稿箱" image:[UIImage imageNamed:@"draft"]];
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.items = @[card,draft];
    [self.groups addObject:group];
}

- (void)setUpNavgationBar
{
    // 设置UIBarButtonItem
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    // 设置为右边按钮
    self.navigationItem.rightBarButtonItem = settingItem;
}

#pragma mark - 按钮监听方法(跳转到子控制器)------
// 按钮监听方法(跳转到子控制器)
- (void)setting
{
    CHSettingVC *settingVc = [[CHSettingVC alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
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
// 每个cell内容的具体设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    CHProfileCell *cell = [CHProfileCell cellWithTableView:tableView];
    // 获取模型
//    cell.backgroundColor = [UIColor clearColor];
    CHGroupItem *groupItem = self.groups[indexPath.section];
    CHRowItem *rowItem = groupItem.items[indexPath.row];
    // 设置模型
    cell.item = rowItem;
    //
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
        item.option();
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
