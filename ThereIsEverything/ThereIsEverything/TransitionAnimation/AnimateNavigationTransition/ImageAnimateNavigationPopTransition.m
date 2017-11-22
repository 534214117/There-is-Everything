//
//  ImageAnimateNavigationPopTransition.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/16.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "ImageAnimateNavigationPopTransition.h"
#import "ImageWaterfallFlowViewController.h"
#import "DetailViewController.h"

@interface ImageAnimateNavigationPopTransition () 

@end



@implementation ImageAnimateNavigationPopTransition



//动画时长
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

//
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //1.获取动画的源控制器和目标控制器
    DetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ImageWaterfallFlowViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    //2.创建一个 Cell 中 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
    UIView *snapshotView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [container convertRect:fromVC.imageView.frame fromView:fromVC.scrollView];
    fromVC.imageView.hidden = YES;
    
    //3.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.selectedCell.hidden = YES;
    
    //4.都添加到 container 中。注意顺序不能错了
    [container addSubview:toVC.view];
    [container addSubview:snapshotView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        snapshotView.frame = [container convertRect:toVC.selectedCell.imageView.frame fromView:toVC.selectedCell];
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVC.imageView.hidden = NO;
        toVC.selectedCell.hidden = NO;
        [snapshotView removeFromSuperview];
        
        //一定要记得动画完成后执行此方法，让系统管理 navigation
        [transitionContext completeTransition:YES];
    }];
    
}



@end
