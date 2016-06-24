//
//  CHBasicSettingCell.m
//  WB
//
//  Created by 刘生文 on 13/3/31.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHBasicSettingCell.h"
#import "CHBadgeView.h"
#import "CHRowSettingHeader.h"

@interface CHBasicSettingCell ()

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIImageView *cheakView;
@property (nonatomic, strong) CHBadgeView *badgeView;
@property (nonatomic, weak) UILabel *labelView;

@end

@implementation CHBasicSettingCell

// 设置cell的背景图片，并进行拉伸
- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)count
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selBgView = (UIImageView *)self.selectedBackgroundView;
    // 只有一行
    if (count == 1) {
        bgView.image = [UIImage imageWithStretchableName:@"common_card_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_background_highlighted"];
    // 顶部cell
    }else if(indexPath.row == 0){
        bgView.image = [UIImage imageWithStretchableName:@"common_card_top_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_top_background_highlighted"];
    // 底部
    }else if (indexPath.row == count - 1){
        bgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background_highlighted"];
    // 中间
    }else{
        bgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background_highlighted"];
    }
}

- (void)switchChange:(UISwitch *)switchView
{
    CHSwitchItem *switchItem = (CHSwitchItem *)_item;
    switchItem.on = switchView.on;
}

#pragma mark - 3、给cell进行赋值------
- (void)setItem:(CHRowItem *)item
{
    _item = item;
    // 设置数据
    [self setUpData];
    // 设置模型
    [self setUpRightView];
}

- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.image;
}

- (void)setUpRightView
{
    // 箭头
    if ([_item isKindOfClass:[CHArrowItem class]]) {
        self.accessoryView = self.arrowView;
    // 开关
    }else if ([_item isKindOfClass:[CHSwitchItem class]]){
        self.accessoryView = self.switchView;
        CHSwitchItem *switchItem = (CHSwitchItem *)_item;
        self.switchView.on = switchItem.on;
    // 打钩
    }else if ([_item isKindOfClass:[CHCheakItem class]]){
        CHCheakItem *badgeItem = (CHCheakItem *)_item;
        if (badgeItem.cheak) {
            self.accessoryView = self.cheakView;
        }else{
            self.accessoryView = nil;
        }
    // 小红点
    }else if ([_item isKindOfClass:[CHBadgeItem class]]){
        CHBadgeItem *badgeItem = (CHBadgeItem *)_item;
        CHBadgeView *badge = self.badgeView;
        self.accessoryView = badge;
        badge.badgeValue = badgeItem.badgeValue;
    // 标签
    }else if ([_item isKindOfClass:[CHLabelItem class]]){
        CHLabelItem *labelItem = (CHLabelItem *)_item;
        UILabel *label = self.labelView;
        label.text = labelItem.text;
    // 没有
    }else{
        self.accessoryView = nil;
        [_labelView removeFromSuperview];
        _labelView = nil;
    }
}

#pragma mark - 2、cell的创建和初始化------
// cell的创建
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    CHBasicSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

// cell的初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 1、懒加载控件------
- (UILabel *)labelView
{
    if (_labelView == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        _labelView = label;
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
        [self addSubview:_labelView];
    }
    return _labelView;
}

- (CHBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [[CHBadgeView alloc] init];
    }
    return _badgeView;
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _switchView;
}

- (UIImageView *)cheakView
{
    if (_cheakView == nil) {
        _cheakView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _cheakView;
}

@end
