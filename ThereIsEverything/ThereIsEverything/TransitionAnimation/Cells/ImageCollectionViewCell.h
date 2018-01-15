//
//  ImageCollectionViewCell.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/15.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@interface ImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ImageModel *model;

@end
