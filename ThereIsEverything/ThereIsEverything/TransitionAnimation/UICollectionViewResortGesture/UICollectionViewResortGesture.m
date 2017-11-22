//
//  UICollectionViewResortGesture.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/15.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "UICollectionViewResortGesture.h"

@interface UICollectionViewResortGesture ()

@property (nonatomic, strong) UICollectionView * responseCollectionView;
@property (nonatomic, strong) NSIndexPath *startIndexPath;
@property (nonatomic, strong) NSIndexPath *dragingIndexPath;
@property (nonatomic, strong) NSIndexPath *insertIndexPath;

@end


@implementation UICollectionViewResortGesture

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        self = [super initWithTarget:self action:@selector(handleLongGesture:)];
        self.minimumPressDuration = 0.3;
        self.responseCollectionView = collectionView;
    }
    return self;
}

- (void)handleLongGesture:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self dragBegin:gesture];
            break;
        case UIGestureRecognizerStateChanged:
            [self dragChanged:gesture];
            break;
        case UIGestureRecognizerStateEnded:
            [self dragEnd:gesture];
            break;
        default:
            break;
    }
}

-(void)dragBegin:(UILongPressGestureRecognizer*)gesture{
    //根据手势begin位置获取所在的cell
    self.startIndexPath = nil;
    self.dragingIndexPath = nil;
    self.dragingIndexPath = [self.responseCollectionView indexPathForItemAtPoint:[gesture locationInView:self.responseCollectionView]];
    self.startIndexPath = self.dragingIndexPath;
    
    UICollectionViewCell *cell = [self.responseCollectionView cellForItemAtIndexPath:self.dragingIndexPath];
    [UIView animateWithDuration:0.5 animations:^{
        cell.alpha = 0.3;
    }];
    
    if (!self.dragingIndexPath) {
        return;
    }
    
}

-(void)dragChanged:(UILongPressGestureRecognizer*)gesture{
    //根据手势change位置获取初入的位置
    self.insertIndexPath = nil;
    self.insertIndexPath = [self.responseCollectionView indexPathForItemAtPoint:[gesture locationInView:self.responseCollectionView]];
    
    UICollectionViewCell *cell = [self.responseCollectionView cellForItemAtIndexPath:self.dragingIndexPath];
    cell.alpha = 0.3;
    
    
    if (self.insertIndexPath && self.dragingIndexPath) {
        [self.responseCollectionView moveItemAtIndexPath:self.dragingIndexPath toIndexPath:self.insertIndexPath];
        self.dragingIndexPath = self.insertIndexPath;
    }
}

-(void)dragEnd:(UILongPressGestureRecognizer*)gesture{
    
    if ([self.resortDelegate respondsToSelector:@selector(dragItemIndex:endItemIndex:)]) {
        [self.resortDelegate dragItemIndex:self.startIndexPath.item endItemIndex:self.insertIndexPath.item];
    }
    
    self.startIndexPath = nil;
    self.dragingIndexPath = nil;
    self.insertIndexPath = nil;
    
}

@end
