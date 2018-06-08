//
//  AppDelegate.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/13.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatingDetailViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//存储，避免释放、二次重新加载。push时调用self.detailViewController
@property (nonatomic, strong) FloatingDetailViewController *detailViewController;
@property (nonatomic, strong) FloatingDetailViewController *tempDetailViewController;


@end

