//
//  DownloadAnimationView.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/10.
//  Copyright © 2018年 Mine. All rights reserved.
//

#define BOUNDS CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
#define RADIUS self.frame.size.width > self.frame.size.height ? self.frame.size.height/2.f : self.frame.size.width/2.f
#define PROGRESSWIDTH 6
#define ICONWIDTH 2


#import "DownloadAnimationView.h"


@interface DownloadAnimationView ()

@property (nonatomic, strong) CAShapeLayer *waveLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CADisplayLink *waveDisplayLink;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) CGFloat move;
@property (nonatomic, assign) CGFloat waveX;

@end


@implementation DownloadAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.offset = 0;
        self.move = 1;
        [self setupDownloadProgress];
        [self setupDownloadIcon];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self waveAnimationStart];
        });
    }
    return self;
}

- (void)setupDownloadProgress {
    CAShapeLayer *progressBarLayer = [CAShapeLayer layer];
    UIBezierPath *progressBarPath = [UIBezierPath bezierPathWithRoundedRect:BOUNDS cornerRadius:RADIUS];
    
    progressBarLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
    progressBarLayer.lineWidth = PROGRESSWIDTH;
    progressBarLayer.path = progressBarPath.CGPath;
    progressBarLayer.fillColor = nil;
    [self.layer addSublayer:progressBarLayer];
}

- (void)setupDownloadIcon {
    
    self.waveLayer = [CAShapeLayer layer];
    UIBezierPath *wavePath = [self originWavePath];
    
    self.waveLayer.strokeColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    self.waveLayer.lineWidth = ICONWIDTH;
    self.waveLayer.path = wavePath.CGPath;
    self.waveLayer.fillColor = nil;
    UIView *waveView = [[UIView alloc] initWithFrame:CGRectMake(RADIUS*2/5.f, 0, RADIUS*6/5.f, CGRectGetHeight(self.frame))];
    [self addSubview:waveView];
    [waveView.layer addSublayer:self.waveLayer];
    
    self.progressLayer = [CAShapeLayer layer];
    UIBezierPath *progressPath = [self originProgressPath];
    
    self.progressLayer.strokeColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    self.progressLayer.lineWidth = ICONWIDTH;
    self.progressLayer.path = progressPath.CGPath;
    self.progressLayer.fillColor = nil;
    [self.layer addSublayer:self.progressLayer];
    
}


// 未开始状态
- (UIBezierPath *)originWavePath {
    UIBezierPath *originWavePath = [UIBezierPath bezierPath];
    [originWavePath moveToPoint:CGPointMake(RADIUS*1/5.f, RADIUS*2/1.8)];
    [originWavePath addLineToPoint:CGPointMake(RADIUS*3/5.f, RADIUS*2/1.4)];
    [originWavePath addLineToPoint:CGPointMake(RADIUS*5/5.f, RADIUS*2/1.8)];
    
    return originWavePath;
}

- (UIBezierPath *)originProgressPath {
    UIBezierPath *originProgressPath = [UIBezierPath bezierPath];
    [originProgressPath moveToPoint:CGPointMake(RADIUS, RADIUS*2 - (RADIUS*2/1.4))];
    [originProgressPath addLineToPoint:CGPointMake(RADIUS, RADIUS*2/1.4)];
    
    return originProgressPath;
}

// 中间经停状态
- (UIBezierPath *)tempWavePath {
    UIBezierPath *tempWavePath = [UIBezierPath bezierPath];
    [tempWavePath moveToPoint:CGPointMake(0, RADIUS-ICONWIDTH/2.f)];
    [tempWavePath addLineToPoint:CGPointMake(RADIUS*3/5.f, RADIUS-ICONWIDTH/2.f)];
    [tempWavePath addLineToPoint:CGPointMake(RADIUS*6/5.f, RADIUS-ICONWIDTH/2.f)];
    
    return tempWavePath;
}

- (UIBezierPath *)tempProgressPath {
    UIBezierPath *tempProgressPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(RADIUS, RADIUS-20, 1, 1) cornerRadius:PROGRESSWIDTH/2.f];
    
    return tempProgressPath;
}

// 开始下载前状态

- (UIBezierPath *)finalProgressPath {
    UIBezierPath *finalProgressPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(RADIUS, 0, 1, 1) cornerRadius:PROGRESSWIDTH/2.f];
    
    return finalProgressPath;
}

- (void)finalWavePath {
    CGFloat width = RADIUS*6/5.f;
    _waveX += 0.3;
    CGFloat _waveY = RADIUS;
    CGFloat _waveAmplitude = 10;
    CGFloat _wavePalstance = (M_PI/width)*3.f;
    
    CGFloat waterWaveWidth = width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, _waveAmplitude * cos(_waveX) + _waveY);
    //初始化波浪其实Y为偏距
    CGFloat y = _waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = _waveAmplitude * cos(_wavePalstance * x + _waveX) + _waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    self.waveLayer.path = path;
    CGPathRelease(path);

    
    
}

//- (UIBezierPath *)returnFinalWavePath:(CGFloat)controlPointOffset {
//    CGFloat width = RADIUS*6/5.f;
//    CGFloat onceWidth = width/3.f;
//    _waveX += 10;
//
//    UIBezierPath *finalWavePath = [UIBezierPath bezierPath];
//    [finalWavePath moveToPoint:CGPointMake(0, RADIUS-ICONWIDTH/2.f)];
//    [finalWavePath addQuadCurveToPoint:CGPointMake(0 + onceWidth, RADIUS-ICONWIDTH/2.f)
//                          controlPoint:CGPointMake(0 + onceWidth/2.f, RADIUS-ICONWIDTH/2.f - controlPointOffset)];
//    [finalWavePath addQuadCurveToPoint:CGPointMake(0 + 2*onceWidth, RADIUS-ICONWIDTH/2.f)
//                          controlPoint:CGPointMake(0 + onceWidth + onceWidth/2.f, RADIUS-ICONWIDTH/2.f + controlPointOffset)];
//    [finalWavePath addQuadCurveToPoint:CGPointMake(0 + 3*onceWidth, RADIUS-ICONWIDTH/2.f)
//                          controlPoint:CGPointMake(0 + 2*onceWidth + onceWidth/2.f, RADIUS-ICONWIDTH/2.f -  controlPointOffset)];
//
//    NSLog(@"%f",  controlPointOffset);
//    return finalWavePath;
//}




- (void)waveAnimationStart {
    CABasicAnimation *waveLayerAnimation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    waveLayerAnimation1.fromValue = (__bridge id)([self originWavePath].CGPath);
    waveLayerAnimation1.toValue = (__bridge id)([self tempWavePath].CGPath);
    waveLayerAnimation1.duration = 0.3;
    waveLayerAnimation1.repeatCount = 1;
    waveLayerAnimation1.removedOnCompletion = NO;
    waveLayerAnimation1.fillMode = kCAFillModeForwards;
    waveLayerAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.waveLayer addAnimation:waveLayerAnimation1 forKey:@"waveLayerPath1"];
    
//    CABasicAnimation *waveLayerAnimation2 = [CABasicAnimation animationWithKeyPath:@"path"];
//    waveLayerAnimation2.fromValue = (__bridge id)([self tempWavePath].CGPath);
//    waveLayerAnimation2.toValue = (__bridge id)([self finalWavePath]);
//    waveLayerAnimation2.duration = 0.3;
//    waveLayerAnimation2.beginTime = CACurrentMediaTime() + 0.3;
//    waveLayerAnimation2.repeatCount = 1;
//    waveLayerAnimation2.removedOnCompletion = NO;
//    waveLayerAnimation2.fillMode = kCAFillModeForwards;
//    waveLayerAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    [self.waveLayer addAnimation:waveLayerAnimation2 forKey:@"waveLayerPath2"];
    
    CABasicAnimation *progressLayerAnimation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    progressLayerAnimation1.fromValue = (__bridge id)([self originProgressPath].CGPath);
    progressLayerAnimation1.toValue = (__bridge id)([self tempProgressPath].CGPath);
    progressLayerAnimation1.duration = 0.3;
    progressLayerAnimation1.repeatCount = 1;
    progressLayerAnimation1.removedOnCompletion = NO;
    progressLayerAnimation1.fillMode = kCAFillModeForwards;
    progressLayerAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.progressLayer addAnimation:progressLayerAnimation1 forKey:@"progressLayerPath1"];
    
    CABasicAnimation *progressLayerAnimation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    progressLayerAnimation2.fromValue = (__bridge id)([self tempProgressPath].CGPath);
    progressLayerAnimation2.toValue = (__bridge id)([self finalProgressPath].CGPath);
    progressLayerAnimation2.duration = 0.3;
    progressLayerAnimation2.beginTime = CACurrentMediaTime() + 0.3;
    progressLayerAnimation2.repeatCount = 1;
    progressLayerAnimation2.removedOnCompletion = NO;
    progressLayerAnimation2.fillMode = kCAFillModeForwards;
    progressLayerAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.progressLayer addAnimation:progressLayerAnimation2 forKey:@"progressLayerPath2"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self finalWavePath];
        self.progressLayer.path = [self finalProgressPath].CGPath;
        [self.waveLayer removeAllAnimations];
        [self.progressLayer removeAllAnimations];
        [self setupDisplayLink];
    });
}



- (void)setupDisplayLink {
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.waveDisplayLink.paused = NO;
}

- (void)wave {
    [self finalWavePath];
}




@end
