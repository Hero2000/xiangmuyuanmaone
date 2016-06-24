//
//  CHFontSizeVC.m
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHFontSizeVC.h"
#import "CHCheakItem.h"
#import "CHGroupItem.h"

@interface CHFontSizeVC ()
@property (nonatomic, strong) CHCheakItem *selCheakItem;
@end

@implementation CHFontSizeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加第0组
    [self setUpGroup0];
}

- (void)setUpGroup0
{
    // 大
    CHCheakItem *big = [CHCheakItem itemWithTitle:@"大"];
    __weak typeof(self) vc = self;
    big.option = ^{
        [vc selItem:big];
    };
    // 中
    CHCheakItem *middle = [CHCheakItem itemWithTitle:@"中"];
    middle.option = ^{
        [vc selItem:middle];
    };
    _selCheakItem = middle;
    // 小
    CHCheakItem *small = [CHCheakItem itemWithTitle:@"小"];
    small.option = ^{
        [vc selItem:small];
    };
    CHGroupItem *group = [[CHGroupItem alloc] init];
    group.headerTitle = @"上传图片质量";
    group.items = @[big,middle,small];
    [self.groups addObject:group];
    // 默认选中item,为"中"
    [self setUpSelItem:middle];
}

- (void)setUpSelItem:(CHCheakItem *)item
{
    NSString *fontSizeStr =  [CHUserDefaults objectForKey:CHFontSizeKey];
    if (fontSizeStr == nil) {
        [self selItem:item];
        return;
    }
    for (CHGroupItem *group in self.groups) {
        for (CHCheakItem *item in group.items) {
            if ( [item.title isEqualToString:fontSizeStr]) {
                [self selItem:item];
            }
        }
    }
}

- (void)selItem:(CHCheakItem *)item
{
    _selCheakItem.cheak = NO;
    item.cheak = YES;
    _selCheakItem = item;
    [self.tableView reloadData];
    // 存储
    [CHUserDefaults setObject:item.title forKey:CHFontSizeKey];
    [CHUserDefaults synchronize];
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:fontSizeChangeNote object:nil userInfo:@{CHFontSizeKey:item.title}];
}

@end
