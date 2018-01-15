//
//  CAShapeLayer+CAShapeLayerMore.h
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/9.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (CAShapeLayerMore)

+ (CAShapeLayer *)circleOpenLayerWithStartFrame:(CGRect)startFrame inView:(UIView *)view delegateTo:(id)receiveDelegate;

@end
