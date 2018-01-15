//
//  StarWarsProfleViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/9.
//Copyright © 2018年 Mine. All rights reserved.
//

#import "StarWarsProfleViewController.h"

#import "StarWarsTransitionDismissing.h"

@interface StarWarsProfleViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation StarWarsProfleViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTopView];
    [self setupBottomView];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}


#pragma mark - User Interface

- (void)setupTopView {
//    self.view.backgroundColor = [UIColor clearColor];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCreenWidth, (497/375.f)*KSCreenWidth)];
    [self.view addSubview:self.topView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.topView.bounds];
    imageView.image = [UIImage imageNamed:@"Photo_light"];
    [self.topView addSubview:imageView];
    
    UIButton *dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCreenWidth-10-40, K_StatusBarHeight, 40, 40)];
    [dismissButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [dismissButton setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    [dismissButton addTarget:self action:@selector(viewControllerDismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:dismissButton];
}

- (void)setupBottomView {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.topView.frame)/2.f + 300, KSCreenWidth, (497/375.f)*KSCreenWidth)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
}



#pragma mark - Network



#pragma mark - API

- (void)startAnimate {
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bottomView.frame = CGRectMake(0, CGRectGetHeight(self.topView.frame)/2.f, KSCreenWidth, (497/375.f)*KSCreenWidth);
    } completion:^(BOOL finished) {
        
    }];
}



#pragma mark - Method

- (void)viewControllerDismiss {
    self.transitioningDelegate = self;
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Delegates

#pragma mark -- UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [StarWarsTransitionDismissing new];
}




#pragma mark -- Lazy Load Methods



#pragma mark -- Super Method OverRide

- (BOOL)prefersStatusBarHidden {
    return YES;
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
