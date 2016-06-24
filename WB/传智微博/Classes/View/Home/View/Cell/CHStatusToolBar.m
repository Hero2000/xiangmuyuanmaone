//
//  CHStatusToolBar.m
//  WB
//
//  Created by 刘生文 on 13/3/28.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHStatusToolBar.h"
#import "CHStatus.h"

@interface CHStatusToolBar ()
// 工具条按钮按钮集合
@property (nonatomic, strong) NSMutableArray *btns;
// 工具条分割线集合
@property (nonatomic, strong) NSMutableArray *divideVs;
// 转发按钮
@property (nonatomic, weak) UIButton *retweet;
// 评论按钮
@property (nonatomic, weak) UIButton *comment;
// 点赞按钮
@property (nonatomic, weak) UIButton *unlike;

@end

@implementation CHStatusToolBar

#pragma mark - 4、重写模型，按钮内数据添加和更改------
- (void)setStatus:(CHStatus *)status {
    _status = status;
    // 设置转发的标题
    [self setBtn:_retweet title:status.reposts_count];
    // 设置评论的标题
    [self setBtn:_comment title:status.comments_count];
    // 设置赞
    [self setBtn:_unlike title:status.attitudes_count];
}
// 设置按钮的标题
- (void)setBtn:(UIButton *)btn title:(int)count {
    // > 10000 10100 1.2W
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{ // < 10000
            title = [NSString stringWithFormat:@"%d",count];
        }
        // 设置转发
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark - 3、初始化控件进行布局------
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置按钮的frame
    NSUInteger count = self.btns.count;
    CGFloat w = CHScreenW / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < count ; i++) {
        UIButton *btn = self.btns[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    int i = 1;
    for (UIImageView *divide in self.divideVs) {
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
    }
}

#pragma mark - 2、初始化控件------
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView {
    // 转发
    UIButton *retweet = [self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet = retweet;
    // 评论
    UIButton *comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    // 赞
    UIButton *unlike = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlike = unlike;
    for (int i = 0; i < 2; i++) {
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.divideVs addObject:divideV];
    }
}

- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

#pragma mark - 1、懒加载控件------
- (NSMutableArray *)btns {
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divideVs {
    if (_divideVs == nil) {
        
        _divideVs = [NSMutableArray array];
    }
    return _divideVs;
}

@end
