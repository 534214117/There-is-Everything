//
//  LoadingAnimationView.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/21.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "LoadingAnimationView.h"

#define Distance 40
#define SumTime 1.f

@interface LoadingAnimationView ()


@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) BOOL isLeft;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LoadingAnimationView {
    CGFloat r1;
    CGFloat r2;
    CGFloat x1;
    CGFloat y1;
    CGFloat x2;
    CGFloat y2;
    CGFloat centerDistance;
    CGFloat cosDigree;
    CGFloat sinDigree;
    
    CGPoint pointA; // A
    CGPoint pointB; // B
    CGPoint pointD; // D
    CGPoint pointC; // C
    CGPoint pointO; // O
    CGPoint pointP; // P
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupBackView];
        [self setupFrontView];
        [self setup];
        [self setupDisplayLink];
        
    }
    return self;
}

- (void)setupBackView {
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame)/2.f, CGRectGetHeight(self.frame)/2.f)];
    self.backView.center = CGPointMake(CGRectGetWidth(self.frame)/2.f, CGRectGetHeight(self.frame)/2.f+5);
    self.backView.layer.cornerRadius = CGRectGetWidth(self.frame)/4.f;
    self.backView.layer.backgroundColor = RGB(254, 67, 101).CGColor;
    [self addSubview:self.backView];
    
    r1 = CGRectGetWidth(self.frame)/4.f;
}

- (void)setupFrontView {
    self.frontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.frontView.center = CGPointMake(CGRectGetWidth(self.frame)/2.f, CGRectGetHeight(self.frame)/2.f+5);
    self.frontView.layer.cornerRadius = CGRectGetWidth(self.frame)/2.f;
    self.frontView.layer.backgroundColor = RGB(254, 67, 101).CGColor;
    [self addSubview:self.frontView];
    
    r2 = CGRectGetWidth(self.frame)/2.f;
}

- (void)setup {
    
    x1 = self.backView.center.x;
    y1 = self.backView.center.y;
    x2 = self.frontView.center.x;
    y2 = self.frontView.center.y;
    
    pointA = CGPointMake(x1, y1 - r1); // A
    pointB = CGPointMake(x1, y1 + r1); // B
    pointD = CGPointMake(x2, y2 - r2); // D
    pointC = CGPointMake(x2, y2 + r2); // C
    pointO = CGPointMake(x1, y1 - r1); // O
    pointP = CGPointMake(x2, y2 - r2); // P
    
    
    
    
    
}

- (void)setupDisplayLink {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    self.displayLink.paused = YES;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}


- (void)startAnimate {
    self.displayLink.paused = NO;
    
    self.timer = [NSTimer timerWithTimeInterval:SumTime target:self selector:@selector(animate) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopAnimate {
    self.displayLink.paused = YES;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)animate {
    int x;
    if (self.isLeft) {
        x = Distance;
    }
    else {
        x = -Distance;
    }
    self.isLeft = !self.isLeft;
    [UIView animateWithDuration:SumTime/2.f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect backFrame = self.backView.frame;
        backFrame.origin.x -= x;
        self.backView.frame = backFrame;
        
        CGPoint frontCenter = self.frontView.center;
        CGRect frontRect = self.frontView.frame;
        frontRect.size.width -= 5;
        frontRect.size.height -= 5;
        self.frontView.layer.cornerRadius = frontRect.size.width/2.f;
        self.frontView.frame = frontRect;
        self.frontView.center = frontCenter;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:SumTime/2.f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self.backView.frame;
            frame.origin.x += x;
            self.backView.frame = frame;
            
                    CGPoint frontCenter = self.frontView.center;
                    CGRect frontRect = self.frontView.frame;
                    frontRect.size.width += 5;
                    frontRect.size.height += 5;
                    self.frontView.layer.cornerRadius = frontRect.size.width/2.f;
                    self.frontView.frame = frontRect;
                    self.frontView.center = frontCenter;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    
}

- (void)displayLinkAction {
    
    CALayer *layer1 = self.backView.layer.presentationLayer;
    x1 = layer1.position.x;
    y1 = layer1.position.y;
    
    CALayer *layer2 = self.frontView.layer.presentationLayer;
    x2 = layer2.position.x;
    y2 = layer2.position.y;
    r2 = layer2.cornerRadius;

    centerDistance = x2 - x1;
    CGFloat cutDistance = 0;
    
    pointA = CGPointMake(x1, y1 - r1); // A
    pointB = CGPointMake(x1, y1 + r1); // B
    pointD = CGPointMake(x2, y2 - r2); // D
    pointC = CGPointMake(x2, y2 + r2); // C
    if (fabs(centerDistance) > r1+r2) {
        cutDistance = (fabs(centerDistance)-r1-r2);
    }
    pointO = CGPointMake(pointA.x + (centerDistance / 2), pointA.y+cutDistance);
    pointP = CGPointMake(pointB.x + (centerDistance / 2), pointB.y-cutDistance);
    
    [self drawRect];
}

- (void)drawRect {
    UIBezierPath *cutePath = [UIBezierPath bezierPath];
    [cutePath moveToPoint:pointA];
    [cutePath addQuadCurveToPoint:pointD controlPoint:pointO];
    [cutePath addLineToPoint:pointC];
    [cutePath addQuadCurveToPoint:pointB controlPoint:pointP];
    [cutePath closePath];
    
    if (fabs(centerDistance) > Distance*0.8) {
        [self.loadingShapeLayer removeFromSuperlayer];
        return;
    }
    
    if (!self.loadingShapeLayer) {
        self.loadingShapeLayer = [CAShapeLayer layer];
    }
    else {
        [self.loadingShapeLayer removeFromSuperlayer];
    }
    self.loadingShapeLayer.path = cutePath.CGPath;
    self.loadingShapeLayer.fillColor = RGB(254, 67, 101).CGColor;
    [self.layer insertSublayer:self.loadingShapeLayer below:self.frontView.layer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
