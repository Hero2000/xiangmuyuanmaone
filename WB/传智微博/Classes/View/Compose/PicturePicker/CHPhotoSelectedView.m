//
//  CHPhotoSelectedVC.m
//  WB
//
//  Created by 刘生文 on 13/3/2.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHPhotoSelectedView.h"
#import "CHPhotoSelectedCell.h"

#pragma mark - 自定义照片选择视图布局
@interface CHPhotoSelectedLayout : UICollectionViewFlowLayout

@end

@implementation CHPhotoSelectedLayout

- (void)prepareLayout {
    [super prepareLayout];
    // item的大小
    CGFloat margin = 10;
    CGFloat w = (self.collectionView.bounds.size.width - 4 * margin) / 3;
    self.itemSize = CGSizeMake(w, w);
    // 最小列之间的间距(设置水平间隙)
    self.minimumInteritemSpacing = margin;
    // 设置最小行间距(设置垂直间隙)
    self.minimumLineSpacing = margin;
    // 修改cell距离view的边距(设置全局间隙)
    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    // 设置滚动的方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}
@end


#pragma mark - 照片选择视图
// 可重用标识符
#define kCellID  @"Cell"
#define kMaxCount  9

@interface CHPhotoSelectedView ()<UICollectionViewDataSource, UICollectionViewDelegate, CHPhotoSelectedCellDelegate>
// 添加照片回调
@property (nonatomic, copy) void (^addImageCallBack)();

@end

@implementation CHPhotoSelectedView

- (NSMutableArray *)pictures
{
    if (_pictures == nil) {
        _pictures = [NSMutableArray array];
    }
    return _pictures;
}
// 重写刷新方法
- (void)reloadData {
    [super reloadData];
    self.hidden = NO;
}

// 添加一张照片
- (void)setImage:(UIImage *)image
{
    if (image == nil) return;
    [self.pictures addObject:image];
    [self reloadData];
}

#pragma mark - 构造函数
- (instancetype)initWithAddImageCallBack:(void (^)())addImageCallBack {
    CHPhotoSelectedLayout *layout = [[CHPhotoSelectedLayout alloc] init];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 记录回调
        _addImageCallBack = addImageCallBack;
        // 注册可重用cell
        [self registerClass:[CHPhotoSelectedCell class] forCellWithReuseIdentifier:kCellID];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - CHPhotoSelectedCellDelegate 代理方法
// cell中删除按钮点击后的方法
- (void)photoSelectedCellDidClickDeleteButton:(CHPhotoSelectedCell *)cell
{
    if (cell.image == nil) return;
    // cell的索引
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    // 删除此cell
    [self.pictures removeObjectAtIndex:indexPath.item];
    // 刷新CollectionView
    [self reloadData];
}

#pragma mark UICollectionView 的数据源方法
// 返回每组多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 如果是0张图片或者 9 张图片,就返回 images.count
    // 否则返回 images.count + 1
    NSInteger count = self.pictures.count;
    return (count == kMaxCount) ? count : count + 1;
}
// cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1、取出cell
    CHPhotoSelectedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    // 2、设置数据
    cell.image = (indexPath.item == self.pictures.count) ? nil : self.pictures[indexPath.item];
    cell.delegate = self;
    // 3、返回cell
    return cell;
}

#pragma mark <UICollectionViewDelegate>
// 点击cell时调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 判断是否点中末尾的加号按钮
    if (indexPath.item == self.pictures.count && self.addImageCallBack != nil) {
        self.addImageCallBack();
    }
}

@end
