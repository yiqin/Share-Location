//
//  TestAnvilUser.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "TestAnvilUser.h"

@implementation TestAnvilUser
static int myUserInt = -1;

-(instancetype)initWithParseObject:(PFObject *)object {
    self = [super init];
    if (self) {
        _objectId = object.objectId;
        _screenName = [object objectForKey:@"screenName"];
        PFFile *tempPFFile = [object objectForKey:@"profileImage"];
        _profileImage = [[TestAnvilImage alloc] initWithPFFile:tempPFFile];
        if (myUserInt < 7) {
            [_profileImage loadImage];
            myUserInt++;
        }
        
        _pFUser = object;
        
        _moneyTotal = [object objectForKey:@"moneyTotal"];
        double tempDoubleValue = _moneyTotal.doubleValue;
        _moneyTotalString = [NSString stringWithFormat:@"Money Received: $%.2f", tempDoubleValue];
        
        _rate = [object objectForKey:@"rate"];
        double empDoubRate = _rate.doubleValue;
        _rateString = [NSString stringWithFormat:@"Peek Rate: $%.2f", empDoubRate];
        _raterateString = [NSString stringWithFormat:@"%.2f", empDoubRate];
        
        _lookups = [object objectForKey:@"lookups"];
        double doubleLookups = _lookups.doubleValue;
        _lookupsString = [NSString stringWithFormat:@"Total Lookups: %.0f", doubleLookups];
        
    }
    return self;
}

@end
