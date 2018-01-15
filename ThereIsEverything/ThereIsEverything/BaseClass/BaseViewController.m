//
//  BaseViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/14.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "BaseViewController.h"
#import "NSObject+Swizzling.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupIOS11];
    
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

- (void)setupIOS11 {
    if (@available(iOS 11.0, *)) {
        self.view.insetsLayoutMarginsFromSafeArea = YES;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}



#pragma mark - Network



#pragma mark - API



#pragma mark - Method



#pragma mark - Delegates



#pragma mark -- Lazy Load Methods



#pragma mark -- Super Method OverRide


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%@ Dealloc", NSStringFromClass([self class]));
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
