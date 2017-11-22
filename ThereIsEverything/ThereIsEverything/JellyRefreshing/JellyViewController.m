//
//  JellyViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/21.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "JellyViewController.h"
#import "JellyCustomNavigationBar.h"

#define CellID @"CustomCellID"

@interface JellyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *jellyTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) JellyCustomNavigationBar *customNavigationBar;

@end

@implementation JellyViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupTableView];
    [self setupDataSource];
    [self setupTableViewAttributes];
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
    [self.navigationController.navigationBar setHidden:NO];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}


#pragma mark - User Interface

- (void)setupNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    
    self.customNavigationBar = [[JellyCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, KSCreenWidth, K_StatusBarAndNavigationBarHeight)];
    self.customNavigationBar.backgroundColor = self.jellyTableView.backgroundColor;
    [self.customNavigationBar setTitle:@"Jelly果冻下拉刷新"];
    [self.customNavigationBar showBackButton:YES];
    [self.customNavigationBar.backButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customNavigationBar];
}

- (void)setupTableView {
    
    self.jellyTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, K_StatusBarAndNavigationBarHeight, KSCreenWidth, KSCreenHeight - K_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    self.jellyTableView.delegate = self;
    self.jellyTableView.dataSource = self;
    [self.jellyTableView.panGestureRecognizer addTarget:self action:@selector(handlePanAction:)];
    [self.view addSubview:self.jellyTableView];
    
}

- (void)setupDataSource {
    
    self.dataArray = @[@"略略略😝", @"略略略😝", @"略略略😝"];
    [self.jellyTableView reloadData];
    
}

- (void)setupTableViewAttributes {
    //tableview 条目不能铺满屏幕时 删除多余部分
    self.jellyTableView.tableFooterView = [UIView new];
    self.jellyTableView.tableHeaderView = [UIView new];
}


#pragma mark - Network



#pragma mark - API



#pragma mark - Method

- (void)popAction {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Delegates

#pragma mark -- TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)handlePanAction:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.view];
    [self.customNavigationBar animateStateChangeAtX:point.x y:point.y];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.customNavigationBar animateStateEnd];
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
