//
//  AppDelegate.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/13.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "AppDelegate.h"
#import "ThereIsEverythingViewController.h"
#import "FloatingWindow.h"
#import "FloatingControlView.h"
#import "TencentDingDangTest.h"

@interface AppDelegate () <FloatingControlDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:[[UINavigationController alloc] initWithRootViewController:[[ThereIsEverythingViewController alloc] init]]];
    [self.window makeKeyAndVisible];
    
    [FloatingControlView shareFloatingControlView].delegate = self;
    [FloatingWindow shareFloatingWindow].delegate = [FloatingControlView shareFloatingControlView];
    
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - FloatingControlDelegate

- (void)didContain:(BOOL)isCache {
    if (isCache) {
        self.detailViewController = self.tempDetailViewController;
        self.tempDetailViewController = nil;
    }
    else {
        self.detailViewController = nil;
        self.tempDetailViewController = nil;
    }
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
