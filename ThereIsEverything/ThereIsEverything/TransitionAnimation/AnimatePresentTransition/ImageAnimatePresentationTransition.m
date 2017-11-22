//
//  ImageAnimatePresentationTransition.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/20.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "ImageAnimatePresentationTransition.h"
#import "ImageWaterfallFlowViewController.h"
#import "DetailViewController.h"

@implementation ImageAnimatePresentationTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //1.获取动画的源控制器和目标控制器
//    ImageWaterfallFlowViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.frame = CGRectMake(fromView.frame.origin.x, CGRectGetMaxY(fromView.frame)/2.0f, fromView.frame.size.width, fromView.frame.size.height);
    toView.alpha = 0;
    
    [container addSubview:toView];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        toView.alpha = 1;
        toView.frame = [transitionContext finalFrameForViewController:toVC];
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
    
}

@end
