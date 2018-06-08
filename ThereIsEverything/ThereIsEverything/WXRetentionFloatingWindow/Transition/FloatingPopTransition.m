//
//  FloatingPopTransition.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/5/31.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "FloatingPopTransition.h"

@implementation FloatingPopTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //1.获取动画的源控制器和目标控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    //2.创建一个 Cell 中 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
    UIView *snapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [container convertRect:fromVC.view.frame fromView:fromVC.view];
    
    //3.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0.5;
    
    //4.都添加到 container 中。注意顺序不能错了
    [container addSubview:toVC.view];
    [container addSubview:snapshotView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        snapshotView.frame = CGRectMake(KSCreenWidth, 0, KSCreenWidth, KSCreenHeight);
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        toVC.view.alpha = 1;
        [snapshotView removeFromSuperview];
        fromVC.view.alpha = 1;
        //一定要记得动画完成后执行此方法，让系统管理 navigation
        if ([transitionContext transitionWasCancelled]) {
            [toVC.view removeFromSuperview];
        }
        else {
            GetAppDelegate.tempDetailViewController = nil;
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
