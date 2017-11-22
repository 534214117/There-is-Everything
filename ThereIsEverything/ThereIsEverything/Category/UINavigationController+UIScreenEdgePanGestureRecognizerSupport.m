//
//  UINavigationController+UIScreenEdgePanGestureRecognizerSupport.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/16.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "UINavigationController+UIScreenEdgePanGestureRecognizerSupport.h"

@implementation UINavigationController (UIScreenEdgePanGestureRecognizerSupport)



- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer{
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.view.gestureRecognizers.count > 0){
        for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers){
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}

@end
