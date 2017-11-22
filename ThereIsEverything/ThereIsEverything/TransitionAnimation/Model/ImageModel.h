//
//  ImageModel.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/15.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

//为了用户体验，异步加载网络图片，我们公司讨论结果是后台存储好图片宽高，与json数据一起返回，这样用户体验比较好
@property (nonatomic, readonly) CGFloat imageWidth;
@property (nonatomic, readonly) CGFloat imageHeight;


@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *imageContent;

- (instancetype)initWithImageUrl:(NSString *)imageUrl imageContent:(NSString *)imageContent imageWidth:(CGFloat)imageWidth imageHeigh:(CGFloat)imageHeight;

@end
