//
//  DetailParticularlyViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/28.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "DetailParticularlyViewController.h"
#import "HexagonView.h"
#import "ParticularlyDismissTransition.h"


#define CellHeight ((KSCreenHeight-K_StatusBarAndNavigationBarHeight)/3.)
#define ItemY CellHeight/4.
#define MarginTop (((KSCreenHeight-K_StatusBarAndNavigationBarHeight)/3.)/4.)
#define DefaultTransform CGAffineTransformIdentity
#define BiggerTransform CGAffineTransformMakeScale(2, 2)


@interface DetailParticularlyViewController () <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *subLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *buttonLabel;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) HexagonView *hexagonView;

@end

@implementation DetailParticularlyViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupBackgroundImageView];
    [self setupCellDataView];
    [self setupDismissButton];
    [self setupScoreLabel];
    [self setupBottomView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self bottomViewDefaultTransform];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self setupText];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}


#pragma mark - User Interface

- (void)setupDismissButton {
    UIButton *dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(20, K_StatusBarHeight + 10, 44, 44)];
    [dismissButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [dismissButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [dismissButton addTarget:self action:@selector(dissmissAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
}

- (void)setupBackgroundImageView {
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detailParticularlyBG.jpg"]];
    self.bgImageView.frame = CGRectMake(0, 0, KSCreenWidth, KSCreenHeight);
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.bgImageView];
}

- (void)setupCellDataView {
    self.view.backgroundColor = [UIColor clearColor];
    
    self.cellDataView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCreenHeight-CellHeight*1.5, KSCreenWidth, CellHeight)];
//    self.cellDataView.hidden = YES;
//    self.cellDataView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.cellDataView];
    
    self.hexagonView = [[HexagonView alloc] initWithFrame:CGRectMake(20, MarginTop/2., CellHeight-MarginTop, CellHeight-MarginTop)];
    self.hexagonView.maskImage = [UIImage imageNamed:@"hexagon1.png"];
    [self.cellDataView addSubview:self.hexagonView];
    
    self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hexagonView.frame)+20, ItemY, KSCreenWidth-(CGRectGetMaxX(self.hexagonView.frame)+40), ItemY)];
    //        self.mainLabel.backgroundColor = [UIColor redColor];
    self.mainLabel.textColor = [UIColor whiteColor];
    self.mainLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightThin];
    [self.cellDataView addSubview:self.mainLabel];
    
    self.subLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hexagonView.frame)+20, ItemY*2, KSCreenWidth-(CGRectGetMaxX(self.hexagonView.frame)+40), ItemY)];
    self.subLabel.font = [UIFont systemFontOfSize:16];
    self.subLabel.textColor = HEXColor(0xaeadb5);
    [self.cellDataView addSubview:self.subLabel];
}

- (void)setupBottomView {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCreenHeight-CellHeight*0.8, KSCreenWidth, CellHeight*0.8)];
    self.bottomView.transform = BiggerTransform;
    self.bottomView.alpha = 0;
    [self.bgImageView addSubview:self.bottomView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, KSCreenWidth-40, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.bottomView addSubview:lineView];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(20, CellHeight*0.8*.5, KSCreenWidth-40, (CellHeight*0.8)*.5-20)];
    self.buttonView.layer.borderColor = HEXColor(0x175b93).CGColor;
    self.buttonView.layer.borderWidth = 1;
    self.buttonView.layer.cornerRadius = 3;
    [self.bottomView addSubview:self.buttonView];
    
    self.buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.buttonView.frame), CGRectGetHeight(self.buttonView.frame))];
    self.buttonLabel.textColor = [UIColor whiteColor];
    self.buttonLabel.font = [UIFont systemFontOfSize:20];
    self.buttonLabel.textAlignment = NSTextAlignmentCenter;
    [self.buttonView addSubview:self.buttonLabel];
    
    self.centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView.frame), KSCreenWidth-40, CGRectGetMinY(self.buttonView.frame)-CGRectGetMaxY(lineView.frame))];
    self.centerLabel.textAlignment = NSTextAlignmentLeft;
    self.centerLabel.numberOfLines = 2;
    self.centerLabel.textColor = [UIColor whiteColor];
    self.centerLabel.font = [UIFont systemFontOfSize:16];
    [self.bottomView addSubview:self.centerLabel];
}

- (void)setupScoreLabel {
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, K_StatusBarHeight+20, KSCreenWidth-40, 24)];
    self.scoreLabel.textColor = [UIColor whiteColor];
    self.scoreLabel.font = [UIFont systemFontOfSize:12];
    self.scoreLabel.textAlignment = NSTextAlignmentRight;
    [self.bgImageView addSubview:self.scoreLabel];
    
    self.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.scoreLabel.frame), KSCreenWidth-40, 24)];
    self.levelLabel.textColor = [UIColor whiteColor];
    self.levelLabel.font = [UIFont systemFontOfSize:12];
    self.levelLabel.textAlignment = NSTextAlignmentRight;
    [self.bgImageView addSubview:self.levelLabel];
}



#pragma mark - Network



#pragma mark - API

- (void)setMainViewY:(CGFloat)y {
    self.cellDataView.frame = CGRectMake(0, y, KSCreenWidth, CellHeight);
}



#pragma mark - Method

- (void)dissmissAction:(UIButton *)sender {
    self.transitioningDelegate = self;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)bottomViewDefaultTransform {
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bottomView.transform = DefaultTransform;
        self.bottomView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setupText {
    
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.buttonView.frame), CGRectGetWidth(self.buttonView.frame), 0)];
    loadingView.backgroundColor = HEXColor(0x175b93);
    [self.buttonView insertSubview:loadingView atIndex:0];
    
    [UIView animateWithDuration:6 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        loadingView.frame = CGRectMake(0, 0, CGRectGetWidth(self.buttonView.frame), CGRectGetHeight(self.buttonView.frame));
    } completion:^(BOOL finished) {
        
    }];
    
    
    self.buttonLabel.text = @"DownLoading game...";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.buttonLabel.text = @"Loading...";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.buttonView.layer.backgroundColor = HEXColor(0x175b93).CGColor;
            self.buttonLabel.text = @"Play";
            [loadingView removeFromSuperview];
        });
    });
}

#pragma mark - Delegates

#pragma mark -- UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ParticularlyDismissTransition new];
}


#pragma mark -- Lazy Load Methods



#pragma mark -- Super Method OverRide

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)setModel:(ParticularlyModel *)model {
    _model = model;
    self.hexagonView.maskBackgroundColor = HEXColor([model.hexColor intValue]);
    self.hexagonView.hexagonCenterImage = [UIImage imageNamed:model.centerImageUrl];
    self.mainLabel.text = model.title;
    self.subLabel.text = model.subTitle;
    self.scoreLabel.text = [NSString stringWithFormat:@"HIGH SCORE:%@", self.model.highScore];
    self.levelLabel.text = [NSString stringWithFormat:@"DIFFICULTY LEVEL:%@", self.model.difficultyLevel];
    self.centerLabel.text = model.tip;
    //    [UILabel changeWordSpaceForLabel:self.mainLabel WithSpace:3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
