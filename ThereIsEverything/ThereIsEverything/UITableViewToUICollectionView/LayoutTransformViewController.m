//
//  LayoutTransformViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/11.
//Copyright © 2018年 Mine. All rights reserved.
//

#import "LayoutTransformViewController.h"

@interface LayoutTransformViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) BaseTableView *customTableView;
@property (nonatomic, strong) BaseCollectionView *customCollectionView;

@end

@implementation LayoutTransformViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupCollectionView];
    
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
//    self.navigationController.navigationBar.barTintColor = HEXColor(0x191f22);
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"Friends";
}

- (void)setupTableView {
    
}

- (void)setupCollectionView {
    
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
