//
//  UILabel+UILabelMore.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/28.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UILabelMore)

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
