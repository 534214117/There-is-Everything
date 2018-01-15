//
//  VisionDisparityTableViewCell.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/13.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "VisionDisparityTableViewCell.h"

#define CellHeight 200
#define VisionDisparityValue 50


@interface VisionDisparityTableViewCell ()

@property (nonatomic, strong) UIImageView *backImageView;

@end


@implementation VisionDisparityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.clipsToBounds = YES;
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCreenWidth, CellHeight+VisionDisparityValue)];
        self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.backImageView];
        
    }
    return self;
}

- (void)setBackImage:(UIImage *)backImage {
    _backImage = backImage;
    self.backImageView.image = _backImage;
}

- (void)updateBackImageViewYForTableView:(UITableView *)tableView andView:(UIView *)view {
    // 1.cell在view坐标系上的frame
    CGRect frameOnView = [tableView convertRect:self.frame toView:view];
    // 2.cell 和 view 的中心距离差
    CGFloat distanceOfCenterY = CGRectGetHeight(view.frame) * 0.5 - CGRectGetMinY(frameOnView);
    // 3.cell 和 backImageView的高度差
    CGFloat distanceH = CGRectGetHeight(self.backImageView.frame) - CGRectGetHeight(self.frame);
    // 4.计算图片Y值偏移量
    CGFloat distanceWillMove = distanceOfCenterY / CGRectGetHeight(view.frame) * distanceH;
    
    // 5.更新图片的Y值
    CGRect backImageFrame = self.backImageView.frame;
    backImageFrame.origin.y = distanceWillMove - distanceH * 0.5;
    self.backImageView.frame = backImageFrame;
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
