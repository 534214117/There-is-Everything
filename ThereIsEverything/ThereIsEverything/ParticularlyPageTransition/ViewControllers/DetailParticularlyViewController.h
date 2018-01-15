//
//  DetailParticularlyViewController.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/28.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "BaseViewController.h"
#import "ParticularlyModel.h"

@interface DetailParticularlyViewController : BaseViewController

@property (nonatomic, strong) UIView *cellDataView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) ParticularlyModel *model;

- (void)setMainViewY:(CGFloat)y;

@end
