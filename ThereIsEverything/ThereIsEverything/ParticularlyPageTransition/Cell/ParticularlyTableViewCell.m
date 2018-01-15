//
//  ParticularlyTableViewCell.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/28.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "ParticularlyTableViewCell.h"
#import "UILabel+UILabelMore.h"

#define CellHeight ((KSCreenHeight-K_StatusBarAndNavigationBarHeight)/3.)
#define ItemY CellHeight/4.
#define MarginTop (((KSCreenHeight-K_StatusBarAndNavigationBarHeight)/3.)/4.)

@interface ParticularlyTableViewCell ()

@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *subLabel;

@end


@implementation ParticularlyTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20+(CellHeight-MarginTop)/2., 0, 2, MarginTop/2.)];
        lineView1.backgroundColor = HEXColor(0x4dbce9);
        [self addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20+(CellHeight-MarginTop)/2., MarginTop/2+CellHeight-MarginTop, 2, MarginTop/2.)];
        lineView2.backgroundColor = HEXColor(0x4dbce9);
        [self addSubview:lineView2];
        
        self.hexagonView = [[HexagonView alloc] initWithFrame:CGRectMake(20, MarginTop/2., CellHeight-MarginTop, CellHeight-MarginTop)];
        self.hexagonView.maskImage = [UIImage imageNamed:@"hexagon1.png"];
        [self addSubview:self.hexagonView];
        
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hexagonView.frame)+20, ItemY, KSCreenWidth-(CGRectGetMaxX(self.hexagonView.frame)+40), ItemY)];
//        self.mainLabel.backgroundColor = [UIColor redColor];
        self.mainLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightThin];
        [self addSubview:self.mainLabel];
        
        self.subLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hexagonView.frame)+20, ItemY*2, KSCreenWidth-(CGRectGetMaxX(self.hexagonView.frame)+40), ItemY)];
        self.subLabel.font = [UIFont systemFontOfSize:16];
        self.subLabel.textColor = HEXColor(0xaeadb5);
        [self addSubview:self.subLabel];
        
        
        
    }
    return self;
}


- (void)setModel:(ParticularlyModel *)model {
    _model = model;
    self.hexagonView.maskBackgroundColor = HEXColor([model.hexColor intValue]);
    self.hexagonView.hexagonCenterImage = [UIImage imageNamed:model.centerImageUrl];
    self.mainLabel.text = model.title;
    self.subLabel.text = model.subTitle;
    
//    [UILabel changeWordSpaceForLabel:self.mainLabel WithSpace:3];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
