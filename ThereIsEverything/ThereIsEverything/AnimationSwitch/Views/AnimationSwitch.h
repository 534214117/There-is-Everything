//
//  AnimationSwitch.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/21.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchAnimateDelegate <NSObject>
@optional
- (void)willBeginAnimte;
- (void)willEndAnimte;

@end

@interface AnimationSwitch : UISwitch

@property (nonatomic, weak) id<SwitchAnimateDelegate> switchDelegate;

@end
