//
//  FlowMenuTableViewCell.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/22.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "FlowMenuTableViewCell.h"
#import "AnimationButton.h"
#import "UIBezierPath+AnimationPathway.h"

#define BigHeight FlowMenuCellHeight/4
#define ItemWidth KSCreenWidth/4
#define TitleFont [UIFont boldSystemFontOfSize:36]
#define SubTitleFontSize 14
#define Margin 10
#define AnimationScale 0.4
#define AnimationX KSCreenWidth*AnimationScale
#define KVO_ControlPoint @"controlPoint"
#define BGMenuViewExchange 10


@interface FlowMenuTableViewCell () <UICollisionBehaviorDelegate>

@property (nonatomic, strong) FlowMenuModel *model;

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UILabel *followersCountLabel;
@property (nonatomic, strong) UILabel *favoritesCountLabel;
@property (nonatomic, strong) UILabel *viewsCountLabel;
@property (nonatomic, strong) UILabel *followersTitleLabel;
@property (nonatomic, strong) UILabel *favoritesTitleLabel;
@property (nonatomic, strong) UILabel *viewsTitleLabel;
@property (nonatomic, strong) UIView *bgMenuView;
@property (nonatomic, strong) CAShapeLayer *menuButtonLayer;
@property (nonatomic, assign) CGPoint controlPoint;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat positionX;

@property (nonatomic, strong) CAShapeLayer *AnimationPathLayer;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIDynamicItemBehavior *itemBehavior;
@property (strong, nonatomic) UIGravityBehavior *gravity;

@property (strong, nonatomic) NSArray <AnimationButton *> *items;
@property (strong, nonatomic) UIBezierPath *animationBezier;

@property (nonatomic, assign) BOOL closing;


@end



@implementation FlowMenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.clipsToBounds = YES;
        
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, BigHeight, KSCreenWidth, BigHeight)];
        self.mainView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.mainView];
        
        self.subView = [[UIView alloc] initWithFrame:CGRectMake(0, BigHeight*2, KSCreenWidth, BigHeight)];
        self.subView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.subView];
        
        self.titleImageView = [[UIImageView alloc] init];
        self.titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.mainView addSubview:self.titleImageView];
        
        self.mainTitleLabel = [[UILabel alloc] init];
        self.mainTitleLabel.textColor = [UIColor whiteColor];
        self.mainTitleLabel.font = TitleFont;
        self.mainTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.mainView addSubview:self.mainTitleLabel];
        
        CGFloat lineOneMinY = 0;
        CGFloat lineTwoMinY = BigHeight*0.5;
        CGFloat itemWidth = ItemWidth;
        CGFloat itemHeight = BigHeight/2;
        
        self.followersCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(ItemWidth*0.5, lineOneMinY, itemWidth, itemHeight)];
        self.followersCountLabel.textColor = [UIColor whiteColor];
        self.followersCountLabel.font = [UIFont boldSystemFontOfSize:SubTitleFontSize];
        self.followersCountLabel.textAlignment = NSTextAlignmentCenter;
        [self.subView addSubview:self.followersCountLabel];
        
        self.favoritesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(ItemWidth*1.5, lineOneMinY, itemWidth, itemHeight)];
        self.favoritesCountLabel.textColor = [UIColor whiteColor];
        self.favoritesCountLabel.font = [UIFont boldSystemFontOfSize:SubTitleFontSize];
        self.favoritesCountLabel.textAlignment = NSTextAlignmentCenter;
        [self.subView addSubview:self.favoritesCountLabel];
        
        self.viewsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(ItemWidth*2.5, lineOneMinY, itemWidth, itemHeight)];
        self.viewsCountLabel.textColor = [UIColor whiteColor];
        self.viewsCountLabel.font = [UIFont boldSystemFontOfSize:SubTitleFontSize];
        self.viewsCountLabel.textAlignment = NSTextAlignmentCenter;
        [self.subView addSubview:self.viewsCountLabel];
        
        self.followersTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ItemWidth*0.5, lineTwoMinY, itemWidth, itemHeight)];
        self.followersTitleLabel.textColor = [UIColor whiteColor];
        self.followersTitleLabel.font = [UIFont systemFontOfSize:SubTitleFontSize];
        self.followersTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.followersTitleLabel.text = @"FOLLOWERS";
        [self.subView addSubview:self.followersTitleLabel];
        
        self.favoritesTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ItemWidth*1.5, lineTwoMinY, itemWidth, itemHeight)];
        self.favoritesTitleLabel.textColor = [UIColor whiteColor];
        self.favoritesTitleLabel.font = [UIFont systemFontOfSize:SubTitleFontSize];
        self.favoritesTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.favoritesTitleLabel.text = @"FAVORITES";
        [self.subView addSubview:self.favoritesTitleLabel];
        
        self.viewsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ItemWidth*2.5, lineTwoMinY, itemWidth, itemHeight)];
        self.viewsTitleLabel.textColor = [UIColor whiteColor];
        self.viewsTitleLabel.font = [UIFont systemFontOfSize:SubTitleFontSize];
        self.viewsTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.viewsTitleLabel.text = @"VIEWS";
        [self.subView addSubview:self.viewsTitleLabel];
        
        self.bgMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BigHeight*3, BigHeight*3)];
        self.bgMenuView.layer.cornerRadius = BigHeight*3/2;
        self.bgMenuView.center = CGPointMake(KSCreenWidth, 0);
        [self addSubview:self.bgMenuView];
        
        CGFloat menuButtonWH = BigHeight/2-5;
        self.menuButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCreenWidth-(BigHeight+menuButtonWH)/2, (BigHeight-menuButtonWH)/2, menuButtonWH, menuButtonWH)];
        [self addSubview:self.menuButton];
        
        self.controlPoint = CGPointMake(CGRectGetWidth(self.menuButton.frame)/2.f, (CGRectGetHeight(self.menuButton.frame)/4.f)*3);
//        [self addObserver:self forKeyPath:KVO_ControlPoint options:NSKeyValueObservingOptionNew context:nil];
        
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        [bezier moveToPoint:CGPointMake(0, CGRectGetHeight(self.menuButton.frame)/4)];
        [bezier addLineToPoint:self.controlPoint];
        [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.menuButton.frame), CGRectGetHeight(self.menuButton.frame)/4.f)];
        self.menuButtonLayer = [CAShapeLayer layer];
        self.menuButtonLayer.fillColor = [UIColor clearColor].CGColor;
        self.menuButtonLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.menuButtonLayer.borderWidth = 2;
        self.menuButtonLayer.path = bezier.CGPath;
        [self.menuButton.layer addSublayer:self.menuButtonLayer];
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        self.displayLink.paused = YES;
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        
        
        
        
    }
    return self;
}

- (void)initDynamicViews {
    
    for (AnimationButton *view in self.items) {
        [view removeFromSuperview];
    }
    
    CGFloat tempMove = 20;
    self.animationBezier = [UIBezierPath startAtPoint:CGPointMake(ItemWidth*0.5, -tempMove)];
    
    AnimationButton *animationView1 = [[AnimationButton alloc] initWithFrame:CGRectMake(0, -tempMove-60, 60, 60)];
    animationView1.layer.cornerRadius = 30;
    [animationView1 setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    animationView1.clipsToBounds = YES;
    [self addSubview:animationView1];
    
    AnimationButton *animationView2 = [[AnimationButton alloc] initWithFrame:CGRectMake(-80, -tempMove-60, 60, 60)];
    animationView2.layer.cornerRadius = 30;
    [animationView2 setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    animationView2.clipsToBounds = YES;
    [self addSubview:animationView2];
    
    AnimationButton *animationView3 = [[AnimationButton alloc] initWithFrame:CGRectMake(-160, -tempMove-60, 60, 60)];
    animationView3.layer.cornerRadius = 30;
    [animationView3 setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    animationView3.clipsToBounds = YES;
    [self addSubview:animationView3];
    
    self.items = @[animationView1, animationView2, animationView3];
    
    [self initDynamicAnimator];
    
}

- (void)initDynamicAnimator {
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    self.gravity = [[UIGravityBehavior alloc] initWithItems:self.items];
    self.gravity.gravityDirection = CGVectorMake(0, 1.5);
    [self.animator addBehavior:self.gravity];
    
    UIPushBehavior *pushRight = [[UIPushBehavior alloc] initWithItems:@[self.items[0]] mode:UIPushBehaviorModeInstantaneous];
    [pushRight setPushDirection:CGVectorMake(1, 0)];
    [pushRight setMagnitude:3.f];
    [_animator addBehavior:pushRight];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.items];
    collision.collisionDelegate = self;
    [collision addBoundaryWithIdentifier:@"path" forPath:self.animationBezier];
    [self.animator addBehavior:collision];
    
    self.itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.items];
    self.itemBehavior.resistance = 0;
    self.itemBehavior.allowsRotation = YES;
    self.itemBehavior.angularResistance = 5.0;
    self.itemBehavior.friction = 8;
    [_animator addBehavior:self.itemBehavior];
    
    if (self.items.count > 1) {
        for (int i = 0; i < self.items.count-1; i++) {
            [self addAttachmentBehaviorWithItem1:self.items[i] andItem2:self.items[i+1] length:CGRectGetWidth(self.items[i].frame)+20];
        }
    }
    
}

- (void)addAttachmentBehaviorWithItem1:(UIView *)item1 andItem2:(UIView *)item2 length:(CGFloat)length {
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:item1 attachedToItem:item2];
    attachment.length = length;
    attachment.frequency = 8;
    [self.animator addBehavior:attachment];
}


- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p {
    if (p.x > 250 && item == self.items[0] && !self.closing) {
        self.gravity.gravityDirection = CGVectorMake(-0.5, 2);
    }
}

- (void)deallocDynamicAnimator {
    self.gravity.gravityDirection = CGVectorMake(-10, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.displayLink.paused = NO;
        self.menuButton.enabled = NO;
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = self.subView.frame;
            frame.origin.x += AnimationX;
            self.subView.frame = frame;
            CGPoint center = self.bgMenuView.center;
            self.bgMenuView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bgMenuView.frame)+BGMenuViewExchange, CGRectGetWidth(self.bgMenuView.frame)+BGMenuViewExchange);
            self.bgMenuView.center = center;
        } completion:^(BOOL finished) {
            self.displayLink.paused = YES;
        }];
        
        [UIView animateWithDuration:1 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = self.mainView.frame;
            frame.origin.x += AnimationX;
            self.mainView.frame = frame;
        } completion:^(BOOL finished) {
            self.menuButton.enabled = YES;
            self.closing = NO;
        }];
    });
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:KVO_ControlPoint]) {
//        [self updateShapeLayerPath];
//    }
//}

- (void)displayLinkAction:(CADisplayLink *)displayLink {
    CALayer *layer = self.subView.layer.presentationLayer;
    CGFloat scale = (self.positionX-layer.position.x)/AnimationX/(AnimationScale*AnimationScale);
    CGFloat move = (CGRectGetHeight(self.menuButton.frame)/2.f)*scale;
    self.controlPoint = CGPointMake(CGRectGetWidth(self.menuButton.frame)/2.f, (CGRectGetHeight(self.menuButton.frame)/4.f)*3-move);
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, CGRectGetHeight(self.menuButton.frame)/4+move)];
    [bezier addLineToPoint:self.controlPoint];
    [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.menuButton.frame), CGRectGetHeight(self.menuButton.frame)/4.f+move)];
    
    [self.menuButtonLayer removeFromSuperlayer];
    self.menuButtonLayer = [CAShapeLayer layer];
    self.menuButtonLayer.fillColor = [UIColor clearColor].CGColor;
    self.menuButtonLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.menuButtonLayer.path = bezier.CGPath;
    [self.menuButton.layer addSublayer:self.menuButtonLayer];
    
    UIBezierPath *animationBezier = [UIBezierPath bezierPath];
    [animationBezier moveToPoint:CGPointMake(CGRectGetMinX(self.followersTitleLabel.frame), 0)];
    [animationBezier addQuadCurveToPoint:CGPointMake(CGRectGetMidX(self.favoritesTitleLabel.frame), CGRectGetMaxY(self.mainView.frame)*scale) controlPoint:CGPointMake(CGRectGetMinX(self.favoritesTitleLabel.frame), BigHeight*0.25*scale)];
    [animationBezier addQuadCurveToPoint:CGPointMake(KSCreenWidth, BigHeight*2.75*scale) controlPoint:CGPointMake(CGRectGetMinX(self.viewsTitleLabel.frame), FlowMenuCellHeight*scale)];
    [animationBezier addLineToPoint:CGPointMake(KSCreenWidth*1.5, 0)];
    
    [self.AnimationPathLayer removeFromSuperlayer];
    self.AnimationPathLayer = [CAShapeLayer layer];
    self.AnimationPathLayer.fillColor = self.model.menuColor.CGColor;
    self.AnimationPathLayer.path = animationBezier.CGPath;
    [self.layer insertSublayer:self.AnimationPathLayer atIndex:1];
}



- (void)resetModel:(FlowMenuModel *)model {
    
    self.model = model;
    
    self.backgroundColor = model.bgColor;
    self.bgMenuView.layer.backgroundColor = model.menuButtonColor.CGColor;
    self.followersCountLabel.text = model.followersCount;
    self.favoritesCountLabel.text = model.favoritesCount;
    self.viewsCountLabel.text = model.viewsCount;
    self.mainTitleLabel.text = model.title;
    self.titleImageView.image = [UIImage imageNamed:model.imageUrl];
    
    CGSize size = [model.title boundingRectWithSize:CGSizeMake(KSCreenWidth-80, BigHeight) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: TitleFont} context:nil].size;
    CGFloat imageHeight = size.height/3*2;
    self.mainTitleLabel.frame = CGRectMake((Margin+imageHeight)/2.f+(KSCreenWidth-size.width)/2.f, 0, size.width, BigHeight);
    self.titleImageView.frame = CGRectMake(CGRectGetMinX(self.mainTitleLabel.frame)-10-imageHeight, (BigHeight-imageHeight)/2.f, imageHeight, imageHeight);
    
    
}

- (void)openMainViewAnimate {
    [self initDynamicViews];
    
    self.positionX = self.subView.layer.presentationLayer.position.x;
    self.displayLink.paused = NO;
    self.menuButton.enabled = NO;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.subView.frame;
        frame.origin.x -= AnimationX;
        self.subView.frame = frame;
        CGPoint center = self.bgMenuView.center;
        self.bgMenuView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bgMenuView.frame)-BGMenuViewExchange, CGRectGetWidth(self.bgMenuView.frame)-BGMenuViewExchange);
        self.bgMenuView.center = center;
    } completion:^(BOOL finished) {
        self.displayLink.paused = YES;
    }];
    
    [UIView animateWithDuration:1 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.mainView.frame;
        frame.origin.x -= AnimationX;
        self.mainView.frame = frame;
    } completion:^(BOOL finished) {
        self.menuButton.enabled = YES;
        //
    }];
}

- (void)closeMainViewAnimate {
    self.closing = YES;
    [self deallocDynamicAnimator];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
