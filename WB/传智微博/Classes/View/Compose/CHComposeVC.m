//
//  CHComposeVC.m
//  WB
//
//  Created by 刘生文 on 13/3/29.
//  Copyright © 2013年 apple. All rights reserved.
//

#import "CHComposeVC.h"
#import "CHTextView.h"
#import "CHComposeToolBar.h"
#import "CHPhotoSelectedView.h"
#import "CHComposeTool.h"
#import "SVProgressHUD.h"

@interface CHComposeVC ()<UITextViewDelegate,CHComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, weak) CHTextView *textView;
@property (nonatomic, weak) CHComposeToolBar *toolBar;
@property (nonatomic, weak) CHPhotoSelectedView *photosView;
@property (nonatomic, strong) NSMutableArray *images;
// 工具栏表情按钮
@property (nonatomic, weak) UIButton *toolbarEmoticonButton;

@end

@implementation CHComposeVC

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条
    [self setUpNavgationBar];
    // 添加textView
    [self setUpTextView];
    // 添加工具条
    [self setUpToolBar];
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 添加相册视图
    [self setUpPhotosView];
}

#pragma mark - 点击工具条按钮的时候调用(代理方法)
- (void)composeToolBar:(CHComposeToolBar *)toolBar didClickBtn:(NSInteger)index {
    __weak typeof(self) weakSelf = self;
    if (index == 0) { // 点击相册
        [weakSelf clickSelectPhotoButton];
    }else if (index == 1) { // 点击提及
        DDLog();
    }else if (index == 2) { // 点击话题
        DDLog();
    }else if (index == 3) { // 点击表情
        DDLog();
        [weakSelf clickEmoticonButton];
    }else if (index == 4) { // 点击键盘
        DDLog();
    }
}

#pragma mark - 添加相册视图
- (void)setUpPhotosView {
    __weak typeof(self) weakSelf = self;
    _photosView = [[CHPhotoSelectedView alloc] initWithAddImageCallBack:^{
        [weakSelf clickSelectPhotoButton];
    }];
    [self.textView addSubview:_photosView];
    _photosView.frame = CGRectMake(0, 100, self.view.width, self.view.height - 100);
}

// 选择照片
- (void)clickSelectPhotoButton {
    // 判断是否能够访问照片库
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 设置相册类型,为相册集
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 设置代理
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 选择图片完成的时候调用(代理方法)
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (image == nil) return;
    _photosView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    _rightItem.enabled = YES;
}

// 点击切换表情按钮
- (void)clickEmoticonButton {
    
}

// 切换表情键盘图像
- (void)switchEmoticonButtonImage {
    NSString *type = (self.textView.inputView == nil) ? @"emoticon" : @"keyboard";
    NSString *imageName = [NSString stringWithFormat:@"compose_%@button_background", type];
    NSString *imageNameHL = [NSString stringWithFormat:@"%@_highlighted", imageName];
    [self.toolbarEmoticonButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.toolbarEmoticonButton setImage:[UIImage imageNamed:imageNameHL] forState:UIControlStateHighlighted];
}

#pragma mark - 键盘的Frame改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note {
    // 获取键盘弹出的动画时间
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform =  CGAffineTransformIdentity;
        }];
    }else{ // 弹出键盘
        // 工具条往上移动258
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}

#pragma mark - 添加ToolBar
- (void)setUpToolBar {
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    CHComposeToolBar *toolBar = [[CHComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}

#pragma mark - 添加textView
- (void)setUpTextView {
    CHTextView *textView = [[CHTextView alloc] initWithFrame:self.view.bounds];
    _textView = textView;
    // 设置占位符
    textView.placeHolder = @"abc";
    textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:textView];
    // 默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    // 监听文本框的输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    // 监听拖拽
    _textView.delegate = self;
}

#pragma mark - 开始拖拽的时候调用(代理方法)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - 文字改变的时候调用
- (void)textChange {
    // 判断下textView有没有内容
    if (_textView.text.length) { // 有内容
        _textView.hidePlaceHolder = YES;
        _rightItem.enabled = YES;
    }else{
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpNavgationBar {
    self.title = @"发微博";
    // left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    // right
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    // 监听按钮点击
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
}
- (void)dismiss {
    [_textView resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}
// 发送微博
- (void)compose {
    // 新浪上传：文字不能为空，分享图片
    // 二进制数据不能拼接url的参数，只能使用formdata
    // 判断下有没有图片
    if (self.photosView.pictures.count) {
        // 发送图片
        [self sendPicture];
    }else{
        // 发送文字
        [self sendTitle];
    }
}

#pragma mark - 发送图片
- (void)sendPicture {
    UIImage *image = self.photosView.pictures[0];
    // 发送图片必须要有文字，对有无内容进行处理
    NSString *status = _textView.text.length ? _textView.text : @"分享图片";
    _rightItem.enabled = NO;
    // 我引用你，你引用我
    [CHComposeTool composeWithStatus:status image:image success:^{
        // 提示用户发送成功
        [SVProgressHUD showSuccessWithStatus:@"发送图片成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        _rightItem.enabled = YES;
    } failure:^(NSError *error) {
        CHLog(@"%@",error.description);
        [SVProgressHUD showSuccessWithStatus:@"发送图片失败"];
        _rightItem.enabled = YES;
    }];
}

#pragma mark - 发送文字
- (void)sendTitle {
    [CHComposeTool composeWithStatus:_textView.text success:^{
        // 提示用户发送成功
        [SVProgressHUD showSuccessWithStatus:@"发送图片成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        CHLog(@"%@",error);
    }];
}

@end
