//
//  TestAnvilUser.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "TestAnvilUser.h"

@implementation TestAnvilUser

-(instancetype)initWithParseObject:(PFObject *)object {
    self = [super init];
    if (self) {
        _objectId = object.objectId;
        _screenName = [object objectForKey:@"screenName"];
        PFFile *tempPFFile = [object objectForKey:@"profileImage"];
        _profileImage = [[TestAnvilImage alloc] initWithPFFile:tempPFFile];
        [_profileImage loadImage];
        _pFUser = object;
        
        _moneyTotal = [object objectForKey:@"moneyTotal"];
    }
    return self;
}

@end
