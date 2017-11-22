//
//  UICollectionViewResortGesture.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/15.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICollectionViewResortGestureDelegate <NSObject>

@required
- (void)dragItemIndex:(NSInteger)dragIndex endItemIndex:(NSInteger)endIndex;

@end


@interface UICollectionViewResortGesture : UILongPressGestureRecognizer

@property (nonatomic, weak) id<UICollectionViewResortGestureDelegate> resortDelegate;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end
