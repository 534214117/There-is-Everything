//
//  ParticularlyTableViewCell.h
//  ThereIsEverything
//
//  Created by Sonia on 2017/12/28.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ParticularlyModel.h"
#import "HexagonView.h"

@interface ParticularlyTableViewCell : UITableViewCell

@property (nonatomic, strong) ParticularlyModel *model;
@property (nonatomic, strong) HexagonView *hexagonView;

@end
