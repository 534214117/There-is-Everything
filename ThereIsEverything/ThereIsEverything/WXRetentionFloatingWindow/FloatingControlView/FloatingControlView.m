//
//  FloatingControlView.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/5/30.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "FloatingControlView.h"
#import <SDAutoLayout.h>
#import <POP.h>

#define WindowSize 200


@interface FloatingControlView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL didContain;

@end

@implementation FloatingControlView

+ (FloatingControlView *)shareFloatingControlView
{
    static FloatingControlView *handleFloatingControlView = nil;
    static dispatch_once_t FloatingControlViewToken;
    dispatch_once(&FloatingControlViewToken, ^{
        if (handleFloatingControlView == nil) {
            handleFloatingControlView = [[FloatingControlView alloc] init];
            handleFloatingControlView.layer.backgroundColor = RGB(242, 242, 242).CGColor;
            handleFloatingControlView.layer.cornerRadius = WindowSize/2.f;
            handleFloatingControlView.userInteractionEnabled = NO;
            
            handleFloatingControlView.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Knob_OFF"]];
            [handleFloatingControlView addSubview:handleFloatingControlView.imageView];
            
            [[UIApplication sharedApplication].windows[0] addSubview:handleFloatingControlView];
            handleFloatingControlView.didContain = NO;
            
            
            handleFloatingControlView.sd_layout
            .rightSpaceToView([UIApplication sharedApplication].windows[0], -WindowSize)
            .bottomSpaceToView([UIApplication sharedApplication].windows[0], -WindowSize)
            .widthIs(WindowSize)
            .heightIs(WindowSize);
            
            handleFloatingControlView.imageView.sd_layout
            .centerXIs(WindowSize/3.f)
            .centerYIs(WindowSize/3.f)
            .widthIs(WindowSize/3.f)
            .heightIs(WindowSize/3.f);
            
        }
    });
    return handleFloatingControlView;
}


- (void)didChangePanGesture:(CGPoint)centerPoint {
    CGPoint point = [self convertPoint:centerPoint fromView:[UIApplication sharedApplication].windows[0]];
    if (!self.didContain) {
        if (point.x > 0 && point.y > 0) {
            self.didContain = YES;
            [self impactFeedback];
            [self containAnimation];
        }
    }
    else {
        if (point.x <= 0 || point.y <= 0) {
            self.didContain = NO;
            [self containAnimation];
        }
    }
    NSLog(@"%f %f", point.x, point.y);
}

- (void)didEndPanGesture {
    CGRect frame = CGRectMake(KSCreenWidth, KSCreenHeight, WindowSize, WindowSize);
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.toValue = @(frame);
    animation.beginTime = CACurrentMediaTime();
    animation.duration = 0.5;
    [self pop_addAnimation:animation forKey:@"BasicAnimation"];
    
    if (self.didContain) {
        if (!GetAppDelegate.detailViewController) {
            [[FloatingWindow shareFloatingWindow] viewWillAppearOrGestureIntoFloatingControlView];
            if (self.delegate && [self.delegate respondsToSelector:@selector(didContain:)]) {
                [self.delegate didContain:YES];
                self.layer.backgroundColor = RGB(255, 83, 89).CGColor;
                self.imageView.image = [UIImage imageNamed:@"Knob_OFF"];
            }
        }
        else {
            [[FloatingWindow shareFloatingWindow] viewWillDisappearAndGestureIntoFloatingControlView:YES];
            if (self.delegate && [self.delegate respondsToSelector:@selector(didContain:)]) {
                [self.delegate didContain:NO];
                self.layer.backgroundColor = RGB(242, 242, 242).CGColor;
                self.imageView.image = [UIImage imageNamed:@"Knob_ON"];
            }
        }
    }
    else {
        GetAppDelegate.tempDetailViewController = nil;
    }
}

- (void)didStartPanGesture {
    CGRect frame = CGRectMake(KSCreenWidth-WindowSize/1.7f, KSCreenHeight-WindowSize/1.7f, WindowSize, WindowSize);
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.toValue = @(frame);
    animation.beginTime = CACurrentMediaTime();
    animation.duration = 0.5;
    [self pop_addAnimation:animation forKey:@"BasicAnimation"];
}

- (void)impactFeedback {
    UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
    [impactLight impactOccurred];
}

- (void)containAnimation {
    CGRect frame;
    if (self.didContain) {
        frame = CGRectMake(KSCreenWidth-WindowSize/1.4f, KSCreenHeight-WindowSize/1.4f, WindowSize, WindowSize);
    }
    else {
        frame = CGRectMake(KSCreenWidth-WindowSize/1.7f, KSCreenHeight-WindowSize/1.7f, WindowSize, WindowSize);
    }
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.toValue = @(frame);
    animation.beginTime = CACurrentMediaTime();
    animation.duration = 0.2;
    [self pop_addAnimation:animation forKey:@"BasicAnimation"];
}


@end
