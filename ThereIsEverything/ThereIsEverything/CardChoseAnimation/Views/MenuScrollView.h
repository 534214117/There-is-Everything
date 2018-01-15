//
//  MenuScrollView.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/29.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "BaseScrollView.h"

@protocol MenuScrollViewAnimateDelegate <NSObject>
@optional
- (void)menuWillBeginAnimteBig;
- (void)menuWillBeginAnimteSmall;

@end


@interface MenuScrollView : BaseScrollView

@property (nonatomic, weak) id<MenuScrollViewAnimateDelegate> menuDelegate;

- (instancetype)initWithItemImages:(NSArray *)images viewOriginY:(CGFloat)y viewHeight:(CGFloat)height;
- (void)viewDidAppear;

- (void)startAnimateBig;
- (void)startAnimateSmall;

@end
