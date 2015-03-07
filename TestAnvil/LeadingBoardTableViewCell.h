//
//  LeadingBoardTableViewCell.h
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "TestAnvilTableViewCell.h"

@interface LeadingBoardTableViewCell : TestAnvilTableViewCell

@property(nonatomic, strong) UILabel *screenNameLabel;
@property(nonatomic, strong) UIImageView *profileImageView;

+ (CGFloat)cellHeight;

@end
