//
//  FloatingDetailViewController.h
//  ThereIsEverything
//
//  Created by Sonia on 2018/5/31.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "BaseViewController.h"

@protocol GestureResponseCopyDelegate <NSObject>

@required
- (void)didStartPanGesture;
- (void)didChangePanGesture:(CGPoint)centerPoint;
- (void)didEndPanGesture;

@end

@interface FloatingDetailViewController : BaseViewController

@property (nonatomic, weak) id<GestureResponseCopyDelegate> delegate;
@property (nonatomic, assign) int tag;//判断需不需要重新加载新页面

@end
