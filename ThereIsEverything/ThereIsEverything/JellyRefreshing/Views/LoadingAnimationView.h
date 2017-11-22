//
//  LoadingAnimationView.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/21.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingAnimationView : UIView

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) CAShapeLayer *loadingShapeLayer;

- (void)startAnimate;
- (void)stopAnimate;

@end
