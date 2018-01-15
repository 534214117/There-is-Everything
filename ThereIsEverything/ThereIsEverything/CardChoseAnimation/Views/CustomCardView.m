//
//  CustomCardView.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/4.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "CustomCardView.h"

@interface CustomCardView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *allCountLabel;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UILabel *middleTitleLabel;
@property (nonatomic, strong) UILabel *middleSubTitleLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIButton *likeButton;

@end

@implementation CustomCardView

- (instancetype)initWithFrame:(CGRect)frame delay:(NSTimeInterval)delay
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+KSCreenHeight, frame.size.width, frame.size.height)];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.backgroundColor = RGB(255, 255, 239).CGColor;
        [self initTopView];
        [self initMiddleView];
        [self initBottomView];
        [self initButton];
        [self showAnimation:delay];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.backgroundColor = RGB(255, 255, 239).CGColor;
        self.alpha = 0;
        [self initTopView];
        [self initMiddleView];
        [self initBottomView];
        [self initButton];
        
        
        
    }
    return self;
}

- (void)showAnimation:(NSTimeInterval)delay {
    [UIView animateWithDuration:2 delay:delay usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-KSCreenHeight, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}



- (void)setModel:(CustomCardModel *)model {
    _model = model;
    
    self.topView.layer.backgroundColor = model.titleColor.CGColor;
    self.topImageView.image = [UIImage imageNamed:model.titleImage];
    self.middleImageView.image = [UIImage imageNamed:model.mainImage];
    self.middleTitleLabel.text = model.title;
    self.middleSubTitleLabel.text = model.subTitle;
    self.dateLabel.text = model.date;
    self.timeLabel.text = model.time;
    self.distanceLabel.text = model.distance;
    self.likeLabel.text = model.likeCount;
    self.indexLabel.text = model.index;
    self.allCountLabel.text = model.allCount;
}


- (void)initTopView {
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
    [self addSubview:self.topView];
    self.topView.layer.cornerRadius = 10;
    
    self.topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 15, 30, 30)];
    [self.topView addSubview:self.topImageView];
    
    
    self.indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, 25, 20)];
    self.indexLabel.font = [UIFont systemFontOfSize:20];
    self.indexLabel.textColor = [UIColor whiteColor];
    self.indexLabel.textAlignment = NSTextAlignmentRight;
    [self.topView addSubview:self.indexLabel];
    
    
    self.allCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 15, 20, 15)];
    self.allCountLabel.font = [UIFont systemFontOfSize:12];
    self.allCountLabel.textColor = [UIColor whiteColor];
    self.allCountLabel.textAlignment = NSTextAlignmentLeft;
    [self.topView addSubview:self.allCountLabel];
    
}

- (void)initMiddleView {
    self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-60)];
    [self addSubview:self.middleImageView];
    self.middleImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 60)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, 10)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height-140)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height-60)];
    [path closePath];
    shape.path = path.CGPath;
    
    self.middleImageView.layer.mask = shape;
    
    self.middleTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height-120-80, self.frame.size.width, 40)];
    self.middleTitleLabel.font = [UIFont systemFontOfSize:32];
    self.middleTitleLabel.textColor = [UIColor whiteColor];
    self.middleTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.middleImageView addSubview:self.middleTitleLabel];
    
    self.middleSubTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height-120-40, self.frame.size.width, 40)];
    self.middleSubTitleLabel.font = [UIFont systemFontOfSize:16];
    self.middleSubTitleLabel.textColor = [UIColor whiteColor];
    self.middleSubTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.middleImageView addSubview:self.middleSubTitleLabel];
    
}

- (void)initBottomView {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-80, self.frame.size.width, 80)];
    [self addSubview:self.bottomView];
    self.bottomView.layer.backgroundColor = RGB(240, 251, 240).CGColor;
    self.bottomView.clipsToBounds = YES;
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(0, 0)];
    [tPath addLineToPoint:CGPointMake(0, 20)];
    [tPath addLineToPoint:CGPointMake(self.frame.size.width, -60)];
    [tPath addLineToPoint:CGPointMake(0, -60)];
    [tPath closePath];
    shape.path = tPath.CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    [self.bottomView.layer addSublayer:shape];
    
    CGSize radio = CGSizeMake(5, 5);//圆角尺寸
    UIRectCorner corner = UIRectCornerBottomLeft|UIRectCornerBottomRight;//这只圆角位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, 80) byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = self.bottomView.bounds;
    masklayer.path = path.CGPath;//设置路径
//    masklayer.fillColor = RGB(237, 254, 238).CGColor;
    self.bottomView.layer.mask = masklayer;
    
    CGFloat itemWidth = self.frame.size.width/4.f;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, itemWidth, 30)];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView1.image = [UIImage imageNamed:@"date"];
    [self.bottomView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(itemWidth, 20, itemWidth, 30)];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.image = [UIImage imageNamed:@"clock"];
    [self.bottomView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(itemWidth*2, 20, itemWidth, 30)];
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    imageView3.image = [UIImage imageNamed:@"poi"];
    [self.bottomView addSubview:imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(itemWidth*3, 20, itemWidth, 30)];
    imageView4.contentMode = UIViewContentModeScaleAspectFit;
    imageView4.image = [UIImage imageNamed:@"like"];
    [self.bottomView addSubview:imageView4];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, itemWidth, 15)];
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:self.dateLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth, 55, itemWidth, 15)];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:self.timeLabel];
    
    self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth*2, 55, itemWidth, 15)];
    self.distanceLabel.textColor = [UIColor blackColor];
    self.distanceLabel.font = [UIFont systemFontOfSize:14];
    self.distanceLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:self.distanceLabel];
    
    self.likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth*3, 55, itemWidth, 15)];
    self.likeLabel.textColor = [UIColor blackColor];
    self.likeLabel.font = [UIFont systemFontOfSize:14];
    self.likeLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:self.likeLabel];
    
}

- (void)initButton {
    self.likeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-40-10, self.frame.size.height-80-5-40, 40, 40)];
    [self addSubview:self.likeButton];
    [self.likeButton setImage:[UIImage imageNamed:@"select_love"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"selected_love"] forState:UIControlStateSelected];
    [self.likeButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)likeAction:(UIButton *)sender {
    
    if (!sender.selected) {
        __block UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected_love"]];
        imageView.frame = CGRectMake(0, 0, 1, 1);
        imageView.center = sender.center;
        [sender.superview addSubview:imageView];
        
        [self balloonAnimation];
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            imageView.frame = sender.frame;
        } completion:^(BOOL finished) {
            sender.selected = !sender.selected;
            [imageView removeFromSuperview];
            imageView = nil;
        }];
    }
    else {
        sender.selected = !sender.selected;
    }
}

- (void)balloonAnimation {
    __block UIImageView *balloonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected_love"]];
    balloonImageView.frame = CGRectMake(0, 0, 30, 30);
    balloonImageView.center = self.likeButton.center;
    [self.likeButton.superview addSubview:balloonImageView];
    
    CGFloat move = 50;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.likeButton.center];
    [path addQuadCurveToPoint:CGPointMake(self.likeButton.center.x, self.likeButton.center.y-move) controlPoint:CGPointMake(self.likeButton.center.x-move, self.likeButton.center.y-move/2.f)];
    [path addQuadCurveToPoint:CGPointMake(self.likeButton.center.x, self.likeButton.center.y-2*move) controlPoint:CGPointMake(self.likeButton.center.x+move, self.likeButton.center.y-move*1.5)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.duration = 1.0f;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [balloonImageView.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:1 animations:^{
        balloonImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [balloonImageView removeFromSuperview];
        balloonImageView = nil;
    }];
}







@end
