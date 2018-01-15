//
//  HexagonView.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/25.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "HexagonView.h"

@interface HexagonView ()

@property (nonatomic, strong) UIImageView *hexagonImageView;

@end



@implementation HexagonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hexagonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame)/4., CGRectGetWidth(frame)/4.)];
        self.hexagonImageView.center = CGPointMake(CGRectGetWidth(frame)/2., CGRectGetHeight(frame)/2.);
        [self addSubview:self.hexagonImageView];
    }
    return self;
}

- (void)setHexagonCenterImage:(UIImage *)hexagonCenterImage {
    _hexagonCenterImage = hexagonCenterImage;
    _hexagonImageView.image = _hexagonCenterImage;
}

- (void)setMaskImage:(UIImage *)maskImage {
    CALayer *mask = [CALayer new];
    mask.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    mask.contents = (__bridge id _Nullable)(maskImage.CGImage);
    self.layer.mask = mask;
}

- (void)setMaskBackgroundColor:(UIColor *)maskBackgroundColor {
    self.layer.backgroundColor = [maskBackgroundColor CGColor];
}

@end
