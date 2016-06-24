//
//  CHStatusCell.m
//  WB
//
//  Created by 刘生文 on 13/3/28.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHStatusCell.h"
#import "CHOriginaView.h"
#import "CHRetweetView.h"
#import "CHStatusToolBar.h"
#import "CHStatusFrame.h"
#import "CHStatus.h"

@interface CHStatusCell ()
// 原创微博
@property (nonatomic, weak) CHOriginaView *originalView;
// 转发微博
@property (nonatomic, weak) CHRetweetView *retweetView;
// 微博工具条
@property (nonatomic, weak) CHStatusToolBar *toolBar;
@end

@implementation CHStatusCell

#pragma mark - 3、重写set方法来设置控件的Frame和内容------
/*
 问题：1.cell的高度应该提前计算出来
      2.cell的高度必须要先计算出每个子控件的frame，才能确定
      3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能
 解决:MVVM思想  M:模型  V:视图
 VM:视图模型（模型包装视图模型，模型+模型对应视图的frame）
 */
- (void)setStatusF:(CHStatusFrame *)statusF {
    _statusF = statusF;
    // 设置原创微博frame
    _originalView.frame = statusF.originalViewFrame;
    _originalView.statusF = statusF;
    if (statusF.status.retweeted_status) {
        // 设置转发微博frame
        _retweetView.frame = statusF.retweetViewFrame;
        _retweetView.statusF = statusF;
        _retweetView.hidden = NO;
    }else{
        _retweetView.hidden = YES;
    }
    // 设置工具条frame
    _toolBar.frame = statusF.toolBarFrame;
    _toolBar.status = statusF.status;
}


#pragma mark - 2、创建cell------
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 1、初始化cell------
// 注意：cell是用initWithStyle初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView {
    // 原创微博
    CHOriginaView *originalView = [[CHOriginaView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    // 转发微博
    CHRetweetView *retweetView = [[CHRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    // 工具条
    CHStatusToolBar *toolBar = [[CHStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

@end

