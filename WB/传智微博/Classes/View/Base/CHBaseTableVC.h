//
//  CHBaseTableVC.h
//  WB
//
//  Created by 刘生文 on 13/3/24.
//  Copyright © 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHVisitorView.h"

@interface CHBaseTableVC : UITableViewController

- (void)setUpImageName:(NSString *)imageName title:(NSString *)title loginSuccess:(void (^)())loginSuccess;

@end
