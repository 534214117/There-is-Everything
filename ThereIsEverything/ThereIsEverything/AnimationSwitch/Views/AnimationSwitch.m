//
//  AnimationSwitch.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/21.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "AnimationSwitch.h"


@interface AnimationSwitch() <CAAnimationDelegate>

@property (nonatomic, strong) UIView *presentView;

@end


@implementation AnimationSwitch

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(animationSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)animationSwitchValueChanged:(AnimationSwitch *)sender {
    if (sender.on) {
        [self circleOpen:[sender.subviews[0] convertRect:sender.subviews[0].subviews.lastObject.frame toView:self.superview]];
    }
    else {
        [self circleClose:[sender.subviews[0] convertRect:sender.subviews[0].subviews.lastObject.frame toView:self.superview]];
    }
}


- (void)circleOpen:(CGRect)startFrame {
    //@Protocol 在这个Demo中的作用是在改变背景颜色的时候，改变文字颜色，避免颜色相近导致看不清的问题
    if ([self.switchDelegate respondsToSelector:@selector(willBeginAnimte)]) {
        [self.switchDelegate willBeginAnimte];
    }
    
    //用于给动画CAShapeLayer作为载体的View
    self.presentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];
    self.presentView.backgroundColor = self.onTintColor;
    [self.superview insertSubview:self.presentView atIndex:0];
    
    //通过传入的frame计算UIBezierPath的起始位置
    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:CGRectMake(startFrame.origin.x+startFrame.size.width/2.f, startFrame.origin.y+startFrame.size.height/2.f, 0, 0)];
    
    CGFloat radius = sqrtf(powf((startFrame.origin.x+startFrame.size.width/2.f), 2)+powf((startFrame.origin.y+startFrame.size.height/2.f), 2));
    
    //通过radius计算UIBezierPath的结束位置 关于CGRectInset的作用不明白的可以自行搜索简书
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(startFrame, -radius, -radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    maskLayer.backgroundColor = (__bridge CGColorRef)([UIColor whiteColor]);
    self.presentView.layer.mask = maskLayer;
    
    //动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = 0.3f;
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.repeatCount = 1;
    maskLayerAnimation.removedOnCompletion = NO;
    maskLayerAnimation.fillMode = kCAFillModeForwards;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)circleClose:(CGRect)startFrame {
    if ([self.switchDelegate respondsToSelector:@selector(willEndAnimte)]) {
        [self.switchDelegate willEndAnimte];
    }
    
    self.presentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];
    self.presentView.backgroundColor = self.onTintColor;
    [self.superview insertSubview:self.presentView atIndex:0];
    
    self.superview.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:startFrame];
    CGFloat radius = sqrtf(powf((startFrame.origin.x+startFrame.size.width/2.f), 2)+powf((startFrame.origin.y+startFrame.size.height/2.f), 2));
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(startFrame, -radius, -radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    maskLayer.backgroundColor = (__bridge CGColorRef)([UIColor whiteColor]);
    self.presentView.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskFinalBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskStartBP.CGPath));
    maskLayerAnimation.duration = 0.3f;
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.repeatCount = 1;
    maskLayerAnimation.removedOnCompletion = NO;
    maskLayerAnimation.fillMode = kCAFillModeForwards;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    self.presentView.layer.mask = nil;
    [self.presentView removeFromSuperview];
    if (self.on) {
        self.superview.backgroundColor = self.onTintColor;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
