//
//  StarWarsTransitionPresenting.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/9.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "StarWarsTransitionPresenting.h"
#import "StarWarsViewController.h"
#import "StarWarsProfleViewController.h"

@implementation StarWarsTransitionPresenting

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    StarWarsViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ;
    StarWarsProfleViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    toVC.view.frame = CGRectMake(0, KSCreenHeight, KSCreenWidth, KSCreenHeight);
    [container addSubview:toVC.view];
    
    [toVC startAnimate];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}

@end
