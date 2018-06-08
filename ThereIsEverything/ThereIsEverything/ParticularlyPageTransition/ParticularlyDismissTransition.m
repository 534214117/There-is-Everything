//
//  ParticularlyDismissTransition.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/2.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "ParticularlyDismissTransition.h"
#import "ParticularlyPageTransitionViewController.h"
#import "DetailParticularlyViewController.h"

#define CellHeight ((KSCreenHeight-K_StatusBarAndNavigationBarHeight)/3.)
#define MarginTop (((KSCreenHeight-K_StatusBarAndNavigationBarHeight)/3.)/4.)
#define AnimateFinalRect CGRectMake(0, KSCreenHeight-CellHeight*1.8, KSCreenWidth, CellHeight)

@implementation ParticularlyDismissTransition



- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    DetailParticularlyViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey]
    ;
    ParticularlyPageTransitionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].childViewControllers.lastObject;
    UIView *container = [transitionContext containerView];

    UIView *imageSnapView = [fromVC.bgImageView snapshotViewAfterScreenUpdates:YES];

    UIView *dataCellView = [fromVC.cellDataView snapshotViewAfterScreenUpdates:YES];
    dataCellView.frame = fromVC.cellDataView.frame;
    [imageSnapView addSubview:dataCellView];

    CGRect frame = [container convertRect:toVC.selectedCell.frame fromView:toVC.view];
    frame.origin.y += K_StatusBarAndNavigationBarHeight;
    imageSnapView.layer.mask = [self hexagonFrame:frame];

//    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
//    [container addSubview:toVC.view];
    [container addSubview:[toVC.view snapshotViewAfterScreenUpdates:YES]];
    [container addSubview:imageSnapView];
    
    
    
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        dataCellView.frame = frame;
    } completion:^(BOOL finished) {
        //一定要记得动画完成后执行此方法，让系统管理 navigation
        [transitionContext completeTransition:YES];
    }];
    
}

- (CAShapeLayer *)hexagonFrame:(CGRect)frame {
    
    float viewWidth = KSCreenHeight*3;
    float startX = CGRectGetMinX(frame)+20+(CellHeight-MarginTop)/2. - viewWidth/2.;
    float startY = CGRectGetMinY(frame)+MarginTop/2.+(CellHeight-MarginTop)/2. - viewWidth/2.;
    
    UIBezierPath * maskStartBP = [UIBezierPath bezierPath];
    maskStartBP.lineWidth = 2;
    [[UIColor whiteColor] setStroke];
    [maskStartBP moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2) + startX, (viewWidth / 4) + startY)];
    [maskStartBP addLineToPoint:CGPointMake((viewWidth / 2) + startX, 0 + startY)];
    [maskStartBP addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)) + startX, (viewWidth / 4) + startY)];
    [maskStartBP addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)) + startX, (viewWidth / 2) + (viewWidth / 4) + startY)];
    [maskStartBP addLineToPoint:CGPointMake((viewWidth / 2) + startX, viewWidth + startY)];
    [maskStartBP addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2) + startX, (viewWidth / 2) + (viewWidth / 4) + startY)];
    [maskStartBP closePath];
    
    startX = CGRectGetMinX(frame)+20;
    startY = CGRectGetMinY(frame)+MarginTop/2.;
    viewWidth = CellHeight-MarginTop;
    
    UIBezierPath * maskFinalBP = [UIBezierPath bezierPath];
    maskFinalBP.lineWidth = 2;
    [[UIColor whiteColor] setStroke];
    [maskFinalBP moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2) + startX, (viewWidth / 4) + startY)];
    [maskFinalBP addLineToPoint:CGPointMake((viewWidth / 2) + startX, 0 + startY)];
    [maskFinalBP addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)) + startX, (viewWidth / 4) + startY)];
    [maskFinalBP addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)) + startX, (viewWidth / 2) + (viewWidth / 4) + startY)];
    [maskFinalBP addLineToPoint:CGPointMake((viewWidth / 2) + startX, viewWidth + startY)];
    [maskFinalBP addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2) + startX, (viewWidth / 2) + (viewWidth / 4) + startY)];
    [maskFinalBP closePath];
    
    
    
    
    
    
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = 2;
    shapLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapLayer.path = maskStartBP.CGPath;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = 1;
    maskLayerAnimation.repeatCount = 1;
    maskLayerAnimation.removedOnCompletion = NO;
    maskLayerAnimation.fillMode = kCAFillModeForwards;
//    maskLayerAnimation.beginTime = CACurrentMediaTime() + 0.2;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [shapLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    
    return shapLayer;
}

@end
