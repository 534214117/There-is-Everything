//
//  MenuScrollView.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/29.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "MenuScrollView.h"

typedef NS_ENUM(NSInteger, MenuScrollViewItemState) {
    MenuScrollViewItemStateSmall,
    MenuScrollViewItemStateBig,
};

typedef NS_ENUM(NSInteger, AnimationState) {
    AnimationStateAnimateStop,
    AnimationStateAnimateStarting,
};

#define BigItemCount 5.f
#define AnimationDuration 0.4
#define ViewDidAppearAnimationDuration 2
#define Delay AnimationDuration*(1/BigItemCount)

#define SmallFullItemHeight self.frame.size.height
#define SmallFullItemWidth self.frame.size.width/self.imagesArray.count
#define BigFullItemHeight self.frame.size.height
#define BigFullItemWidth self.frame.size.width/BigItemCount
#define SmallRealItemWidthHeight 10
#define BigRealItemWidthHeight (BigFullItemHeight-20)

@interface MenuScrollView ()

@property (nonatomic, strong) UIButton *activateButton;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *itemOriginFrameArray;
@property (nonatomic, strong) NSMutableArray *itemAnimteFrameArray;
@property (nonatomic, strong) NSMutableArray *itemImageViewArray;

@property (nonatomic, assign) MenuScrollViewItemState itemState;
@property (nonatomic, assign) AnimationState animationState;

@property (nonatomic, assign) int stateX;

@end


@implementation MenuScrollView

- (instancetype)initWithItemImages:(NSArray *)images viewOriginY:(CGFloat)y viewHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(0, y, KSCreenWidth, height)];
    if (self) {
        self.contentSize = CGSizeMake(KSCreenWidth, height);
        self.imagesArray = images;
        self.itemState = MenuScrollViewItemStateSmall;
        self.animationState = AnimationStateAnimateStop;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        
        for (int i = 0; i < self.imagesArray.count; i++) {
            NSString *imageString = self.imagesArray[i];
            UIImage *image = [UIImage imageNamed:imageString];
            UIButton *buttonView = [[UIButton alloc] init];
            buttonView.tag = i + 1000;
            [buttonView setImage:image forState:UIControlStateNormal];
            [buttonView setImage:image forState:UIControlStateSelected];
            [buttonView setImage:image forState:UIControlStateHighlighted];
            [buttonView addTarget:self action:@selector(willBeginAnimateSmall:) forControlEvents:UIControlEventTouchUpInside];
//            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            CGRect originFrame = CGRectMake(i*SmallFullItemWidth+(SmallFullItemWidth-SmallRealItemWidthHeight)/2.f, (BigFullItemHeight-SmallRealItemWidthHeight)/2.f, SmallRealItemWidthHeight, SmallRealItemWidthHeight);
            CGRect animateFrame = CGRectMake(i*BigFullItemWidth+(BigFullItemWidth-BigRealItemWidthHeight)/2.f, (BigFullItemHeight-BigRealItemWidthHeight)/2.f, BigRealItemWidthHeight, BigRealItemWidthHeight);
            buttonView.frame = CGRectMake(i*SmallFullItemWidth+(SmallFullItemWidth-SmallRealItemWidthHeight)/2.f, (BigFullItemHeight-SmallRealItemWidthHeight)/2.f-2*height, SmallRealItemWidthHeight, SmallRealItemWidthHeight);
            [self addSubview:buttonView];
            
            [self.itemOriginFrameArray addObject:@[@(originFrame.origin.x), @(originFrame.origin.y), @(originFrame.size.width), @(originFrame.size.height)]];
            [self.itemAnimteFrameArray addObject:@[@(animateFrame.origin.x), @(animateFrame.origin.y), @(animateFrame.size.width), @(animateFrame.size.height)]];
            [self.itemImageViewArray addObject:buttonView];

        }
        
        [self initActivateButton];
    }
    return self;
}

- (void)initActivateButton {
    self.activateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.activateButton addTarget:self action:@selector(willBeginAnimateBig:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.activateButton];
}

- (void)willBeginAnimateBig:(UIButton *)sender {
    if (self.menuDelegate && [self.menuDelegate respondsToSelector:@selector(menuWillBeginAnimteBig)]) {
        [self.menuDelegate menuWillBeginAnimteBig];
    }
    [sender removeFromSuperview];
    sender = nil;
    [self startAnimateBig];
}

- (void)willBeginAnimateSmall:(UIButton *)sender {
    if (self.menuDelegate && [self.menuDelegate respondsToSelector:@selector(menuWillBeginAnimteSmall)]) {
        [self.menuDelegate menuWillBeginAnimteSmall];
    }
    NSLog(@"%d", (int)sender.tag-1000);
    [self initActivateButton];
    [self startAnimateSmall];
}


- (void)startAnimateBig {
    if (self.itemState == MenuScrollViewItemStateSmall && self.animationState == AnimationStateAnimateStop) {
        
        self.animationState = AnimationStateAnimateStarting;
        
        for (int i = 0; i < self.imagesArray.count; i++) {
            [UIView animateWithDuration:AnimationDuration delay:i*Delay usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                UIImageView *imageView =  self.itemImageViewArray[i];
                NSArray *frameArray = self.itemAnimteFrameArray[i];
                imageView.frame = CGRectMake([frameArray[0] floatValue], [frameArray[1] floatValue], [frameArray[2] floatValue], [frameArray[3] floatValue]);
                
            } completion:^(BOOL finished) {
                
                self.itemState = MenuScrollViewItemStateBig;
                int page = self.imagesArray.count%5 == 0 ? (int)(self.imagesArray.count/5) : (int)(self.imagesArray.count/5) + 1;
                self.contentSize = CGSizeMake(KSCreenWidth*page, self.frame.size.height);
                self.animationState = AnimationStateAnimateStop;
                
            }];
        }
        
    }
}

- (void)startAnimateSmall {
    if (self.itemState == MenuScrollViewItemStateBig && self.animationState == AnimationStateAnimateStop) {
        
        self.animationState = AnimationStateAnimateStarting;
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
        
        for (int i = 0; i < self.imagesArray.count; i++) {
            [UIView animateWithDuration:AnimationDuration delay:i*Delay usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                UIImageView *imageView =  self.itemImageViewArray[i];
                NSArray *frameArray = self.itemOriginFrameArray[i];
                imageView.frame = CGRectMake([frameArray[0] floatValue], [frameArray[1] floatValue], [frameArray[2] floatValue], [frameArray[3] floatValue]);
                
            } completion:^(BOOL finished) {
                
                self.itemState = MenuScrollViewItemStateSmall;
                self.contentSize = CGSizeMake(KSCreenWidth, self.frame.size.height);
                self.animationState = AnimationStateAnimateStop;
                
            }];
        }
        
    }
}






- (NSMutableArray *)itemOriginFrameArray {
    if (!_itemOriginFrameArray) {
        _itemOriginFrameArray = [[NSMutableArray alloc] init];
    }
    return _itemOriginFrameArray;
}

- (NSMutableArray *)itemAnimteFrameArray {
    if (!_itemAnimteFrameArray) {
        _itemAnimteFrameArray = [[NSMutableArray alloc] init];
    }
    return _itemAnimteFrameArray;
}

- (NSMutableArray *)itemImageViewArray {
    if (!_itemImageViewArray) {
        _itemImageViewArray = [[NSMutableArray alloc] init];
    }
    return _itemImageViewArray;
}


- (void)viewDidAppear {
    self.animationState = AnimationStateAnimateStarting;
    
    for (int i = 0; i < self.imagesArray.count/2; i++) {
        [UIView animateWithDuration:ViewDidAppearAnimationDuration delay:i*Delay usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            UIImageView *imageView1 =  self.itemImageViewArray[self.imagesArray.count/2-1-i];
            UIImageView *imageView2 =  self.itemImageViewArray[self.imagesArray.count/2+i];
            NSArray *frameArray1 = self.itemOriginFrameArray[self.imagesArray.count/2-1-i];
            NSArray *frameArray2 = self.itemOriginFrameArray[self.imagesArray.count/2+i];
            imageView1.frame = CGRectMake([frameArray1[0] floatValue], [frameArray1[1] floatValue], [frameArray1[2] floatValue], [frameArray1[3] floatValue]);
            imageView2.frame = CGRectMake([frameArray2[0] floatValue], [frameArray2[1] floatValue], [frameArray2[2] floatValue], [frameArray2[3] floatValue]);
            
        } completion:^(BOOL finished) {
            self.animationState = AnimationStateAnimateStop;
        }];
    }
    
}

- (void)setAnimationState:(AnimationState)animationState {
    _animationState = animationState;
    if (animationState == AnimationStateAnimateStarting) {
        self.userInteractionEnabled = NO;
    }
    else {
        self.userInteractionEnabled = YES;
    }
}

@end
