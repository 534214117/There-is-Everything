//
//  MasonryLearningViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/6/6.
//Copyright © 2018年 Mine. All rights reserved.
//

#import "MasonryLearningViewController.h"
#import <Masonry.h>

@interface MasonryLearningViewController ()

@end

@implementation MasonryLearningViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [[UIView alloc] init];
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view1.backgroundColor = RGB(65, 105, 225);
    [self.view addSubview:view1];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = RGB(135, 206, 235);
    [scrollView addSubview:container];
    
    UIView *view2 = [[UIView alloc] init];
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    view2.backgroundColor = RGB(106, 90, 205);
    [view1 addSubview:view2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.translatesAutoresizingMaskIntoConstraints = NO;
    view3.backgroundColor = RGB(106, 90, 205);
    [view1 addSubview:view3];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(K_StatusBarAndNavigationBarHeight+10);
        make.right.offset(-10);
        make.bottom.mas_equalTo(scrollView.mas_top).with.offset(-10);
        make.height.mas_equalTo(scrollView);
    }];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.bottom.offset(-20);
        make.right.offset(-10);
        make.top.mas_equalTo(view1.mas_bottom).with.offset(10);
        make.height.mas_equalTo(view1);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.offset(0);
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.right.mas_equalTo(view3.mas_left).with.offset(-10);
        make.width.mas_equalTo(view3);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.left.mas_equalTo(view2.mas_right).with.offset(10);
        make.width.mas_equalTo(view2);
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [view1 mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.offset(-200);
//        }];
//        [self.view setNeedsUpdateConstraints];
//        [self.view updateConstraintsIfNeeded];
//        [UIView animateWithDuration:1 animations:^{
//            [self.view layoutIfNeeded];
//        }];
//    });
    
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
