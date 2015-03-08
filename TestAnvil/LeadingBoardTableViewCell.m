//
//  LeadingBoardTableViewCell.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "LeadingBoardTableViewCell.h"
#import <Colours.h>

@implementation LeadingBoardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat xPadding = 14.0;
        CGFloat yPadding = 14.0;
        CGFloat imageSize = 40.0;
        
        _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPadding, yPadding, imageSize, imageSize)];
        _profileImageView.contentMode = UIViewContentModeScaleAspectFill;
        _profileImageView.layer.cornerRadius = imageSize*0.5;
        _profileImageView.backgroundColor = [UIColor redColor];
        _profileImageView.clipsToBounds = YES;
        [self addSubview:_profileImageView];
        
        _screenNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_profileImageView.frame)+xPadding, yPadding, 200, 21)];
        _screenNameLabel.font = [UIFont fontWithName:@"Lato-Regular" size:17];
        [self addSubview:_screenNameLabel];
        
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_profileImageView.frame)+xPadding, CGRectGetMaxY(_screenNameLabel.frame), 200, 21)];
        _scoreLabel.font = [UIFont fontWithName:@"Lato-Regular" size:15];
        _scoreLabel.textColor = [UIColor colorFromHexString:@"4d4d4d"];
        [self addSubview:_scoreLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)cellHeight {
    return 68;
}

@end
