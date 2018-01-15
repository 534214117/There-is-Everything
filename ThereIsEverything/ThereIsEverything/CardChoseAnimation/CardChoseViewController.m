//
//  CardChoseViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/29.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "CardChoseViewController.h"
#import "MenuScrollView.h"
#import "CardChooseView.h"
#import "CustomCardView.h"

@interface CardChoseViewController () <MenuScrollViewAnimateDelegate>

@property (nonatomic, strong) MenuScrollView *menuScrollView;
@property (nonatomic, strong) CardChooseView *cardChooseView;

@end

@implementation CardChoseViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupMenuScrollView];
    [self setupCardChooseScrollView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.menuScrollView viewDidAppear];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self resetNavigationBar];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}


#pragma mark - User Interface

- (void)setupNavigationBar {
    self.view.backgroundColor = RGB(255, 255, 239);
    self.navigationController.navigationBar.tintColor = RGB(169, 158, 169);
    self.navigationController.navigationBar.barTintColor = RGB(255, 255, 239);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"Card Choose Animation Exhibition";
}

- (void)resetNavigationBar {
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)setupMenuScrollView {
    NSArray *images = @[@"scroll1.png", @"scroll2.png", @"scroll3.png", @"scroll4.png", @"scroll5.png", @"scroll6.png", @"scroll7.png", @"scroll8.png", @"scroll9.png", @"scroll10.png"];
    self.menuScrollView = [[MenuScrollView alloc] initWithItemImages:images viewOriginY:0 viewHeight:50];
    self.menuScrollView.menuDelegate = self;
    [self.view addSubview:self.menuScrollView];
}

- (void)setupCardChooseScrollView {
    CustomCardModel *model1 = [[CustomCardModel alloc] init];
    model1.titleColor = RGB(64, 225, 187);
    model1.titleImage = @"card1";
    model1.title = @"Localcity Yoga";
    model1.subTitle = @"How to survive in the night";
    model1.date = @"18 oct";
    model1.time = @"7:00 am";
    model1.distance = @"3.1 km";
    model1.likeCount = @"+18";
    model1.mainImage = @"yoga.jpg";
    
    CustomCardModel *model2 = [[CustomCardModel alloc] init];
    model2.titleColor = RGB(202, 125, 249);
    model2.titleImage = @"card2";
    model2.title = @"Baloon Festival";
    model2.subTitle = @"To infinity and more";
    model2.date = @"19 oct";
    model2.time = @"8:00 am";
    model2.distance = @"3.1 km";
    model2.likeCount = @"+16";
    model2.mainImage = @"reqiqiu.jpg";
    
    CustomCardModel *model3 = [[CustomCardModel alloc] init];
    model3.titleColor = RGB(237, 203, 95);
    model3.titleImage = @"card3";
    model3.title = @"Opera";
    model3.subTitle = @"Take to the skies";
    model3.date = @"19 oct";
    model3.time = @"8:00 am";
    model3.distance = @"3.1 km";
    model3.likeCount = @"+16";
    model3.mainImage = @"opera.jpg";
    
    NSArray<CustomCardModel *> *array = @[model1, model2, model3, model1, model2, model3, model1, model2, model3, model1, model2, model3, model1, model2, model3, model1, model2, model3];
    
    self.cardChooseView = [[CardChooseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuScrollView.frame)/2.f, KSCreenWidth, KSCreenHeight-K_StatusBarAndNavigationBarHeight-CGRectGetMaxY(self.menuScrollView.frame)/2.f)];
    self.cardChooseView.modelArray = array;
    [self.view addSubview:self.cardChooseView];
}


#pragma mark - Network



#pragma mark - API



#pragma mark - Method



#pragma mark - Delegates

- (void)menuWillBeginAnimteBig {
    self.cardChooseView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.cardChooseView.frame;
        frame.origin.y += 30;
        self.cardChooseView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)menuWillBeginAnimteSmall {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.cardChooseView.frame;
        frame.origin.y -= 30;
        self.cardChooseView.frame = frame;
    } completion:^(BOOL finished) {
        self.cardChooseView.userInteractionEnabled = YES;
    }];
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
