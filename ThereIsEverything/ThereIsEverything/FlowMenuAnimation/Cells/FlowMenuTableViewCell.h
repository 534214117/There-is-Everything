//
//  FlowMenuTableViewCell.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/22.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowMenuModel.h"

@interface FlowMenuTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *menuButton;

- (void)resetModel:(FlowMenuModel *)model;
- (void)openMainViewAnimate;
- (void)closeMainViewAnimate;

@end
