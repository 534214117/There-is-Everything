//
//  UIView+UIViewMore.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/28.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "UIView+UIViewMore.h"

@implementation UIView (UIViewMore)

- (UIViewController *)getParentViewControllerOfTheView
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
