//
//  StarWarsViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/9.
//Copyright © 2018年 Mine. All rights reserved.
//

#import "StarWarsViewController.h"
#import "CAShapeLayer+CAShapeLayerMore.h"
#import "StarWarsProfleViewController.h"

#import "StarWarsTransitionPresenting.h"


#define LOGOIMAGEMARGIN 60
#define BUTTONIMAGEMARGIN 80


@interface StarWarsViewController () <CAAnimationDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) CAEmitterLayer *emitter;
@property (nonatomic, strong) CAEmitterCell *particle;
@property (nonatomic, strong) NSTimer *emitterTimer;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation StarWarsViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupEmitter];
    [self setupPartical];
    [self setupTimer];
    [self setupMainView];
    [self setupBackButton];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setupNavigationBar];
    
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
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)resetNavigationBar {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupBackButton {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, K_StatusBarHeight, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    [backButton addTarget:self action:@selector(navigationPop) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:backButton];
}

- (void)setupEmitter {
    self.emitter = [CAEmitterLayer layer];
    self.emitter.emitterMode = kCAEmitterLayerOutline;
    self.emitter.emitterShape = kCAEmitterLayerCircle;
    self.emitter.renderMode = kCAEmitterLayerOldestFirst;
    self.emitter.preservesDepth = true;
    self.emitter.emitterPosition = self.view.center;
    [self.view.layer addSublayer:self.emitter];
}

- (void)setupPartical {
    self.particle = [CAEmitterCell emitterCell];
    self.particle.contents = (__bridge id _Nullable)([UIImage imageNamed:@"spark"].CGImage);
    self.particle.birthRate = 10;
    self.particle.lifetime = 50;
    self.particle.lifetimeRange = 5;
    self.particle.velocity = 20;
    self.particle.velocityRange = 10;
    self.particle.scale = 0.02;
    self.particle.scaleRange = 0.1;
    self.particle.scaleSpeed = 0.02;
    self.emitter.emitterCells = @[self.particle];
}

- (void)setupMainView {
    self.mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.mainView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainView];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star_wars_logo"]];
    logoImage.frame = CGRectMake(LOGOIMAGEMARGIN, 150, KSCreenWidth-2*LOGOIMAGEMARGIN, (107/250.f)*(KSCreenWidth-2*LOGOIMAGEMARGIN));
    [self.mainView addSubview:logoImage];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(LOGOIMAGEMARGIN, CGRectGetMaxY(logoImage.frame)+50, KSCreenWidth-2*LOGOIMAGEMARGIN, 80)];
    textLabel.numberOfLines = 2;
    textLabel.text = @"GREETINGS\nMY  YOUNG  PADAWAN!";
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:20];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:textLabel];
    
    UILabel *profileButton = [[UILabel alloc] initWithFrame:CGRectMake(BUTTONIMAGEMARGIN, CGRectGetMaxY(textLabel.frame)+50, KSCreenWidth-2*BUTTONIMAGEMARGIN, 60)];
    profileButton.layer.cornerRadius = 30;
    profileButton.layer.borderWidth = 1;
    profileButton.layer.borderColor = HEXColor(0xf4dc3c).CGColor;
    profileButton.textColor = [UIColor whiteColor];
    profileButton.textAlignment = NSTextAlignmentCenter;
    profileButton.text = @"Setup Your profile";
    profileButton.userInteractionEnabled = YES;
    [self.mainView addSubview:profileButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapButtonAction:)];
    [profileButton addGestureRecognizer:tap];
}



#pragma mark - Network



#pragma mark - API



#pragma mark - Method

- (void)navigationPop {
    [self resetNavigationBar];
    if (self.emitterTimer) {
        [self.emitterTimer invalidate];
        self.emitterTimer = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupTimer {
    self.emitterTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(randomizeEmitterPosition) userInfo:nil repeats:YES];
}

- (void)randomizeEmitterPosition {
    int sizeWidth = MAX(self.view.bounds.size.width, self.view.bounds.size.height);
    double radius = arc4random() % sizeWidth;
    self.emitter.emitterSize = CGSizeMake(radius, radius);
    self.particle.birthRate = 10 + sqrt(radius);
}

- (void)tapButtonAction:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded && !self.shapeLayer) {
        CGPoint pt = [gesture locationInView:gesture.view];
        self.shapeLayer = [CAShapeLayer circleOpenLayerWithStartFrame:CGRectMake(pt.x, pt.y, 0, 0) inView:gesture.view delegateTo:self];
        gesture.view.layer.mask = self.shapeLayer;
        gesture.view.layer.backgroundColor = HEXColor(0xf4dc3c).CGColor;
    }
}


#pragma mark - Delegates

#pragma mark -- CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    StarWarsProfleViewController *vc = [[StarWarsProfleViewController alloc] init];
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:^{
        self.shapeLayer.superlayer.backgroundColor = [UIColor clearColor].CGColor;
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
    }];
}

#pragma mark -- UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [StarWarsTransitionPresenting new];
}



#pragma mark -- Lazy Load Methods



#pragma mark -- Super Method OverRide

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)dealloc {
    
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
