//
//  IntelligentIdentificationViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/13.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "VisionDisparityViewController.h"

#import "VisionDisparityTableViewCell.h"

#define CellHeight 200
#define CellID @"CustomCellID"


@interface VisionDisparityViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *visionDisparityTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation VisionDisparityViewController

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
    
    self.visionDisparityTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, K_StatusBarAndNavigationBarHeight, KSCreenWidth, KSCreenHeight - K_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    self.visionDisparityTableView.delegate = self;
    self.visionDisparityTableView.dataSource = self;
    [self.view addSubview:self.visionDisparityTableView];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VisionDisparityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[VisionDisparityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backImage = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 1.获取当前屏幕上显示的所有的cell
    NSArray *visibleCells = [self.visionDisparityTableView visibleCells];
    for (VisionDisparityTableViewCell *cell in visibleCells) {
        // 2.更新cell的imageView的Y坐标值
        [cell updateBackImageViewYForTableView:self.visionDisparityTableView andView:self.view];
    }
}


#pragma mark -- Lazy Load Methods

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 24; i++) {
            [_dataArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpeg", i+1]]];
        }
    }
    return _dataArray;
}


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
