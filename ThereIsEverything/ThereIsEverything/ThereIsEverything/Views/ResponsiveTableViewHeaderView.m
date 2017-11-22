//
//  ResponsiveTableViewHeaderView.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/13.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "ResponsiveTableViewHeaderView.h"

#define SelfHeight CGRectGetHeight(self.frame)
#define LimitationHeight -300


@interface ResponsiveTableViewHeaderView ()

@property (nonatomic, strong) UIImageView *responsiveHeaderImageView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic) CGRect originalRect;

@end


@implementation ResponsiveTableViewHeaderView


- (instancetype)initWithImageHeight:(CGFloat)imageHeihgt
{
    self = [super initWithFrame:CGRectMake(0, 0, KSCreenWidth, imageHeihgt)];
    if (self) {
        
        self.responsiveHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCreenWidth, imageHeihgt)];
        self.responsiveHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.responsiveHeaderImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        self.responsiveHeaderImageView.clipsToBounds = YES;
        self.responsiveHeaderImageView.backgroundColor = [UIColor redColor];
        [self addSubview:self.responsiveHeaderImageView];
        
    }
    return self;
}

- (void)setupResponsiveHeaderViewImage:(UIImage *)responsiveHeaderViewImage {
    
    //适配图片
    
    CGSize imageSize = responsiveHeaderViewImage.size;
    CGFloat imageScale = imageSize.width / imageSize.height;
    CGFloat selfScale = KSCreenWidth / SelfHeight;
    
    if (imageScale > selfScale) {
        
        //增宽
        CGFloat realityWidth = imageScale * SelfHeight;
        CGFloat malpositionX = (realityWidth - KSCreenWidth) / 2.0f;
        self.responsiveHeaderImageView.frame = CGRectMake(-malpositionX, 0, realityWidth, SelfHeight);
        
    }
    else {
        
        //高度超出 不适配(也可以根据实际项目需求自行修改)
        
    }
    
    self.originalRect = self.responsiveHeaderImageView.frame;
    
    self.responsiveHeaderImageView.image = responsiveHeaderViewImage;
    
    
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    self.visualEffectView.frame = CGRectMake(0, 0, self.originalRect.size.width, self.originalRect.size.height);
    self.visualEffectView.alpha = 0;
    [self.responsiveHeaderImageView addSubview:self.visualEffectView];
    
}


- (void)didScrollToY:(CGFloat)y {
    
    if (!self.responsiveHeaderImageView.image) {
        return;
    }
    
    //Responsive Key Code
    if (y <= 0 && y > -300) {
        
        //从最顶部继续下拉 图片放大(简单测试了一下，如果不是很无聊的人，单次下拉极限估计也就y=-300。PS：我反正是很无聊的人，经常闲的没事拉微信列表玩)
        CGRect rect = self.responsiveHeaderImageView.frame;
        rect.size.height = SelfHeight - y;
        rect.origin.y = self.originalRect.origin.y + y;
        rect.origin.x = self.originalRect.origin.x;
        rect.size.width = self.originalRect.size.width;
        self.responsiveHeaderImageView.frame = rect;
        
        if (self.isSupportBlurEffect) {
            self.visualEffectView.alpha = -y / (SelfHeight / 2.f);
            self.visualEffectView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        }
        
    }
    if (y <= -300) {
        
        CGRect rect = self.responsiveHeaderImageView.frame;
        rect.origin.y = self.originalRect.origin.y + y;
        self.responsiveHeaderImageView.frame = rect;
        
        if (self.isSupportBlurEffect) {
            self.visualEffectView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        }
        
    }
    if (y >= 0) {

        if (self.isSupportBlurEffect) {
            self.visualEffectView.alpha = 0;
        }
        
    }
    
}


@end
