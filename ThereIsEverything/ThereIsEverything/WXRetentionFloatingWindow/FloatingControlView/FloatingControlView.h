//
//  FloatingControlView.h
//  ThereIsEverything
//
//  Created by Sonia on 2018/5/30.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatingWindow.h"

@protocol FloatingControlDelegate <NSObject>

@required
- (void)didContain:(BOOL)isCache;

@end


@interface FloatingControlView : UIView <GestureResponseCopyDelegate>

@property (nonatomic, weak) id<FloatingControlDelegate> delegate;

+ (FloatingControlView *)shareFloatingControlView;

@end
