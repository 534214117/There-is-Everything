//
//  CardChooseView.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/4.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "CardChooseView.h"
#import "CustomCardView.h"

#define MARGIN 20
#define Width self.frame.size.width
#define Height self.frame.size.height

#define Scale 0.9
#define FrontFrame CGRectMake(MARGIN, MARGIN*3, Width-MARGIN*2, Height-MARGIN*4)
#define FrontCenter CGPointMake(MARGIN+(Width-MARGIN*2)/2.f, MARGIN*3+(Height-MARGIN*4)/2.f)
#define MiddleCenter CGPointMake(MARGIN+(Width-MARGIN*2)/2.f, (MARGIN*3+(Height-MARGIN*4)/2.f)-(Height-MARGIN*4)*(1-Scale)/2.f-MARGIN)
#define BottomCenter CGPointMake(MARGIN+(Width-MARGIN*2)/2.f, (MARGIN*3+(Height-MARGIN*4)/2.f)-(Height-MARGIN*4)*(1-Scale*Scale)/2.f-MARGIN*2)
#define FadeInCenter CGPointMake(MARGIN+(Width-MARGIN*2)/2.f, (MARGIN*3+(Height-MARGIN*4)/2.f)-(Height-MARGIN*4)*(1-Scale*Scale*Scale)/2.f-MARGIN*3)

#define FrontTransform CGAffineTransformIdentity
#define MiddleTransform CGAffineTransformMakeScale(Scale, Scale)
#define BottomTransform CGAffineTransformMakeScale(Scale*Scale, Scale*Scale)
#define FadeInTransform CGAffineTransformMakeScale(Scale*Scale*Scale, Scale*Scale*Scale)
//#define MiddleFrame CGRectMake(MARGIN*2, MARGIN*2, Width-MARGIN*4, Height-MARGIN*4)
//#define BottomFrame CGRectMake(MARGIN*3, MARGIN*1, Width-MARGIN*6, Height-MARGIN*4)
//#define FadeInFrame CGRectMake(MARGIN*4, MARGIN*0, Width-MARGIN*8, Height-MARGIN*4)

@interface CardChooseView ()

@property (nonatomic, strong) CustomCardView *customCardView;
@property (nonatomic, assign) int index;

@end


@implementation CardChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
        [self addGestureRecognizer:pan];
        
        self.index = 2;
        [self setupCustomCardView];
    }
    return self;
}

- (void)panGestureHandle:(UIPanGestureRecognizer *)panGesture {
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint pt = [panGesture translationInView:self.customCardView];
        self.customCardView.center = CGPointMake(self.customCardView.center.x+pt.x, self.customCardView.center.y+pt.y);
        CGFloat angle = (self.customCardView.center.x-KSCreenWidth/2.f)/KSCreenWidth*M_PI_4;
        self.customCardView.transform = CGAffineTransformMakeRotation(angle);
    }
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        if (fabs(self.customCardView.center.x-KSCreenWidth/2.f) > 130) {
            [self updateNextCard];
        }
        else {
            [self updateRecover];
        }
    }
    
    [panGesture setTranslation:CGPointMake(0, 0) inView:self.customCardView];

    
}

- (void)updateNextCard {
    CGFloat move = self.customCardView.center.x-KSCreenWidth/2.f > 0 ? KSCreenWidth : -KSCreenWidth;
    __block UIView *snapView = [self.customCardView snapshotViewAfterScreenUpdates:YES];
    snapView.center = self.customCardView.center;
    snapView.transform = self.customCardView.transform;
    [self addSubview:snapView];
    
    self.customCardView = self.customCardView.nextView;
    [self.customCardView.nextView.nextView removeFromSuperview];
    self.customCardView.nextView.nextView = nil;
    self.customCardView.nextView.nextView = [[CustomCardView alloc] initWithFrame:FrontFrame];
    self.customCardView.nextView.nextView.transform = FadeInTransform;
    self.customCardView.nextView.nextView.center = FadeInCenter;
    self.customCardView.nextView.nextView.nextView = self.customCardView;
    self.customCardView.nextView.nextView.model = self.modelArray[++self.index];
    [self insertSubview:self.customCardView.nextView.nextView atIndex:0];
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        snapView.alpha = 0;
        snapView.frame = CGRectMake(self.customCardView.frame.origin.x+move, self.customCardView.frame.origin.y+move/4., self.customCardView.frame.size.width, self.customCardView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            
            [snapView removeFromSuperview];
            snapView = nil;
            
        }
    }];
    
    [UIView animateWithDuration:2 delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.customCardView.transform = FrontTransform;
        self.customCardView.center = FrontCenter;
    } completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:2 delay:0.3 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.customCardView.nextView.transform = MiddleTransform;
        self.customCardView.nextView.center = MiddleCenter;
    } completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:2 delay:0.4 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.customCardView.nextView.nextView.transform = BottomTransform;
        self.customCardView.nextView.nextView.center = BottomCenter;
        self.customCardView.nextView.nextView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)updateRecover {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.customCardView.transform = CGAffineTransformMakeRotation(0);
        self.customCardView.frame = FrontFrame;
    } completion:^(BOOL finished) {
        self.customCardView.transform = CGAffineTransformMakeRotation(0);
        self.customCardView.frame = FrontFrame;
    }];
}




- (void)setupCustomCardView {
    self.customCardView = [[CustomCardView alloc] initWithFrame:FrontFrame delay:0.5];
    self.customCardView.nextView = [[CustomCardView alloc] initWithFrame:FrontFrame delay:0.6];
    self.customCardView.nextView.nextView = [[CustomCardView alloc] initWithFrame:FrontFrame delay:0.7];
    self.customCardView.nextView.nextView.nextView = self.customCardView;
    
    self.customCardView.nextView.transform = MiddleTransform;
    self.customCardView.nextView.center = MiddleCenter;
    self.customCardView.nextView.nextView.transform = BottomTransform;
    self.customCardView.nextView.nextView.center = BottomCenter;
    
    
    [self addSubview:self.customCardView.nextView.nextView];
    [self addSubview:self.customCardView.nextView];
    [self addSubview:self.customCardView];
}


- (void)setModelArray:(NSArray<CustomCardModel *> *)modelArray {
    for (int i = 0; i < modelArray.count; i++) {
        CustomCardModel *model = modelArray[i];
        model.index = [NSString stringWithFormat:@"%d", i+1];
        model.allCount = [NSString stringWithFormat:@"%d", (int)modelArray.count];
    }
    
    _modelArray = modelArray;
    if (modelArray.count <= 0) {
        self.customCardView.hidden = YES;
        self.customCardView.nextView.hidden = YES;
        self.customCardView.nextView.nextView.hidden = YES;
        return;
    }
    else {
        if (modelArray.count < 3) {
            self.customCardView.nextView.nextView.hidden = YES;
        }
        if (modelArray.count < 2) {
            self.customCardView.nextView.hidden = YES;
        }
    }
    
    self.customCardView.model = modelArray[0];
    self.customCardView.nextView.model = modelArray[1];
    self.customCardView.nextView.nextView.model = modelArray[2];
}

@end
