//
//  UICollectionViewWaterfallLayout.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/15.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>



@class UICollectionViewWaterfallLayout;

@protocol UICollectionViewWaterfallLayoutDelegate <NSObject>

@required
- (CGFloat)waterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional
//列数
- (int)columnCountInWaterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout;
//每列间距（不算边距）
- (CGFloat)columnMarginInWaterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout;
//行间距（不算边距）
- (CGFloat)rowMarginInWaterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout;
//边距
- (UIEdgeInsets)edgeInsetsInWaterfallLayout:(UICollectionViewWaterfallLayout *)waterfallLayout;

@end


@interface UICollectionViewWaterfallLayout : UICollectionViewLayout

@property (nonatomic ,weak) id<UICollectionViewWaterfallLayoutDelegate> delegate;

@end
