//
//  CHVisitorView.h
//  WB
//
//  Created by 刘生文 on 13/3/24.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHVisitorView : UIView

@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *loginBtn;

- (void)setUpInfo:(NSString *)imageName title:(NSString *)title;

@end
