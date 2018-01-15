//
//  CustomCardModel.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/4.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "CustomCardModel.h"

@implementation CustomCardModel

- (void)setAllCount:(NSString *)allCount {
    _allCount = [NSString stringWithFormat:@"/%@", allCount];
}

@end
