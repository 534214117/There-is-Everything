//
//  ResponsiveTableViewHeaderView.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/13.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResponsiveTableViewHeaderView : UIView

@property (nonatomic, assign) BOOL isSupportBlurEffect;

// 这里高度最好最好成比例设置（为了显示完整、美观嘛，虽然内部也做了适配）
- (instancetype)initWithImageHeight:(CGFloat)imageHeihgt;

- (void)setupResponsiveHeaderViewImage:(UIImage *)responsiveHeaderViewImage;

- (void)didScrollToY:(CGFloat)y;

@end
