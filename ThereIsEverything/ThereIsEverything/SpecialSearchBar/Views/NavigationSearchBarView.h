//
//  NavigationSearchBarView.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/27.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavigationSearchBarState) {
    NavigationSearchBarStateQuiet,
    NavigationSearchBarStateActive,
};



@protocol NavigationSearchBarDelegate

@required
- (void)startAnimation;
- (void)closeAnimation;
- (NSArray *)searchAnimationDone:(NSString *)searchString;

@end




@interface NavigationSearchBarView : UIView

@property (nonatomic, weak) id<NavigationSearchBarDelegate> delegate;
@property (nonatomic, readonly) NavigationSearchBarState state;

+ (NavigationSearchBarView *)customInit;
- (void)backButtonHidden:(BOOL)hide; //Defualt YES

@end
