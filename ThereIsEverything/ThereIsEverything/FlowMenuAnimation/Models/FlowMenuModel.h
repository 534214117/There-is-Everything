//
//  FlowMenuModel.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/22.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlowMenuModel : NSObject

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *menuButtonColor;
@property (nonatomic, strong) UIColor *menuColor;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *followersCount;
@property (nonatomic, strong) NSString *favoritesCount;
@property (nonatomic, strong) NSString *viewsCount;

@end
