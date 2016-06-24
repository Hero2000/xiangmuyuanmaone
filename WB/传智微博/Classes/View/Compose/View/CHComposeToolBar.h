//
//  CHComposeToolBar.h
//  WB
//
//  Created by 刘生文 on 13/3/30.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHComposeToolBar;
@protocol CHComposeToolBarDelegate <NSObject>
@optional
- (void)composeToolBar:(CHComposeToolBar *)toolBar didClickBtn:(NSUInteger)index;

@end

@interface CHComposeToolBar : UIView

@property (nonatomic, weak) id<CHComposeToolBarDelegate> delegate;

@end
