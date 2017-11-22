//
//  DetailViewController.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/16.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) BaseScrollView *scrollView;
- (void)setContentImage:(UIImage *)image contentString:(NSString *)content;

@end
