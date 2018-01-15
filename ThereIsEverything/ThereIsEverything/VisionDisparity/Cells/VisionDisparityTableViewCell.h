//
//  VisionDisparityTableViewCell.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/13.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisionDisparityTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImage *backImage;

- (void)updateBackImageViewYForTableView:(UITableView *)tableView andView:(UIView *)view;

@end
