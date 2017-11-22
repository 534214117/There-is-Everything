//
//  DetailViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/16.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "DetailViewController.h"

#import "ImageAnimateNavigationPopTransition.h"
#import "UINavigationController+UIScreenEdgePanGestureRecognizerSupport.h"

@interface DetailViewController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation DetailViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setupNavigationDelegate];
    
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


- (void)setContentImage:(UIImage *)image contentString:(NSString *)content {
    
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePan];
    
    if (self.parentViewController) {
        self.scrollView = [[BaseScrollView alloc] initWithFrame:CGRectMake(0, K_StatusBarAndNavigationBarHeight, KSCreenWidth, KSCreenHeight - K_StatusBarAndNavigationBarHeight)];
    }
    else {
        self.scrollView = [[BaseScrollView alloc] initWithFrame:CGRectMake(0, 20, KSCreenWidth, KSCreenHeight - 20)];
    }
    self.scrollView.delegate = self;
    [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:edgePan];
    [self.view addSubview:self.scrollView];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.imageView];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = RGB(217, 104, 49);
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    [self.scrollView addSubview:self.contentLabel];
    
    
    self.imageView.image = image;
    CGSize size = image.size;
    CGFloat height = (size.height/size.width)*(KSCreenWidth - DefualtMargin*2);
    self.imageView.frame = CGRectMake(DefualtMargin, DefualtMargin, KSCreenWidth - DefualtMargin*2, height);
    self.contentLabel.frame = CGRectMake(DefualtMargin, CGRectGetMaxY(self.imageView.frame)+DefualtMargin, CGRectGetWidth(self.imageView.frame), 20);
    
    self.contentLabel.text = content;
    CGSize sizeLabel = [self.contentLabel sizeThatFits:CGSizeMake(self.contentLabel.frame.size.width, MAXFLOAT)];
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, self.contentLabel.frame.size.width, sizeLabel.height);
    
    self.scrollView.contentSize = CGSizeMake(KSCreenWidth, CGRectGetMaxY(self.contentLabel.frame)+DefualtMargin);
}


#pragma mark - Network



#pragma mark - API



#pragma mark - Method

- (void)setupNavigationDelegate {
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = RGB(23, 44, 60);
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan {
    
    CGFloat progress = [edgePan translationInView:self.view].x / self.view.bounds.size.width;
    NSLog(@"%f", progress);
    
    if (edgePan.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (edgePan.state == UIGestureRecognizerStateChanged) {
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    } else if (edgePan.state == UIGestureRecognizerStateChanged || edgePan.state == UIGestureRecognizerStateEnded) {
        [self.percentDrivenTransition finishInteractiveTransition];
        self.percentDrivenTransition = nil;
    }
    
}





#pragma mark - Delegates

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.scrollView.contentOffset.y < -120 && !self.parentViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}




#pragma mark -- UINavigationControllerDelegate

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if ([animationController isKindOfClass:[ImageAnimateNavigationPopTransition class]]) {
        return self.percentDrivenTransition;
    }
    else {
        return nil;
    }
    
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPop) {
        return [ImageAnimateNavigationPopTransition new];
    }
    else {
        return nil;
    }
    
}


- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)otherGestureRecognizer {
    
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
