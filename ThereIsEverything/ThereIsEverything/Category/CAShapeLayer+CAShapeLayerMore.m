//
//  CAShapeLayer+CAShapeLayerMore.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/9.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "CAShapeLayer+CAShapeLayerMore.h"

@implementation CAShapeLayer (CAShapeLayerMore)

+ (CAShapeLayer *)circleOpenLayerWithStartFrame:(CGRect)startFrame inView:(UIView *)view delegateTo:(id)receiveDelegate {
    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:startFrame];
    CGFloat radius = view.bounds.size.width;
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(startFrame, -radius, -radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = 0.3f;
    maskLayerAnimation.repeatCount = 1;
    maskLayerAnimation.delegate = receiveDelegate;
    maskLayerAnimation.removedOnCompletion = NO;
    maskLayerAnimation.fillMode = kCAFillModeForwards;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    return maskLayer;
}


@end
