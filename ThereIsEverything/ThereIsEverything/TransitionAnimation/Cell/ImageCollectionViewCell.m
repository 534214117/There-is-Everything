//
//  ImageCollectionViewCell.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/15.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@interface ImageCollectionViewCell ()


@end

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"imagePlaceholder.png"];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setModel:(ImageModel *)model {
    _model = model;
    
    _imageView.frame = self.bounds;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:model.imageUrl];
    
}

@end
