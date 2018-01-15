//
//  UIBezierPath+AnimationPathway.m
//  TestDynamicBehavior
//
//  Created by Sonia on 2017/11/27.
//  Copyright © 2017年 Sonia. All rights reserved.
//

#import "UIBezierPath+AnimationPathway.h"

@implementation UIBezierPath (AnimationPathway)

#define  KSCreenWidth   [[UIScreen mainScreen] bounds].size.width
#define  KSCreenHeight  [[UIScreen mainScreen] bounds].size.height
#define FlowMenuCellHeight 280
#define BigHeight FlowMenuCellHeight/4

+ (UIBezierPath *)startAtPoint:(CGPoint)point {
    UIBezierPath *animationBezier = [UIBezierPath bezierPath];
    [animationBezier moveToPoint:CGPointMake(-300, point.y-200)];
    [animationBezier addLineToPoint:CGPointMake(-300, point.y)];
    [animationBezier addLineToPoint:CGPointMake(0, point.y)];
    [animationBezier addLineToPoint:CGPointMake(point.x, point.y)];
    [animationBezier addQuadCurveToPoint:CGPointMake(point.x*4, BigHeight*2+point.y) controlPoint:CGPointMake(point.x*3, BigHeight*0.25+point.y)];
    [animationBezier addQuadCurveToPoint:CGPointMake(KSCreenWidth+10, BigHeight*2.75+point.y) controlPoint:CGPointMake(point.x*5, FlowMenuCellHeight+point.y)];
    [animationBezier addLineToPoint:CGPointMake(KSCreenWidth+10, point.y)];
    return animationBezier;
}

@end
