//
//  ContainerViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/16.
//Copyright © 2018年 Mine. All rights reserved.
//

#import "ContainerViewController.h"
#import "SoniaCalendar.h"

@interface ContainerViewController ()

@property (nonatomic, strong) SoniaCalendar *soniaCalendar;

@end

@implementation ContainerViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSoniaCalendar];
    
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

- (void)setupSoniaCalendar {
    self.view.backgroundColor = HEXColor(0x669ea9);
    
    self.soniaCalendar = [[SoniaCalendar alloc] initWithFrame:CGRectMake(40, 100, KSCreenWidth-80, 60)];
    [self.view addSubview: self.soniaCalendar];
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
