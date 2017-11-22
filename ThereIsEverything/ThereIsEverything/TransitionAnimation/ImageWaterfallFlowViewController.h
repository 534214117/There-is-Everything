//
//  ImageWaterfallFlowViewController.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/14.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "BaseViewController.h"
#import "ImageCollectionViewCell.h"

@interface ImageWaterfallFlowViewController : BaseViewController

@property (nonatomic, strong) ImageCollectionViewCell *selectedCell;
@property (nonatomic, assign) BOOL present;

@end
