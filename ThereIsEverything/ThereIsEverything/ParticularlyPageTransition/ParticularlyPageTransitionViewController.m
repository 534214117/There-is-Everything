//
//  ParticularlyPageTransitionViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/25.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "ParticularlyPageTransitionViewController.h"
#import "DetailParticularlyViewController.h"
#import "ParticularlyPresentTransition.h"
#import "ParticularlyDismissTransition.h"

#import "HexagonView.h"
#import "ParticularlyModel.h"

#define CellHeight ((KSCreenHeight-K_StatusBarAndNavigationBarHeight)/self.dataArray.count)
#define CellID @"CellId"

@interface ParticularlyPageTransitionViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) BaseTableView *customTableView;
@property (nonatomic, strong) NSArray<ParticularlyModel *> *dataArray;

@end

@implementation ParticularlyPageTransitionViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
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
    NSArray *cells = [self.customTableView visibleCells];
    for (UIView *cell in cells) {
        cell.alpha = 1;
    }
    
}


#pragma mark - User Interface

- (void)setupNavigationBar {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupTableView {
    
    self.customTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, K_StatusBarAndNavigationBarHeight, KSCreenWidth, KSCreenHeight - K_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    self.customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.customTableView.bounces = NO;
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParticularlyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[ParticularlyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailParticularlyViewController *detailVC = [[DetailParticularlyViewController alloc] init];
    self.selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    detailVC.transitioningDelegate = self;
    [self presentViewController:detailVC animated:YES completion:nil];
    detailVC.model = self.dataArray[indexPath.row];
    
    for (int i = (int)indexPath.row-1; i >= 0; i--) {
        ParticularlyTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
        UIView *snapView = [cell snapshotViewAfterScreenUpdates:YES];
        CGRect frame = [self.view convertRect:cell.frame fromView:self.customTableView];
        snapView.frame = frame;
        snapView.tag = 999+i;
        [self.view addSubview:snapView];
        cell.alpha = 0;
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            snapView.frame = CGRectMake(0, -CellHeight*(self.dataArray.count-2+i), KSCreenWidth, CellHeight);
        } completion:^(BOOL finished) {
            [snapView removeFromSuperview];
        }];
    }
    for (int i = (int)indexPath.row+1; i < self.dataArray.count; i++) {
        ParticularlyTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
        UIView *snapView = [cell snapshotViewAfterScreenUpdates:YES];
        CGRect frame = [self.view convertRect:cell.frame fromView:self.customTableView];
        snapView.frame = frame;
        snapView.tag = 999+i;
        [self.view addSubview:snapView];
        cell.alpha = 0;
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            snapView.frame = CGRectMake(0, KSCreenHeight+CellHeight*(self.dataArray.count-2+i), KSCreenWidth, CellHeight);
        } completion:^(BOOL finished) {
            [snapView removeFromSuperview];
        }];
    }
}


#pragma mark -- UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [ParticularlyPresentTransition new];
}



#pragma mark -- Lazy Load Methods

- (NSArray<ParticularlyModel *> *)dataArray {
    if (!_dataArray) {
        ParticularlyModel *model1 = [[ParticularlyModel alloc] init];
        model1.title = @"Memory";
        model1.subTitle = @"Speaking";
        model1.tip = @"Helps you read faster and comprehend more while processing written information";
        model1.highScore = @"4640";
        model1.difficultyLevel = @"50/200";
        model1.hexColor = @0xfd734a;
        model1.centerImageUrl = @"memory.png";
        
        ParticularlyModel *model2 = [[ParticularlyModel alloc] init];
        model2.title = @"Processing";
        model2.subTitle = @"Reading";
        model2.tip = @"Helps you read faster and comprehend more while processing written information";
        model2.highScore = @"4640";
        model2.difficultyLevel = @"50/200";
        model2.hexColor = @0xfc5c85;
        model2.centerImageUrl = @"processing.png";
        
        ParticularlyModel *model3 = [[ParticularlyModel alloc] init];
        model3.title = @"Brevity";
        model3.subTitle = @"Writing";
        model3.tip = @"Helps you read faster and comprehend more while processing written information";
        model3.highScore = @"4640";
        model3.difficultyLevel = @"50/200";
        model3.hexColor = @0x57bdc4;
        model3.centerImageUrl = @"brevity.png";
        
        _dataArray = @[model1, model2, model3];
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
