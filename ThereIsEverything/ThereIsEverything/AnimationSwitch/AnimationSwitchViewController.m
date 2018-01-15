//
//  AnimationSwitchViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/21.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "AnimationSwitchViewController.h"

#import "CustomTableViewCell.h"

#define CellID @"CustomCellID"

@interface AnimationSwitchViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *customTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AnimationSwitchViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupTableView];
    
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

- (void)setupTableView {
    
    self.customTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, K_StatusBarAndNavigationBarHeight, KSCreenWidth, KSCreenHeight - K_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    self.customTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.customTableView];
    
}



#pragma mark - Network



#pragma mark - API



#pragma mark - Method



#pragma mark - Delegates


#pragma mark -- TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (KSCreenHeight-K_StatusBarAndNavigationBarHeight)/2.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        cell.animationSwitch.onTintColor = RGB(138, 181, 68);
    }
    else {
        cell.animationSwitch.onTintColor = RGB(36, 173, 251);
    }
    
    return cell;
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
