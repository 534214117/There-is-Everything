//
//  StarWarsTransitionDismissing.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/9.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "StarWarsTransitionDismissing.h"

@interface StarWarsTransitionDismissing ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation StarWarsTransitionDismissing

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromViewSnapShot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    CGSize size = fromVC.view.frame.size;
    
    
    int width = 20;
    int height = width;
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:containerView];
    self.animator.delegate = self;

    NSMutableArray <UIView *>*snapshots = [[NSMutableArray alloc] init];

    for (int x = 0; x < size.width; x=x+width) {
        for (int y = 0; y < size.height; y=y+height) {

            CGRect snapshotRegion = CGRectMake(x, y, width, height);
            UIView *snapshot = [fromViewSnapShot resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = snapshotRegion;
//            snapshot.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
            [containerView addSubview:snapshot];

            [snapshots addObject:snapshot];

            UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[snapshot] mode:UIPushBehaviorModeInstantaneous];
            push.pushDirection = CGVectorMake([self randomFloatBetweenSmallNumber:-0.15 bigNumber:0.15], [self randomFloatBetweenSmallNumber:-0.15 bigNumber:0]);
            push.active = YES;
            [self.animator addBehavior:push];

        }
    }

    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:snapshots];
    [self.animator addBehavior:gravity];

    

    [fromVC.view removeFromSuperview];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([self transitionDuration:transitionContext] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:YES];
    });
    
}


- (CGFloat)randomFloatBetweenSmallNumber:(CGFloat)smallNumber bigNumber:(CGFloat)bigNumber {
    int diff = (bigNumber - smallNumber)*100;
    CGFloat r = ((arc4random()*100) % diff)/100.f + smallNumber;
    return r;
}


- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
    NSLog(@"1");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    NSLog(@"2");
}

@end
