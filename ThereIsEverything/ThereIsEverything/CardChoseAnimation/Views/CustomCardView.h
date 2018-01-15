//
//  CustomCardView.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/4.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCardModel.h"

@interface CustomCardView : UIView

@property (nonatomic, strong) CustomCardView *nextView;
@property (nonatomic, strong) CustomCardModel *model;

- (instancetype)initWithFrame:(CGRect)frame delay:(NSTimeInterval)delay;

@end
