//
//  CHHomeVC.m
//  WB
//
//  Created by 刘生文 on 13/3/14.
//  Copyright © 2013年 刘生文. All rights reserved.
//

#import "CHHomeVC.h"
#import "UIBarButtonItem+Item.h"
#import "CHTitleButton.h"
#import "CHPopMenuView.h"
#import "CHMenuVC.h"
#import "CHSearchVC.h"
#import "CHVisitorView.h"
#import "CHStatusTool.h"
#import "CHStatus.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "CHUserTool.h"
#import "CHAccount.h"
#import "CHAccountTool.h"
#import "CHStatusFrame.h"
#import "CHStatusCell.h"

@interface CHHomeVC ()
// 二维码扫描按钮
@property (nonatomic, strong) CHSearchVC *searchVC;
/**
 *  ViewModel:CZStatusFrame
 */
@property (nonatomic, strong) NSMutableArray *data;
// 导航条标题按钮
@property (nonatomic, weak) CHTitleButton *titleButton;

@end

@implementation CHHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 对访客视图的处理
    [self setUpImageName:nil title:@"关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜" loginSuccess:^{
        // 设置导航条内容
        [self setUpNavgationBar];
        // 设置tableView的背景颜色
        self.tableView.backgroundColor = CHColor(225.0, 225.0, 225.0, 255.0);
        // 添加下拉刷新控件
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewStatus方法）
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
        // 自动下拉刷新
        [self.tableView.mj_header beginRefreshing];
        // 添加上拉刷新控件
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
        // 请求当前用户的昵称
        [self userInfo];
        
    }];
}

#pragma mark - 展示最新的微博数
-(void)showNewStatusCount:(int)count {
    if (count == 0) return;
    // 展示最新的微博数
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"最新微博数%d",count];
    label.textAlignment = NSTextAlignmentCenter;
    // 插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        // 往上面平移
        [UIView animateWithDuration:0.25 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            // 还原
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}


- (void)userInfo
{
    [CHUserTool userInfoWithSuccess:^(CHUser *user) {
        // 请求当前账号的用户信息
        // 设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 获取当前的账号
        CHAccount *account = [CHAccountTool account];
        account.name = user.name;
        account.profile_image_url = user.profile_image_url;
        // 保存用户的名称
        [CHAccountTool saveAccount:account];
    } failure:^(NSError *error) {
    
    }];
}
#pragma mark - 刷新最新的微博
- (void)refresh
{
    // 自动下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewStatus
{
    CHStatusFrame *sf = [self.data firstObject];
    NSString *sinceId = nil;
    if (self.data.count) {
        sinceId = sf.status.idstr;
    }
    [CHStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        // 请求成功后回调Block
        // 展示最新的微博数
        [self showNewStatusCount:statuses.count];
        // 结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        /*** 将请求到的数据传到VM模型里 ***/
        NSMutableArray *statusF = [NSMutableArray array];
        for (CHStatus *status in statuses) {
            CHStatusFrame *statusFrame = [[CHStatusFrame alloc] init];
            // 把模型数据，传到VM类中，拿到模型数据，进行frame处理，调用的是模型的set方法
            statusFrame.status = status;
            [statusF addObject:statusFrame];
        }
        // 把最新的微博数插入到最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.data insertObjects:statusF atIndexes:indexSet];
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

// 请求更多微博数据
- (void)loadMoreStatus
{
    CHStatusFrame *sf = [self.data lastObject];
    NSString *maxIdStr = nil;
    // 有微博数据，才需要下拉刷新
    // 判断时，可以用self.data.count，也可以用sf.status.idstr
    if (self.data.count) {
        long long maxId = [sf.status.idstr longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    // 请求更多的微博数据
    [CHStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        // 结束上拉刷新
        [self.tableView.mj_footer endRefreshing];
        /*** 将请求到的数据传到VM模型里 ***/
        NSMutableArray *statusF = [NSMutableArray array];
        for (CHStatus *status in statuses) {
            CHStatusFrame *statusFrame = [[CHStatusFrame alloc] init];
            // 把模型数据，传到VM类中，拿到模型数据，进行frame处理，调用的是模型的set方法
            statusFrame.status = status;
            [statusF addObject:statusFrame];
        }
        // 把模型数组中的元素添加到，自己的可变数组中
        [self.data addObjectsFromArray:statusF];
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}

- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)setUpNavgationBar
{
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch) forControlEvents:UIControlEventTouchUpInside];
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(popCode) forControlEvents:UIControlEventTouchUpInside];
    // 标题
    CHTitleButton *titleBtn = [[CHTitleButton alloc] init];
    _titleButton = titleBtn;
    NSString *title = [CHAccountTool account].name?[CHAccountTool account].name:@"首页";
    [titleBtn setTitle:title forState:UIControlStateNormal];
    // 标题按钮监听方法
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

// 标题按钮监听方法
- (void)titleClick:(CHTitleButton *)btn
{
    // 切换按钮的状态
    btn.selected = !btn.selected;
    // 显示菜单控制器
    CHMenuVC *tb = [[CHMenuVC alloc] init];
    tb.view.backgroundColor = [UIColor clearColor];
    tb.view.size = CGSizeMake(150, 200);
    [CHPopMenuView popFrom:btn contentVC:tb dismiss:^{
        // 切换按钮的状态
        btn.selected = !btn.selected;
    }];
}

- (CHSearchVC *)searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[CHSearchVC alloc] init];
    }
    return _searchVC;
}

// 加载更多好友
- (void)friendSearch
{
    DDLog();
}

// 扫描码实现
- (void)popCode
{
    CHSearchVC *searchVC = [[CHSearchVC alloc] init];
    // 当 push 的时候隐藏系统自带的tabBar
    // 前提：只会隐藏系统自带的tabBar
    searchVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:searchVC animated:YES];
    [self presentViewController:searchVC animated:YES completion:nil];
}

#pragma mark - TableView 的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1、创建cell
    CHStatusCell *cell = [CHStatusCell cellWithTableView:tableView];
    // 2、获取Status模型
    CHStatus *status = self.data[indexPath.row];
    // 3、重写set方法，给cell传递模型
    cell.statusF = status;
    return cell;
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取status模型
    CHStatusFrame *statusFrame = self.data[indexPath.row];
    return statusFrame.cellHeight;
}

@end
