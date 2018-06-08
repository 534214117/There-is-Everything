//
//  CalendarCollectionViewCell.m
//  ThereIsEverything
//
//  Created by Sonia on 2018/1/16.
//  Copyright © 2018年 Mine. All rights reserved.
//

#import "CalendarCollectionViewCell.h"

@implementation CalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        self.calendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.calendarLabel.textAlignment = NSTextAlignmentCenter;
        self.calendarLabel.textColor = HEXColor(0x818181);
        self.calendarLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
        self.calendarLabel.text = [NSString stringWithFormat:@"%d", arc4random()%30];
        [self addSubview:self.calendarLabel];
        
    }
    return self;
}

@end
