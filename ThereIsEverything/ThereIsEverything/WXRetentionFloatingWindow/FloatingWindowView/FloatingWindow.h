//
//  FloatingWindow.h
//  ThereIsEverything
//
//  Created by Sonia on 2018/5/30.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GestureResponseDelegate <NSObject>

@required
- (void)didStartPanGesture;
- (void)didChangePanGesture:(CGPoint)centerPoint;
- (void)didEndPanGesture;

@end

@interface FloatingWindow : UIView

@property (nonatomic, weak) id<GestureResponseDelegate> delegate;


+ (FloatingWindow *)shareFloatingWindow;


- (void)viewWillAppearOrGestureIntoFloatingControlView;
- (void)viewWillDisappearAndGestureIntoFloatingControlView:(BOOL)reset;

@end
