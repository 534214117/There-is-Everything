//
//  ShowDownloadAnimationViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/10.
//Copyright © 2018年 Mine. All rights reserved.
//

#import "ShowDownloadAnimationViewController.h"
#import "DownloadAnimationView.h"

@interface ShowDownloadAnimationViewController ()

@property (nonatomic, strong) DownloadAnimationView *downloadAnimationView;

@end

@implementation ShowDownloadAnimationViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupDownloadAnimationView];
    
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

- (void)setupNavigationBar {
    self.view.backgroundColor = HEXColor(0x299eef);
}

- (void)setupDownloadAnimationView {
    self.downloadAnimationView = [[DownloadAnimationView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:self.downloadAnimationView];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
