//
//  SpecialSearchBarViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/27.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "SpecialSearchBarViewController.h"


#import "NavigationSearchBarView.h"

@interface SpecialSearchBarViewController () <NavigationSearchBarDelegate>

@property (nonatomic, strong) NavigationSearchBarView *navigationSearchBarView;

@end

@implementation SpecialSearchBarViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self resetNavigationBar];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}


#pragma mark - User Interface

- (void)setupNavigationBar {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = RGB(0, 182, 249);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    
    
    self.navigationSearchBarView = [NavigationSearchBarView customInit];
    self.navigationSearchBarView.delegate = self;
    [self.navigationSearchBarView backButtonHidden:NO];
    [self.navigationController.navigationBar addSubview:self.navigationSearchBarView];
}

- (void)resetNavigationBar {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.hidesBackButton = NO;
    [self.navigationSearchBarView removeFromSuperview];
    self.navigationSearchBarView = nil;
}



#pragma mark - Network



#pragma mark - API



#pragma mark - Method



#pragma mark - Delegates

#pragma mark -- NavigationSearchBarDelegate

- (void)startAnimation {
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarContentView"]) {
            [UIView animateWithDuration:0.5 animations:^{
                view.alpha = 0;
            } completion:^(BOOL finished) {
            }];
            break;
        }
    }
    
}



- (void)closeAnimation {
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarContentView"]) {
            [UIView animateWithDuration:0.5 animations:^{
                view.alpha = 1;
            }];
            break;
        }
    }
}

- (NSArray *)searchAnimationDone:(NSString *)searchString {
    NSMutableArray *result = [NSMutableArray new];
    NSArray *temp = @[@"Murphy", @"Lobanovskiy", @"Jones"];
    for (int i = 0; i < temp.count; i++) {
        NSString *addString = [NSString stringWithFormat:@"%@ %@", searchString, temp[i]];
        [result addObject:addString];
    }
    return result;
}


#pragma mark -- Lazy Load Methods



#pragma mark -- Super Method OverRide


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
