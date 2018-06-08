//
//  SoniaCalendar.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/16.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "SoniaCalendar.h"
#import "CalendarCollectionViewCell.h"
#import <POP.h>
#import <SDAutoLayout.h>

#define MARGININSIDE 10
#define SELFWIDTH self.frame.size.width
#define SELFHEIGHT self.frame.size.height
#define WEEKDEFAUKT @[@"M", @"T", @"W", @"T", @"F", @"S", @"S"]
#define CellSize (CGRectGetWidth(self.calendarCollectionView.frame))/7.f
#define lineViewSize 20


typedef NS_ENUM(NSInteger, SoniaCalendarState) {
    SoniaCalendarStateQuiet,
    SoniaCalendarStateActive,
    SoniaCalendarStateCompleted,
};



@interface SoniaCalendar () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) BaseCollectionView *calendarCollectionView;
@property (nonatomic, assign) SoniaCalendarState state;
@property (nonatomic, assign) CGRect originRect;
@property (nonatomic, assign) CGRect activeRect;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *linesArray;
@property (nonatomic, strong) NSArray *linesOriginArray;
@property (nonatomic, strong) NSArray *linesDestinationArray;

@end



@implementation SoniaCalendar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.state = SoniaCalendarStateQuiet;
        [self setContentLabel];
        [self setValueLabel];
        self.originRect = frame;
        [self setupAttrs];
        [self setupLinesView];
    }
    return self;
}


- (void)setupAttrs {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(5, 5);
    self.layer.shadowOpacity = 0.3;
    self.clipsToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [self addGestureRecognizer:tap];
}

- (UILabel *)setContentLabel {
    if (!self.contentLabel) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, MARGININSIDE, SELFWIDTH-40-80, SELFHEIGHT-2*MARGININSIDE)];
        self.contentLabel.text = @"PICK YOUR DATE";
        self.contentLabel.textColor = HEXColor(0x818181);
        self.contentLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.contentLabel];
    }
    return self.contentLabel;
}

- (UILabel *)setValueLabel {
    if (!self.valueLabel) {
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(20-40, MARGININSIDE, SELFWIDTH-40, SELFHEIGHT-2*MARGININSIDE)];
        self.valueLabel.text = @"NOVEMBER. 2018";
        self.valueLabel.textColor = HEXColor(0x818181);
        self.valueLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        self.valueLabel.alpha = 0;
        [self addSubview:self.valueLabel];
    }
    return self.valueLabel;
}





- (void)changeToActive {
    CGRect tempRect = self.originRect;
    tempRect.size.height += 300;
    self.activeRect = tempRect;
    
    POPBasicAnimation *anim = [POPBasicAnimation easeInEaseOutAnimation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    anim.fromValue = [NSValue valueWithCGRect:self.originRect];
    anim.toValue = [NSValue valueWithCGRect:self.activeRect];
    anim.duration = 2;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        NSLog(@"%@", NSStringFromCGRect(self.frame));
        if (finished) {
            [self pop_removeAllAnimations];
            
        }
    };
    [self pop_addAnimation:anim forKey:@"Active"];
    
    [self setupInitDataArray];
    [self setupCollectionView];
    [self startLabelAnimation];
    [self startLinesAnimation];
}

- (void)changeToCompleted {
    POPBasicAnimation *anim = [POPBasicAnimation easeOutAnimation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    anim.fromValue = [NSValue valueWithCGRect:self.activeRect];
    anim.toValue = [NSValue valueWithCGRect:self.originRect];
    anim.duration = 2;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        NSLog(@"%@", NSStringFromCGRect(self.frame));
        if (finished) {
            [self pop_removeAllAnimations];
            
        }
    };
    [self pop_addAnimation:anim forKey:@"Active"];
}


- (void)changeState:(SoniaCalendarState)state {
    switch (state) {
        case SoniaCalendarStateActive:
            [self changeToActive];
            self.state = SoniaCalendarStateActive;
            break;
        case SoniaCalendarStateCompleted:
            [self changeToCompleted];
            self.state = SoniaCalendarStateCompleted;
            break;
        default:
            break;
    }
}


- (void)tapHandle:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded && self.state == SoniaCalendarStateQuiet) {
        [self changeState:SoniaCalendarStateActive];
    }
    else {
        [self changeState:SoniaCalendarStateCompleted];
    }
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.calendarCollectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(MARGININSIDE*2, CGRectGetHeight(self.originRect), CGRectGetWidth(self.originRect)-MARGININSIDE*4, 300) collectionViewLayout:layout];
    self.calendarCollectionView.delegate = self;
    self.calendarCollectionView.dataSource = self;
    self.calendarCollectionView.backgroundColor = [UIColor whiteColor];
    [self.calendarCollectionView registerClass:[CalendarCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self addSubview:self.calendarCollectionView];
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}
//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake((CGRectGetHeight(collectionView.frame)-CellSize*6)/2.f, 0, (CGRectGetHeight(collectionView.frame)-CellSize*6)/2.f, 0);
}
//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}
//脚部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CellSize, CellSize);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    POPBasicAnimation *anim1 = [POPBasicAnimation linearAnimation];
    anim1.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    anim1.toValue = [NSValue valueWithCGPoint:CGPointMake(0.01, 0.01)];
    anim1.duration = 0.01;
    anim1.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        NSLog(@"%@", NSStringFromCGRect(self.frame));
        if (finished) {
            [cell pop_removeAllAnimations];
            
            POPBasicAnimation *anim = [POPBasicAnimation easeInEaseOutAnimation];
            anim.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
            anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
            anim.duration = 1.5;
            anim.beginTime = CACurrentMediaTime() + 1.5/45.f *indexPath.row;
            anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
                NSLog(@"%@", NSStringFromCGRect(self.frame));
                if (finished) {
                    [cell pop_removeAllAnimations];
                    
                }
            };
            [cell pop_addAnimation:anim forKey:[NSString stringWithFormat:@"Cell%d", (int)indexPath]];
        }
    };

    [cell pop_addAnimation:anim1 forKey:[NSString stringWithFormat:@"Cell%d", (int)indexPath]];
    
//    NSTimeInterval duration = 0.1 + (NSTimeInterval)(indexPath.row) / 10.0;
    
}
//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
}

- (void)setupInitDataArray {
    self.dataArray = [[NSMutableArray alloc] init];
    
    
}




- (void)setupLinesView {
    for (int i = 0; i < self.linesOriginArray.count; i++) {
        NSValue *value = self.linesOriginArray[i];
        CGRect rect = [value CGRectValue];
        UIView *view = [[UIView alloc] initWithFrame:rect];
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        [self.linesArray addObject:view];
    }
}



- (void)startLabelAnimation {
    CGRect toRect1 = self.contentLabel.frame;
    toRect1.origin.x += 80;
    
    POPBasicAnimation *anim1 = [POPBasicAnimation easeInAnimation];
    anim1.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    anim1.fromValue = [NSValue valueWithCGRect:self.contentLabel.frame];
    anim1.toValue = [NSValue valueWithCGRect:toRect1];
    anim1.duration = 2;
    anim1.beginTime = CACurrentMediaTime();
    anim1.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        NSLog(@"%@", NSStringFromCGRect(self.frame));
        if (finished) {
            [self.contentLabel pop_removeAnimationForKey:@"Move"];
        }
    };
    [self.contentLabel pop_addAnimation:anim1 forKey:@"Move"];
    
    
    CGRect toRect2 = self.valueLabel.frame;
    toRect2.origin.x += 40;
    
    POPBasicAnimation *anim2 = [POPBasicAnimation easeInAnimation];
    anim2.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    anim2.fromValue = [NSValue valueWithCGRect:self.valueLabel.frame];
    anim2.toValue = [NSValue valueWithCGRect:toRect2];
    anim2.duration = 1;
    anim2.beginTime = CACurrentMediaTime() + 0.5;
    anim2.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        NSLog(@"%@", NSStringFromCGRect(self.frame));
        if (finished) {
            [self.valueLabel pop_removeAnimationForKey:@"Move"];
        }
    };
    [self.valueLabel pop_addAnimation:anim2 forKey:@"Move"];
    
    [UIView animateWithDuration:1 animations:^{
        self.contentLabel.alpha = 0;
    }];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.valueLabel.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}





- (void)startLinesAnimation {
    for (int i = 0; i < self.linesArray.count; i++) {
        UIView *view = self.linesArray[i];
        [self bringSubviewToFront:view];
        
        POPBasicAnimation *anim = [POPBasicAnimation easeInEaseOutAnimation];
        anim.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        anim.fromValue = self.linesOriginArray[i];
        anim.toValue = self.linesDestinationArray[i];
        anim.duration = 2;
        anim.beginTime = CACurrentMediaTime() + 1.5/45.f *i;
        anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            NSLog(@"%@", NSStringFromCGRect(self.frame));
            if (finished) {
                [view pop_removeAnimationForKey:[NSString stringWithFormat:@"Move%d", (int)i]];
            }
        };
        [view pop_addAnimation:anim forKey:[NSString stringWithFormat:@"Move%d", (int)i]];
        
        [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            view.alpha = 0.5;
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (NSArray *)linesOriginArray {
    if (!_linesOriginArray) {
        CGFloat margin = MARGININSIDE*2;
        CGRect leftLineRect = CGRectMake(SELFWIDTH-lineViewSize-margin, margin, 1, lineViewSize);
        CGRect centerVerticalRect = CGRectMake(SELFWIDTH-lineViewSize/2.f-margin, margin, 1, lineViewSize);
        CGRect rightLineRect = CGRectMake(SELFWIDTH-margin, margin, 1, lineViewSize);
        CGRect topLineRect = CGRectMake(SELFWIDTH-lineViewSize-margin, margin, lineViewSize, 1);
        CGRect centerHorizontalRect = CGRectMake(SELFWIDTH-lineViewSize-margin, margin+lineViewSize/2.f, lineViewSize, 1);
        CGRect bottomLineRect = CGRectMake(SELFWIDTH-lineViewSize-margin, margin+lineViewSize, lineViewSize, 1);
        _linesOriginArray = @[[NSValue valueWithCGRect:leftLineRect],
                              [NSValue valueWithCGRect:leftLineRect],
                              [NSValue valueWithCGRect:leftLineRect],
                              [NSValue valueWithCGRect:centerVerticalRect],
                              [NSValue valueWithCGRect:centerVerticalRect],
                              [NSValue valueWithCGRect:centerVerticalRect],
                              [NSValue valueWithCGRect:rightLineRect],
                              [NSValue valueWithCGRect:rightLineRect],
                              [NSValue valueWithCGRect:topLineRect],
                              [NSValue valueWithCGRect:topLineRect],
                              [NSValue valueWithCGRect:centerHorizontalRect],
                              [NSValue valueWithCGRect:centerHorizontalRect],
                              [NSValue valueWithCGRect:bottomLineRect],
                              [NSValue valueWithCGRect:bottomLineRect]];
    }
    return _linesOriginArray;
}

- (NSArray *)linesDestinationArray {
    if (!_linesDestinationArray) {
        CGFloat originX = self.calendarCollectionView.frame.origin.x;
        CGFloat originY = self.calendarCollectionView.frame.origin.y+(CGRectGetHeight(self.calendarCollectionView.frame)-CellSize*6)/2.f;
        CGFloat lineWidth = 1;
        //故意换了顺序 参差不齐的效果还不错 原稿也是这样
        _linesDestinationArray = @[[NSValue valueWithCGRect:CGRectMake(originX+CellSize*0, originY, lineWidth, CellSize*5)],
                                   [NSValue valueWithCGRect:CGRectMake(originX+CellSize*1, originY, lineWidth, CellSize*5)],
                                   [NSValue valueWithCGRect:CGRectMake(originX+CellSize*2, originY, lineWidth, CellSize*5)],
                                   [NSValue valueWithCGRect:CGRectMake(originX+CellSize*3, originY, lineWidth, CellSize*5)],
                                   [NSValue valueWithCGRect:CGRectMake(originX+CellSize*4, originY, lineWidth, CellSize*5)],
                                   [NSValue valueWithCGRect:CGRectMake(originX+CellSize*5, originY, lineWidth, CellSize*5)],
                                   [NSValue valueWithCGRect:CGRectMake(originX+CellSize*6, originY, lineWidth, CellSize*5)],
                                   [NSValue valueWithCGRect:CGRectMake(originX+CellSize*7, originY, lineWidth, CellSize*5)],
                                   [NSValue valueWithCGRect:CGRectMake(originX, originY+CellSize*3, CellSize*7, lineWidth)],
                                   [NSValue valueWithCGRect:CGRectMake(originX, originY+CellSize*1, CellSize*7, lineWidth)],
                                   [NSValue valueWithCGRect:CGRectMake(originX, originY+CellSize*5, CellSize*7, lineWidth)],
                                   [NSValue valueWithCGRect:CGRectMake(originX, originY+CellSize*4, CellSize*7, lineWidth)],
                                   [NSValue valueWithCGRect:CGRectMake(originX, originY+CellSize*0, CellSize*7, lineWidth)],
                                   [NSValue valueWithCGRect:CGRectMake(originX, originY+CellSize*2, CellSize*7, lineWidth)]];
    }
    return _linesDestinationArray;
}

- (NSMutableArray *)linesArray {
    if (!_linesArray) {
        _linesArray = [[NSMutableArray alloc] init];
    }
    return _linesArray;
}

@end
