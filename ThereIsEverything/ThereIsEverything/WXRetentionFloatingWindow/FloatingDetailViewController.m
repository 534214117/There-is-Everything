//
//  FloatingDetailViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/5/31.
//Copyright © 2018年 Mine. All rights reserved.
//

#import "FloatingDetailViewController.h"
#import "FloatingPopTransition.h"
#import "FloatingControlView.h"
#import <UIImageView+WebCache.h>
#import <KVNProgress.h>

@interface FloatingDetailViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation FloatingDetailViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.delegate = [FloatingControlView shareFloatingControlView];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}


#pragma mark - User Interface

- (void)setupNavigationBar {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePan];
}


#pragma mark - Network



#pragma mark - API



#pragma mark - Method


- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan {
    float progress = [edgePan translationInView:self.view].x / KSCreenWidth;
    CGPoint point = [edgePan locationInView:[UIApplication sharedApplication].windows[0]];
    if (GetAppDelegate.detailViewController) {
        [FloatingWindow shareFloatingWindow].alpha = progress;
    }
    
    if (edgePan.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [UIPercentDrivenInteractiveTransition new];
        [self.navigationController popViewControllerAnimated:YES];
        if (!GetAppDelegate.detailViewController && self.delegate && [self.delegate respondsToSelector:@selector(didStartPanGesture)]) {
            [self.delegate didStartPanGesture];
        }
    }
    
    else if (edgePan.state == UIGestureRecognizerStateChanged) {
        [self.percentDrivenTransition updateInteractiveTransition:progress];
        if (!GetAppDelegate.detailViewController && self.delegate && [self.delegate respondsToSelector:@selector(didChangePanGesture:)]) {
            [self.delegate didChangePanGesture:point];
        }
    }
    else if (edgePan.state == UIGestureRecognizerStateEnded) {
        if (!GetAppDelegate.detailViewController && self.delegate && [self.delegate respondsToSelector:@selector(didEndPanGesture)]) {
            [self.delegate didEndPanGesture];
        }
        if (progress > 0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
            if (GetAppDelegate.detailViewController) {
                [FloatingWindow shareFloatingWindow].alpha = 1;
            }
        }
        else {
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
}

#pragma mark - Delegates

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if ([animationController isKindOfClass:[FloatingPopTransition class]]) {
        return self.percentDrivenTransition;
    }
    else {
        return nil;
    }
    
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [FloatingPopTransition new];
    }
    else {
        return nil;
    }
}


#pragma mark -- Lazy Load Methods



#pragma mark -- Super Method OverRide


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
