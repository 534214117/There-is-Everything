//
//  FloatingWindow.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/5/30.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "FloatingWindow.h"
#import <SDAutoLayout.h>
#import <POP.h>

#define WindowSize 60

@interface FloatingWindow () <POPAnimationDelegate>

@property (nonatomic, strong) UIButton *imgButton;

@end

@implementation FloatingWindow

+ (FloatingWindow *)shareFloatingWindow
{
    static FloatingWindow *handleFloatingWindow = nil;
    static dispatch_once_t FloatingWindowToken;
    dispatch_once(&FloatingWindowToken, ^{
        if (handleFloatingWindow == nil) {
            handleFloatingWindow = [[FloatingWindow alloc] init];
            handleFloatingWindow.layer.backgroundColor = RGB(255, 83, 89).CGColor;
            handleFloatingWindow.layer.cornerRadius = 30;
            handleFloatingWindow.userInteractionEnabled = YES;
            [handleFloatingWindow addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:handleFloatingWindow action:@selector(panGesture:)]];
            handleFloatingWindow.hidden = YES;
            
            handleFloatingWindow.imgButton = [[UIButton alloc] init];
            handleFloatingWindow.imgButton.layer.backgroundColor = RGB(179, 179, 179).CGColor;
            handleFloatingWindow.imgButton.layer.cornerRadius = 25;
            [handleFloatingWindow.imgButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [handleFloatingWindow.imgButton addTarget:handleFloatingWindow action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
            [handleFloatingWindow addSubview:handleFloatingWindow.imgButton];
            
            [[UIApplication sharedApplication].windows[0] addSubview:handleFloatingWindow];
            
            handleFloatingWindow.sd_layout
            .rightSpaceToView([UIApplication sharedApplication].windows[0], 20)
            .topSpaceToView([UIApplication sharedApplication].windows[0], K_NavigationBarHeight+50)
            .widthIs(WindowSize)
            .heightIs(WindowSize);
            
            handleFloatingWindow.imgButton.sd_layout
            .spaceToSuperView(UIEdgeInsetsMake(5, 5, 5, 5));
        }
    });
    return handleFloatingWindow;
}

- (void)viewWillAppearOrGestureIntoFloatingControlView {
    self.alpha = 0;
    self.hidden = NO;
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    animation.toValue = @(1);
    animation.beginTime = CACurrentMediaTime();
    animation.duration = 0.5;
    [self pop_addAnimation:animation forKey:@"BasicAnimationAlpha"];
    self.userInteractionEnabled = YES;
}

- (void)viewWillDisappearAndGestureIntoFloatingControlView:(BOOL)reset {
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    animation.toValue = @(0);
    animation.beginTime = CACurrentMediaTime();
    animation.duration = 0.2;
    [self pop_addAnimation:animation forKey:@"BasicAnimationAlpha"];
    self.userInteractionEnabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        if (!GetAppDelegate.detailViewController) {
            [FloatingWindow shareFloatingWindow].frame = CGRectMake(KSCreenWidth-20-WindowSize, K_NavigationBarHeight+50, WindowSize, WindowSize);
        }
    });
}


- (void)detailAction:(UIButton *)sender {
    [(UINavigationController *)[self getCurrentVC] pushViewController:GetAppDelegate.detailViewController animated:YES];
}





- (void)panGesture:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didStartPanGesture)]) {
            [self.delegate didStartPanGesture];
        }
        return;
    }
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [panGesture translationInView:[UIApplication sharedApplication].windows[0]];
        panGesture.view.centerX += point.x;
        panGesture.view.centerY += point.y;
        [panGesture setTranslation:CGPointMake(0, 0) inView:[UIApplication sharedApplication].windows[0]];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didChangePanGesture:)]) {
            [self.delegate didChangePanGesture:panGesture.view.center];
        }
        return;
    }
    
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didEndPanGesture)]) {
            [self.delegate didEndPanGesture];
        }
        
        CGRect frame = panGesture.view.frame;
        BOOL needReset = NO;
        if (panGesture.view.right >= KSCreenWidth/2.f) {
            needReset = YES;
            frame.origin.x = KSCreenWidth-20-WindowSize;
        }
        else if (panGesture.view.left < KSCreenWidth/2.f) {
            needReset = YES;
            frame.origin.x = 20;
        }
        
        if (panGesture.view.top < K_NavigationBarHeight+20) {
            needReset = YES;
            frame.origin.y = K_NavigationBarHeight+20;
        }
        else if (panGesture.view.bottom > KSCreenHeight-20) {
            needReset = YES;
            frame.origin.y = KSCreenHeight-WindowSize-20;
        }
        
        if (needReset) {
            POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
            animation.toValue = @(frame);
            animation.beginTime = CACurrentMediaTime();
            animation.duration = 0.2;
            animation.delegate = self;
            [panGesture.view pop_addAnimation:animation forKey:@"BasicAnimation"];
            self.userInteractionEnabled = NO;
        }
    }
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    if (finished) {
        self.userInteractionEnabled = YES;
    }
}




//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
