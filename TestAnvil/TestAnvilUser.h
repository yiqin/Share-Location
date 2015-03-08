//
//  TestAnvilUser.h
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "TestAnvilImage.h"

@interface TestAnvilUser : NSObject

-(instancetype)initWithParseObject:(PFObject *)object;

@property(nonatomic, strong) NSString *objectId;
@property(nonatomic, strong) PFObject *pFUser;
@property(nonatomic, strong) NSString *screenName;
@property(nonatomic, strong) TestAnvilImage *profileImage;

@property(nonatomic, strong) NSNumber *moneyTotal;
@property(nonatomic, strong) NSString *moneyTotalString;

@property(nonatomic, strong) NSNumber *rate;
@property(nonatomic, strong) NSString *rateString;

@property(nonatomic, strong) NSNumber *lookups;
@property(nonatomic, strong) NSString *lookupsString;

@end
