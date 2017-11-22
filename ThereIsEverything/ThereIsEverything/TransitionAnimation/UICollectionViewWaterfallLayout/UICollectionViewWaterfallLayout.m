//
//  UICollectionViewWaterfallLayout.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/15.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "UICollectionViewWaterfallLayout.h"



//默认的列数
static const NSInteger DefaultColumnCount = 3;

//每一列之间的间距
static const CGFloat DefaultColumnMargin = 10;

//没一行之间的间距
static const CGFloat DefaultRowMargin = 10;

//边缘间距
static const UIEdgeInsets DefaultEdgeInsets = {10, 10, 10, 10};



@interface UICollectionViewWaterfallLayout ()

//存放所有cell的布局属性
@property (nonatomic, strong) NSMutableArray *attrsArray;
//存放所有列的当前高度
@property (nonatomic, strong) NSMutableArray *columnHeights;
//内容的高度
@property (nonatomic, assign) CGFloat contentHeight;

@end


@implementation UICollectionViewWaterfallLayout

//重写4个方法

//做一些初始化的操作，这个方法必须先调用一下父类的实现
- (void)prepareLayout {
    
    [super prepareLayout];
    
    //清除之前计算的所有高度，因为刷新的时候回调用这个方法
    self.contentHeight = 0;
    [self.columnHeights removeAllObjects];
    
    int forCount = [self.delegate respondsToSelector:@selector(columnCountInWaterfallLayout:)] ? [self.delegate columnCountInWaterfallLayout:self] : DefaultColumnCount;
    
    for (NSInteger i = 0; i < forCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }

    
    
    //开始创建每一个cell对应的布局属性
    for (int section = 0; section < self.collectionView.numberOfSections; section++) {
        
        for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:section]; i++) {
            // 创建位置
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
            // 获取indexPath位置cell对应的布局属性
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attrs];
        }
        
    }
    
}

//方法是返回UICollectionView的可滚动范围
- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

//方法返回的是一个装着UICollectionViewLayoutAttributes的数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}


//方法返回indexPath位置的UICollectionViewLayoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right -(self.columnCount - 1) * self.columnMargin) / self.columnCount;
    
    CGFloat h = [self.delegate waterfallLayout:self heightForRowAtIndexPath:indexPath.item itemWidth:w];
    
    NSInteger destColumn = 0;
    
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
    
}










- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterfallLayout:)]) {
        return [self.delegate rowMarginInWaterfallLayout:self];
    } else {
        return DefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterfallLayout:)]) {
        return [self.delegate columnMarginInWaterfallLayout:self];
    } else {
        return DefaultColumnMargin;
    }
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterfallLayout:)]) {
        return [self.delegate columnCountInWaterfallLayout:self];
    } else {
        return DefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterfallLayout:)]) {
        return [self.delegate edgeInsetsInWaterfallLayout:self];
    } else {
        return DefaultEdgeInsets;
    }
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}




@end
