//
//  BaseScrollView.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/16.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return self;
}

@end
