//
//  JellyCustomNavigationBar.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/21.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JellyCustomNavigationBar : UIView

@property (nonatomic, strong) UIButton *backButton;

- (void)setTitle:(NSString *)title;
- (void)showBackButton:(BOOL)state; //Defualt NO

- (void)animateStateChangeAtX:(CGFloat)x y:(CGFloat)y;
- (void)animateStateEnd;

@end
