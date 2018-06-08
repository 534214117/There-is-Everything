//
//  FloatingTableViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/5/30.
//Copyright © 2018年 Mine. All rights reserved.
//

#import "FloatingTableViewController.h"
#import "FloatingDetailViewController.h"
#import "FloatingWindow.h"
#import "FloatingControlView.h"

@interface FloatingTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *dataTableView;


@end

@implementation FloatingTableViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (GetAppDelegate.detailViewController && [FloatingWindow shareFloatingWindow].hidden) {
        [[FloatingWindow shareFloatingWindow] viewWillAppearOrGestureIntoFloatingControlView];
    }
    
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
    self.title = @"仿微信朋友圈 Floating Window";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupTableView {
    
    self.dataTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, K_StatusBarAndNavigationBarHeight, KSCreenWidth, KSCreenHeight - K_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.view addSubview:self.dataTableView];
    
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
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellId"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row+1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (GetAppDelegate.detailViewController) {
        GetAppDelegate.tempDetailViewController = nil;
        if (GetAppDelegate.detailViewController.tag == (int)indexPath.row) {
            [self.navigationController pushViewController:GetAppDelegate.detailViewController animated:YES];
        }
        else {
            GetAppDelegate.detailViewController = nil;
            GetAppDelegate.detailViewController = [[FloatingDetailViewController alloc] init];
            GetAppDelegate.detailViewController.title = [NSString stringWithFormat:@"%d", (int)indexPath.row+1];
            GetAppDelegate.detailViewController.tag = (int)indexPath.row;
            [self.navigationController pushViewController:GetAppDelegate.detailViewController animated:YES];
        }
        [[FloatingWindow shareFloatingWindow] viewWillDisappearAndGestureIntoFloatingControlView:NO];
    }
    else {
        GetAppDelegate.tempDetailViewController = [[FloatingDetailViewController alloc] init];
        GetAppDelegate.tempDetailViewController.title = [NSString stringWithFormat:@"%d", (int)indexPath.row+1];
        [self.navigationController pushViewController:GetAppDelegate.tempDetailViewController animated:YES];
        [[FloatingWindow shareFloatingWindow] viewWillDisappearAndGestureIntoFloatingControlView:NO];
    }
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
