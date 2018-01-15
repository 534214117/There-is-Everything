//
//  UIImage+UIImageMore.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/11.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "UIImage+UIImageMore.h"
#import <objc/message.h>

@implementation UIImage (UIImageMore)

+ (void)load {
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method dz_imageNamedMethod = class_getClassMethod(self, @selector(dz_imageNamed:));

    method_exchangeImplementations(imageNamedMethod, dz_imageNamedMethod);
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [UIImage classMethodSwizzlingWithOriginalSelector:@selector(imageNamed:) bySwizzledSelector:@selector(dz_imageNamed:)];
//    });
    
}


+ (UIImage *)dz_imageNamed:(NSString *)name {
    UIImage *image = [UIImage dz_imageNamed:name];
    if (image) {
        NSLog(@"runtime添加额外功能--加载成功");
    } else {
        NSLog(@"runtime添加额外功能--加载失败");
    }
    return image;
}

@end
