//
//  ImageWaterfallFlowViewController.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/14.
//Copyright © 2017年 Mine. All rights reserved.
//

#import "ImageWaterfallFlowViewController.h"
#import "BaseCollectionView.h"

#import "ImageAnimateNavigationTransition.h"
#import "ImageAnimateNavigationPopTransition.h"
#import "ImageAnimatePresentationTransition.h"

#import "UICollectionViewWaterfallLayout.h"
#import "UICollectionViewResortGesture.h"
#import "ImageModel.h"

#import "DetailViewController.h"

#define CellID @"CustomCellID"


@interface ImageWaterfallFlowViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewWaterfallLayoutDelegate, UICollectionViewResortGestureDelegate, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) BaseCollectionView *waterfallCollectionView;

@end

@implementation ImageWaterfallFlowViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupDataSource];
    [self setupCollectionView];
    
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

- (void)setupCollectionView {
    
    UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
    layout.delegate = self;
    
    self.waterfallCollectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, K_StatusBarAndNavigationBarHeight, KSCreenWidth, KSCreenHeight - K_StatusBarAndNavigationBarHeight) collectionViewLayout:layout];
    self.waterfallCollectionView.backgroundColor = RGB(23, 44, 60);
    self.waterfallCollectionView.delegate = self;
    self.waterfallCollectionView.dataSource = self;
    [self.view addSubview:self.waterfallCollectionView];
    
    [self.waterfallCollectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:CellID];
    
    UICollectionViewResortGesture *resortGesture = [[UICollectionViewResortGesture alloc] initWithCollectionView:self.waterfallCollectionView];
    resortGesture.resortDelegate = self;
    [self.waterfallCollectionView addGestureRecognizer:resortGesture];
    
}



#pragma mark - Network



#pragma mark - API



#pragma mark - Method


- (void)setupNavigationDelegate {
    self.navigationController.delegate = self;
}



#pragma mark - Delegates

#pragma mark -- UICollectionView Delegate & DataSource & WaterfallLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    
    return cell;
}

- (CGFloat)waterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)itemWidth {
    
    ImageModel *model = self.dataArray[index];
    
    return itemWidth * model.imageHeight / model.imageWidth;
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.dataArray exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    [self.waterfallCollectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    self.selectedCell = (ImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    ImageModel *model = self.dataArray[indexPath.item];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [detailVC setContentImage:[UIImage imageNamed:model.imageUrl] contentString:model.imageContent];
    
    if (self.present) {
        detailVC.transitioningDelegate = self;
        [self presentViewController:detailVC animated:YES completion:nil];
    }
    else {
        [self.navigationController pushViewController:detailVC animated:YES];
    }

}

//- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath {
//    /* 可以指定位置禁止交换 */
//
//}




- (int)columnCountInWaterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout {
    return 3;
}

- (CGFloat)columnMarginInWaterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout {
    return 10;
}

- (CGFloat)rowMarginInWaterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout {
    return 10;
}

- (UIEdgeInsets)edgeInsetsInWaterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}



#pragma mark -- UICollectionViewResortGestureDelegate

- (void)dragItemIndex:(NSInteger)dragIndex endItemIndex:(NSInteger)endIndex {
    
    ImageModel *model = self.dataArray[dragIndex];
    [self.dataArray removeObject:model];
    [self.dataArray insertObject:model atIndex:endIndex];
    [self.waterfallCollectionView reloadData];
    
}


#pragma mark -- UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [ImageAnimatePresentationTransition new];
}

//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//
//}





#pragma mark -- UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        return [ImageAnimateNavigationTransition new];
    } else if (operation == UINavigationControllerOperationPop && fromVC != self) {
        return [ImageAnimateNavigationPopTransition new];
    } else {
        return nil;
    }
}



#pragma mark -- Lazy Load Methods

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
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


- (void)setupDataSource {
    NSMutableArray *tempImageUrl = [[NSMutableArray alloc] init];
    for (int i = 0; i < 24; i++) {
        [tempImageUrl addObject:[NSString stringWithFormat:@"%d.jpeg", i+1]];
    }
    
    NSArray *tempImageWH = @[@[@451, @803], @[@446, @803], @[@593, @444], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@451, @803], @[@593, @444], @[@451, @803], @[@593, @333], @[@536, @803]];
    
    for (int i = 0; i < tempImageUrl.count; i++) {
        ImageModel *model = [[ImageModel alloc] initWithImageUrl:tempImageUrl[i] imageContent:nil imageWidth:[tempImageWH[i][0] floatValue] imageHeigh:[tempImageWH[i][1] floatValue]];
        [self.dataArray addObject:model];
    }
    
//    [self.waterfallCollectionView reloadData];
    
}

@end
