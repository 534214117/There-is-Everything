//
//  ThereIsEverythingViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/14.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "ThereIsEverythingViewController.h"
#import "ResponsiveTableViewHeaderView.h"

#import "ImageWaterfallFlowViewController.h"
#import "JellyViewController.h"
#import "FlowMenuAnimationViewController.h"
#import "SpecialSearchBarViewController.h"
#import "CardChoseViewController.h"
#import "VisionDisparityViewController.h"
#import "AnimationSwitchViewController.h"
#import "ParticularlyPageTransitionViewController.h"
#import "StarWarsViewController.h"
#import "ShowDownloadAnimationViewController.h"
#import "LayoutTransformViewController.h"



#define CellID @"CustomCellID"



@interface ThereIsEverythingViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *everythingTableView;

@property (nonatomic, strong) NSArray *classify;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) ResponsiveTableViewHeaderView *headerView;

@end

@implementation ThereIsEverythingViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupDataSource];
    [self setupTableViewAttributes];
    
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
    self.title = @"There is everything";
}

- (void)setupTableView {
    
    self.everythingTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, K_StatusBarAndNavigationBarHeight, KSCreenWidth, KSCreenHeight - K_StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
    self.everythingTableView.delegate = self;
    self.everythingTableView.dataSource = self;
    [self.view addSubview:self.everythingTableView];
    
}

- (void)setupDataSource {
    
    self.dataArray = @[@"Presentation转场动画", @"NavigationPush转场动画", @"Jelly果冻下拉刷新", @"滚珠菜单Animation", @"SpecialSearchBar展示", @"CardChooseAnimation", @"Vision Disparity视觉差滚动视图", @"AnimationSwitch动效开关", @"Particularly Page Transition Example", @"仿StarWars.iOS特效", @"Download Animation Custom View", @"UITableView Transfrom To UICollectionView"];
    [self.everythingTableView reloadData];
    
}

- (void)setupTableViewAttributes {
    //tableview 条目不能铺满屏幕时 删除多余部分
    self.everythingTableView.tableFooterView = [UIView new];
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    self.headerView = [[ResponsiveTableViewHeaderView alloc] initWithImageHeight:200];
    [self.headerView setIsSupportBlurEffect:YES];
    [self.headerView setupResponsiveHeaderViewImage:[UIImage imageNamed:@"BigWidth.jpg"]];
    
    return self.headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
    transform = CATransform3DTranslate(transform, -200, 0, 0);//左边水平移动
    transform = CATransform3DScale(transform, 0, 0, 0);//由小变大
    cell.layer.transform = transform;
    cell.layer.opacity = 0.0;
    [UIView animateWithDuration:0.6 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.layer.opacity = 1;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ImageWaterfallFlowViewController *vc = [[ImageWaterfallFlowViewController alloc] init];
        vc.present = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        ImageWaterfallFlowViewController *vc = [[ImageWaterfallFlowViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        JellyViewController *vc = [[JellyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 3) {
        FlowMenuAnimationViewController *vc = [[FlowMenuAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        SpecialSearchBarViewController *vc = [[SpecialSearchBarViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 5) {
        CardChoseViewController *vc = [[CardChoseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 6) {
        VisionDisparityViewController *vc = [[VisionDisparityViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 7) {
        AnimationSwitchViewController *vc = [[AnimationSwitchViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 8) {
        ParticularlyPageTransitionViewController *vc = [[ParticularlyPageTransitionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 9) {
        StarWarsViewController *vc = [[StarWarsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 10) {
        ShowDownloadAnimationViewController *vc = [[ShowDownloadAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 11) {
        LayoutTransformViewController *vc = [[LayoutTransformViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark -- ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //    NSLog(@"%f", scrollView.contentOffset.y);
    [self.headerView didScrollToY:scrollView.contentOffset.y];
    
}



#pragma mark -- Lazy Load Methods



#pragma mark -- Super Method OverRide

- (BOOL)prefersStatusBarHidden {
    return NO;
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
