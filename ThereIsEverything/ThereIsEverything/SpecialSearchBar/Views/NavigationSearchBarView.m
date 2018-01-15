//
//  NavigationSearchBarView.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/27.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "NavigationSearchBarView.h"
#import "UIView+UIViewMore.h"

#define DefualtFrame CGRectMake(10, (K_NavigationBarHeight-30)/2.f, KSCreenWidth-10-24-20, 30)
#define HideFrame CGRectMake((10+KSCreenWidth-10-24-20)/2.f, ((K_NavigationBarHeight-30)/2.f+30)/2.f, 0, 0)
#define LabelHeight 64
#define Duration 0.3

@interface NavigationSearchBarView () <UISearchBarDelegate, CAAnimationDelegate>

@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, readwrite) NavigationSearchBarState state;
@property (nonatomic, strong) CABasicAnimation *rotationAnimation;
@property (nonatomic, assign) BOOL isSearchAnimating;
@property (nonatomic, strong) NSMutableArray *animationViews;

@end


@implementation NavigationSearchBarView

+ (NavigationSearchBarView *)customInit {
    
    NavigationSearchBarView *view = [[NavigationSearchBarView alloc] initWithFrame:CGRectMake(0, 0, KSCreenWidth, K_NavigationBarHeight)];
    view.layer.zPosition = 1000;

    view.searchButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCreenWidth-10-24, (K_NavigationBarHeight-24)/2.f, 24, 24)];
    [view.searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [view.searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateDisabled];
    [view.searchButton addTarget:view action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:view.searchButton];
    
    view.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCreenWidth-10-24, (K_NavigationBarHeight-24)/2.f, 24, 24)];
    [view.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [view.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateDisabled];
    [view.closeButton addTarget:view action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    view.closeButton.hidden = YES;
    view.closeButton.alpha = 0;
    [view addSubview:view.closeButton];
    
    view.searchBar = [[UISearchBar alloc] initWithFrame:HideFrame];
    view.searchBar.alpha = 0;
    view.searchBar.layer.cornerRadius = 5;
    view.searchBar.layer.masksToBounds = YES;
    view.searchBar.delegate = view;
    [view addSubview:view.searchBar];
    
    view.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCreenWidth, K_NavigationBarHeight)];
    view.titleLabel.textAlignment = NSTextAlignmentCenter;
    view.titleLabel.textColor = [UIColor whiteColor];
    view.titleLabel.font = [UIFont systemFontOfSize:18];
    view.titleLabel.text = @"SpecialSearchBar展示";
    [view addSubview:view.titleLabel];
    
    view.backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, (K_NavigationBarHeight-24)/2.f, 24, 24)];
    [view.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [view.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateDisabled];
    [view.backButton addTarget:view action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view.backButton setHidden:YES];
    [view addSubview:view.backButton];
    
    return view;
    
}

- (void)backButtonHidden:(BOOL)hide {
    self.backButton.hidden = hide;
}

- (void)backButtonAction:(UIButton *)sender {
    [(UINavigationController *)[self getParentViewControllerOfTheView] popViewControllerAnimated:YES];
}

- (void)searchButtonAction:(UIButton *)sender {
    if (self.state == NavigationSearchBarStateQuiet) {
        [self.searchBar becomeFirstResponder];
        [self startAnimation];
        [self.delegate startAnimation];
    }
    else {
        [self.searchBar resignFirstResponder];
        [self closeAnimation];
        [self.delegate closeAnimation];
    }
}

- (void)startAnimation {
    self.state = NavigationSearchBarStateActive;
    self.searchButton.enabled = NO;
    self.closeButton.enabled = NO;
    self.backButton.enabled = NO;
    self.closeButton.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.searchButton.alpha = 0;
        self.backButton.alpha = 0;
        self.closeButton.alpha = 1;
        self.searchBar.alpha = 1;
        self.searchBar.frame = DefualtFrame;
    } completion:^(BOOL finished) {
        self.searchButton.hidden = YES;
        self.searchButton.enabled = YES;
        self.backButton.hidden = YES;
        self.backButton.enabled = YES;
        self.closeButton.enabled = YES;
    }];
}

- (void)closeAnimation {
    self.state = NavigationSearchBarStateQuiet;
    self.searchButton.enabled = NO;
    self.closeButton.enabled = NO;
    self.backButton.enabled = NO;
    self.searchButton.hidden = NO;
    self.backButton.hidden = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.searchButton.alpha = 1;
        self.backButton.alpha = 1;
        self.closeButton.alpha = 0;
        self.searchBar.alpha = 0;
        self.searchBar.frame = HideFrame;
    } completion:^(BOOL finished) {
        self.closeButton.hidden = YES;
        self.searchButton.enabled = YES;
        self.backButton.enabled = YES;
        self.closeButton.enabled = YES;
    }];
    self.titleLabel.text = @"SpecialSearchBar展示";
//    if (self.animationViews.count > 0) {
//        for (int i = 0; i < self.animationViews.count; i++) {
//            NSLog(@"%d %d", self.animationViews.count-i-1, i);
//            [self addCABasicAnimation:self.animationViews[self.animationViews.count-i-1] index:i flag:NO];
//            self.frame = CGRectMake(0, 0, KSCreenWidth, K_NavigationBarHeight);
//        }
//        CGFloat delay = Duration+(Duration-0.1)*(self.animationViews.count-1);
//        [self performSelector:@selector(removeViews) withObject:nil afterDelay:delay];
//    }
    self.frame = CGRectMake(0, 0, KSCreenWidth, K_NavigationBarHeight);
    for (UIView *view in self.animationViews) {
        [view removeFromSuperview];
    }
    [self.animationViews removeAllObjects];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [self superview].layer.transform = CATransform3DMakeRotation(M_PI*7, 1, 0, 0);
//    } completion:^(BOOL finished) {
//    }];
    [self.searchBar resignFirstResponder];
    [self CABasicAnimationBegin];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self CABasicAnimationBegin];
}

- (void)CABasicAnimationBegin {
    self.backgroundColor = RGB(0, 182, 249);
    self.isSearchAnimating = YES;
    [CATransaction begin];
    self.rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    self.rotationAnimation.byValue = [NSNumber numberWithFloat:6*M_PI];
    self.rotationAnimation.duration = 1;
    self.rotationAnimation.removedOnCompletion = YES;
    self.rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.rotationAnimation.delegate = self;
    [self.layer addAnimation:self.rotationAnimation forKey:@"rotationAnimation"];
    [CATransaction commit];
}

- (void)animationDidStart:(CAAnimation *)anim {
    if (self.isSearchAnimating) {
        self.closeButton.enabled = NO;
        self.titleLabel.alpha = 0;
        self.titleLabel.text = self.searchBar.text;
        [UIView animateWithDuration:1 animations:^{
            self.searchBar.alpha = 0;
            self.titleLabel.alpha = 1;
        } completion:^(BOOL finished) {
            self.searchBar.frame = HideFrame;
            self.searchBar.alpha = 1;
            self.searchBar.text = @"";
        }];
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.isSearchAnimating && flag) {
        self.isSearchAnimating = NO;
        self.backgroundColor = [UIColor clearColor];
        NSArray *temp = [self.delegate searchAnimationDone:self.titleLabel.text];
        if (temp && temp.count > 0) {
            NSArray *colors = @[RGB(141, 219, 249), RGB(168, 231, 250), RGB(191, 235, 250)];
            CGFloat originHeight = self.frame.size.height;
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+temp.count*LabelHeight);
            for (int i = 0; i < temp.count; i++) {
                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, originHeight+(i-1)*LabelHeight, self.frame.size.width, LabelHeight*2)];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, LabelHeight, self.frame.size.width, LabelHeight)];
                label.text = temp[i];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:20];
                label.backgroundColor = colors[i];
                bgView.layer.transform = CATransform3DMakeRotation(-radians(90), 1, 0, 0);
                [bgView addSubview:label];
                [self addSubview:bgView];
                if (i == temp.count-1) {
                    [self addCASpringAnimation:bgView index:i flag:YES];
                }
                else {
                    [self addCABasicAnimation:bgView index:i flag:YES];
                }
                [self.animationViews addObject:bgView];
            }
        }
    }
    if ([anim isKindOfClass:[CASpringAnimation class]] && flag) {
        self.closeButton.enabled = YES;
    }
}

- (void)addCABasicAnimation:(UIView *)view index:(int)index flag:(BOOL)flag {
    CGFloat rotate = flag ? radians(90) : -radians(90);
    [CATransaction begin];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.byValue = [NSNumber numberWithFloat:rotate];
    animation.duration = Duration;
    animation.beginTime = CACurrentMediaTime() + Duration*index - 0.1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.repeatCount = 1;
    
    [view.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%@%d", @"rotationAnimation", index]];
    [CATransaction commit];
}

- (void)addCASpringAnimation:(UIView *)view index:(int)index flag:(BOOL)flag {
    CGFloat rotate = flag ? radians(90) : -radians(90);
    [CATransaction begin];
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.byValue = [NSNumber numberWithFloat:rotate];
    animation.duration = 2;
    animation.beginTime = CACurrentMediaTime() + Duration*index - 0.1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.damping = 3;
    animation.repeatCount = 1;
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%@%d", @"rotationAnimation", index]];
    [CATransaction commit];
}

double radians(float degrees) {
    return ( degrees * 3.14159265f ) / 180.0f;
}

- (NSMutableArray *)animationViews {
    if (!_animationViews) {
        _animationViews = [[NSMutableArray alloc] init];
    }
    return _animationViews;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
