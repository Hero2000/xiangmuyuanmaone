//
//  CHPhotoSelectedCell.m
//  WB
//
//  Created by 刘生文 on 13/3/2.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHPhotoSelectedCell.h"
#import "Masonry.h"

@interface CHPhotoSelectedCell ()
// 图像视图
@property (nonatomic, strong) UIImageView *addImage;
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation CHPhotoSelectedCell
#pragma mark - 3、设置cell显示的图片内容------
// 重写set方法
- (void)setImage:(UIImage *)image
{
    _image = image;
    CHLog(@"123 = %@",image);
    self.addImage.image = (image == nil) ? [UIImage imageNamed:@"compose_pic_add"] : image;
    self.addImage.highlightedImage = (image == nil) ? [UIImage imageNamed:@"compose_pic_add_highlighted"] : image;
    // 隐藏删除按钮
    _deleteBtn.hidden = (image == nil);
}

#pragma mark - 2、监听控件代理方法------
- (void)deleteBtnClick
{
    DDLog();
    if ([self.delegate respondsToSelector:@selector(photoSelectedCellDidClickDeleteButton:)]) {
        [self.delegate photoSelectedCellDidClickDeleteButton:self];
    }
}

#pragma mark - 1、初始化控件------
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
// 加载控件及布局
- (void)setUpUI
{
    // 添加到视图上
    // 添加addImage
    _addImage = [[UIImageView alloc] init];
    _addImage.contentMode = UIViewContentModeScaleAspectFill;
    _addImage.clipsToBounds = YES;
    _addImage.hidden = NO;
    [self.contentView addSubview:_addImage];
    
    // 添加deleteBtn
    _deleteBtn = [[UIButton alloc] init];
    // 设置button的属性
    [_deleteBtn setImage:[UIImage imageWithStretchableName:@"compose_photo_close"] forState:UIControlStateNormal];
    // 监听方法
    [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    // 进行布局
    [_addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
}
@end
