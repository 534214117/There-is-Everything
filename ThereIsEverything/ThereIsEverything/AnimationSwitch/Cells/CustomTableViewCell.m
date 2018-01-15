//
//  CustomTableViewCell.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/21.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "CustomTableViewCell.h"


#define CellHeight (KSCreenHeight-K_StatusBarAndNavigationBarHeight)/2.f

#define ItemHeight (KSCreenHeight-K_StatusBarAndNavigationBarHeight)/12.f

@interface CustomTableViewCell () <SwitchAnimateDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *txtLabel;
@property (nonatomic, strong) UIImageView *contactImageView;


@end


@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ItemHeight, KSCreenWidth, ItemHeight)];
        self.titleLabel.textColor = RGB(36, 173, 251);
        self.titleLabel.font = [UIFont systemFontOfSize:25];
        self.titleLabel.text = @"Connect Contacts";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, ItemHeight*2, KSCreenWidth-80, ItemHeight)];
        self.txtLabel.textColor = [UIColor blackColor];
        self.txtLabel.font = [UIFont systemFontOfSize:16];
        self.txtLabel.text = @"All your phone Contacts will be automatically added to your friends list";
        self.txtLabel.numberOfLines = 2;
        self.txtLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.txtLabel];
        
        self.contactImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unselect_contact"]];
        self.contactImageView.frame = CGRectMake(60, CellHeight/2.f + 30, (KSCreenWidth-180)/2.f, 60);
        self.contactImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.contactImageView];
        
        self.animationSwitch = [[AnimationSwitch alloc] initWithFrame:CGRectMake(KSCreenWidth/2.f+30+15, CellHeight/2.f + 30, (KSCreenWidth-180)/2.f, 30)];
        self.animationSwitch.switchDelegate = self;
        
        self.animationSwitch.layer.borderColor = [UIColor whiteColor].CGColor;
        self.animationSwitch.layer.cornerRadius = 15;
        self.animationSwitch.layer.borderWidth = 1;
        [self addSubview:self.animationSwitch];
    }
    return self;
    
}

- (void)willBeginAnimte {
    self.titleLabel.textColor = [UIColor whiteColor];
}

- (void)willEndAnimte {
    self.titleLabel.textColor = RGB(36, 173, 251);
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
