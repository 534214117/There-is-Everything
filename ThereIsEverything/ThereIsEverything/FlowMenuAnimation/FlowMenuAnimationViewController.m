//
//  FlowMenuAnimationViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/22.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "FlowMenuAnimationViewController.h"

#import "FlowMenuModel.h"
#import "FlowMenuTableViewCell.h"

#define CellID @"CustomCellID"

@interface FlowMenuAnimationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *flowMenuTableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FlowMenuAnimationViewController

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
    [self.navigationController.navigationBar setTintColor:RGB(58, 84, 114)];
}

- (void)setupTableView {
    
    self.flowMenuTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, K_StatusBarAndNavigationBarHeight, KSCreenWidth, KSCreenHeight - K_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
    self.flowMenuTableView.delegate = self;
    self.flowMenuTableView.dataSource = self;
    [self.view addSubview:self.flowMenuTableView];
    
}

- (void)setupDataSource {
    
    FlowMenuModel *model1 = [[FlowMenuModel alloc] init];
    model1.bgColor = RGB(243, 79, 117);
    model1.menuButtonColor = RGB(217, 31, 73);
    model1.menuColor = RGB(227, 57, 97);
    model1.imageUrl = @"FlowMenuImage1.png";
    model1.title = @"Night Life";
    model1.followersCount = @"517";
    model1.favoritesCount = @"315";
    model1.viewsCount = @"7815";
    
    FlowMenuModel *model2 = [[FlowMenuModel alloc] init];
    model2.bgColor = RGB(49, 209, 187);
    model2.menuButtonColor = RGB(36, 186, 167);
    model2.menuColor = RGB(128, 196, 178);
    model2.imageUrl = @"FlowMenuImage2.png";
    model2.title = @"Art & Culture";
    model2.followersCount = @"437";
    model2.favoritesCount = @"245";
    model2.viewsCount = @"5432";
    
    FlowMenuModel *model3 = [[FlowMenuModel alloc] init];
    model3.bgColor = RGB(199, 119, 241);
    model3.menuButtonColor = RGB(182, 39, 232);
    model3.menuColor = RGB(175, 127, 235);
    model3.imageUrl = @"FlowMenuImage3.png";
    model3.title = @"Foot Festivals";
    model3.followersCount = @"472";
    model3.favoritesCount = @"214";
    model3.viewsCount = @"2741";
    
    FlowMenuModel *model4 = [[FlowMenuModel alloc] init];
    model4.bgColor = RGB(243, 79, 117);
    model4.menuButtonColor = RGB(217, 31, 73);
    model4.menuColor = RGB(227, 57, 97);
    model4.imageUrl = @"FlowMenuImage1.png";
    model4.title = @"Night Life";
    model4.followersCount = @"517";
    model4.favoritesCount = @"315";
    model4.viewsCount = @"7815";
    
    FlowMenuModel *model5 = [[FlowMenuModel alloc] init];
    model5.bgColor = RGB(49, 209, 187);
    model5.menuButtonColor = RGB(36, 186, 167);
    model5.menuColor = RGB(128, 196, 178);
    model5.imageUrl = @"FlowMenuImage2.png";
    model5.title = @"Art & Culture";
    model5.followersCount = @"437";
    model5.favoritesCount = @"245";
    model5.viewsCount = @"5432";
    
    FlowMenuModel *model6 = [[FlowMenuModel alloc] init];
    model6.bgColor = RGB(199, 119, 241);
    model6.menuButtonColor = RGB(182, 39, 232);
    model6.menuColor = RGB(175, 127, 235);
    model6.imageUrl = @"FlowMenuImage3.png";
    model6.title = @"Foot Festivals";
    model6.followersCount = @"472";
    model6.favoritesCount = @"214";
    model6.viewsCount = @"2741";
    
    
    self.dataArray = @[model1, model2, model3, model4, model5, model6];
    [self.flowMenuTableView reloadData];
    
}

- (void)setupTableViewAttributes {
    //tableview 条目不能铺满屏幕时 删除多余部分
    self.flowMenuTableView.tableFooterView = [UIView new];
}


#pragma mark - Network



#pragma mark - API



#pragma mark - Method

- (void)cellAnimation:(UIButton *)sender {
    
    FlowMenuTableViewCell *cell = (FlowMenuTableViewCell *)[sender superview];
    if (sender.tag == 0) {
        [cell openMainViewAnimate];
        sender.tag = 999;
    }
    else {
        [cell closeMainViewAnimate];
        sender.tag = 0;
    }
    
}


#pragma mark - Delegates

#pragma mark -- TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FlowMenuCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlowMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[FlowMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.menuButton addTarget:self action:@selector(cellAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [cell resetModel:self.dataArray[indexPath.row]];
    
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
