//
//  JellyCustomNavigationBar.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/21.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "JellyCustomNavigationBar.h"
#import "LoadingAnimationView.h"

#define KVO_EndPoint @"endAnimatePoint"
#define Refresh_Height 200.f

@interface JellyCustomNavigationBar ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) UIView *referencePointView;
@property (nonatomic) CGPoint endAnimatePoint;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic, strong) UILabel *titleLabel;


@property (nonatomic, assign) BOOL refreshState;

@property (nonatomic, strong) LoadingAnimationView *loadingAnimationView;

@end


@implementation JellyCustomNavigationBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupShapeLayer];
        [self setupReferencePointView];
        [self setupDisplayLink];
        [self setupLoadingAnimationView];
        [self setupKVO];
        [self setup];
        
    }
    return self;
}

- (void)setup {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, K_StatusBarHeight, CGRectGetWidth(self.frame)-120, CGRectGetHeight(self.frame)-K_StatusBarHeight)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, K_StatusBarHeight+(CGRectGetHeight(self.frame)-K_StatusBarHeight-40)/2.f, 40, 40)];
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backButton setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    self.backButton.hidden = YES;
    [self addSubview:self.backButton];
}

- (void)setupShapeLayer {
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = RGB(252, 157, 154).CGColor;
    [self.layer addSublayer:self.shapeLayer];
}

- (void)setupReferencePointView {
    self.referencePointView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2.f-2, CGRectGetMaxY(self.frame)-2, 4, 4)];
    self.referencePointView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.referencePointView];
}

- (void)setupDisplayLink {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePath:)];
    self.displayLink.paused = YES;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)setupLoadingAnimationView {
    CGFloat width = CGRectGetHeight(self.frame) - K_StatusBarHeight - 10;
    CGFloat x = (CGRectGetWidth(self.frame)-width)/2.f;
    CGFloat y = K_StatusBarHeight;
    self.loadingAnimationView = [[LoadingAnimationView alloc] initWithFrame:CGRectMake(x, y, width, width)];
    self.loadingAnimationView.alpha = 0;
    [self addSubview:self.loadingAnimationView];
}


- (void)setupKVO {
    [self addObserver:self forKeyPath:KVO_EndPoint options:NSKeyValueObservingOptionNew context:nil];
    self.endAnimatePoint = CGPointMake(CGRectGetWidth(self.frame)/2.f-2, CGRectGetMaxY(self.frame)-2);
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:KVO_EndPoint]) {
        [self updateShapeLayerPath];
    }
}


- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)showBackButton:(BOOL)state {
    self.backButton.hidden = !state;
}


- (void)animateStateChangeAtX:(CGFloat)x y:(CGFloat)y {
    if (!self.isAnimating) {
        if ((y*0.7 + CGRectGetHeight(self.frame)) > CGRectGetHeight(self.frame)) {
            CGFloat mHeight = y*0.7 + CGRectGetHeight(self.frame);
            CGFloat mWidth = x + CGRectGetWidth(self.frame)/2.f;
            self.endAnimatePoint = CGPointMake(mWidth-2, mHeight-2);
            self.referencePointView.frame = CGRectMake(mWidth-2, mHeight-2, 4, 4);
            self.titleLabel.alpha = (Refresh_Height-y)/Refresh_Height;
            self.loadingAnimationView.alpha = y/Refresh_Height;
        }
        if (y > Refresh_Height) {
            self.refreshState = YES;
        }
        else {
            self.refreshState = NO;
        }
    }
    
}

- (void)animateStateEnd {
    if (!self.isAnimating) {
        self.isAnimating = YES;
        self.displayLink.paused = NO;
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.referencePointView.frame = CGRectMake(CGRectGetWidth(self.frame)/2.f-2, CGRectGetMaxY(self.frame)-2, 4, 4);
            if (!self.refreshState) {
                self.titleLabel.alpha = 1;
                self.loadingAnimationView.alpha = 0;
            }
            else {
                self.titleLabel.alpha = 0;
                self.loadingAnimationView.alpha = 1;
            }
        } completion:^(BOOL finished) {
            if (finished) {
                self.isAnimating = NO;
                self.displayLink.paused = YES;
            }
        }];
        
        if (self.refreshState) {
            [self.loadingAnimationView startAnimate];
            [self performSelector:@selector(stopAnimate) withObject:nil afterDelay:5];
        }
    }
}

- (void)stopAnimate {
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.titleLabel.alpha = 1;
        self.loadingAnimationView.alpha = 0;
    } completion:^(BOOL finished) {
        self.refreshState = NO;
        [self.loadingAnimationView stopAnimate];
    }];
}




- (void)updateShapeLayerPath {
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(0, 0)];
    [tPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [tPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame))];
    [tPath addQuadCurveToPoint:CGPointMake(0, CGRectGetHeight(self.frame)) controlPoint:CGPointMake(self.endAnimatePoint.x, self.endAnimatePoint.y)];
    [tPath closePath];
    self.shapeLayer.path = tPath.CGPath;
}

- (void)updatePath:(CADisplayLink *)displayLink {
    CALayer *layer = self.referencePointView.layer.presentationLayer;
    self.endAnimatePoint = CGPointMake(layer.position.x, layer.position.y);
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:KVO_EndPoint];
}


@end
