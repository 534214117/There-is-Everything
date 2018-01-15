//
//  NSObject+Swizzling.h
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/11.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)instanceMethodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;
+ (void)classMethodSwizzlingWithOriginalSelector:(SEL)originalSelector bySwizzledSelector:(SEL)swizzledSelector;

@end
