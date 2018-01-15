//
//  ParticularlyTransition.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/28.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "ParticularlyPresentTransition.h"
#import "ParticularlyPageTransitionViewController.h"
#import "DetailParticularlyViewController.h"

#define CellHeight ((KSCreenHeight-K_StatusBarAndNavigationBarHeight)/3.)
#define MarginTop (((KSCreenHeight-K_StatusBarAndNavigationBarHeight)/3.)/4.)
#define AnimateFinalRect CGRectMake(0, KSCreenHeight-CellHeight*1.8, KSCreenWidth, CellHeight)

@implementation ParticularlyPresentTransition


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    ParticularlyPageTransitionViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].childViewControllers.lastObject
;
    DetailParticularlyViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    CGRect frame = [container convertRect:fromVC.selectedCell.frame fromView:fromVC.view];
    frame.origin.y += K_StatusBarAndNavigationBarHeight;
    [toVC setMainViewY:CGRectGetMinY(frame)];
    toVC.view.layer.mask = [self hexagonFrame:frame];
    toVC.cellDataView.frame = frame;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    [container addSubview:toVC.view];
    
    
    
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.cellDataView.frame = [container convertRect:AnimateFinalRect fromView:toVC.view];
    } completion:^(BOOL finished) {
        //一定要记得动画完成后执行此方法，让系统管理 navigation
        [transitionContext completeTransition:YES];
        [toVC.view.layer.mask removeFromSuperlayer];
    }];
    
}

- (CAShapeLayer *)hexagonFrame:(CGRect)frame {
    
    float startX = CGRectGetMinX(frame)+20;
    float startY = CGRectGetMinY(frame)+MarginTop/2.;
    float viewWidth = CellHeight-MarginTop;
    
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
    
    
    viewWidth = KSCreenHeight*3;
    startX = CGRectGetMinX(frame)+20+(CellHeight-MarginTop)/2. - viewWidth/2.;
    startY = CGRectGetMinY(frame)+MarginTop/2.+(CellHeight-MarginTop)/2. - viewWidth/2.;
    
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
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [shapLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    
    return shapLayer;
}


@end
