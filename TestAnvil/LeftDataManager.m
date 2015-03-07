//
//  LeftDataManager.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "LeftDataManager.h"
#import <TestAnvil-Swift.h>
#import "TestAnvilUser.h"

@interface LeftDataManager ()

@property(nonatomic) int leadingCount;
@property(nonatomic) int distanceCount;
@property(nonatomic) int cityCount;

@property(nonatomic, strong) NSMutableArray *leadingObjects;
@property(nonatomic, strong) NSMutableArray *distanceObjects;
@property(nonatomic, strong) NSMutableArray *cityObjects;

@end

@implementation LeftDataManager


+(id)sharedManager {
    static LeftDataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _leadingCount = 6;
        _distanceCount = 3;
        _cityCount = 10;
        
        _leadingObjects = [[NSMutableArray alloc] init];
        _distanceObjects = [[NSMutableArray alloc] init];
        _cityObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadLeadingDataWithSuccess:(void (^)(NSArray *array, NSError *error))successCompletion
                           failure:(void (^)(void))failureCompletion {
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    query.limit = self.leadingCount;
    [query addDescendingOrder:@"moneyTotal"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"success    %lu", (unsigned long)objects.count);
            
            @synchronized(self.leadingObjects){
                self.leadingObjects = [[NSMutableArray alloc] init];
                for (PFObject *object in objects) {
                    TestAnvilUser *testAnvilUser = [[TestAnvilUser alloc] initWithParseObject:object];
                    [self.leadingObjects addObject:testAnvilUser];
                }
                successCompletion([self.leadingObjects copy], nil);
            }
        }
        else {
            failureCompletion();
        }
    }];
    
    
}

- (void)loadDistanceDataWithCurrentGeoPoint:(PFGeoPoint *)currentGeoPoint
                                    success:(void (^)(NSArray *array, NSError *error))successCompletion
                                    failure:(void (^)(void))failureCompletion {
    
}

- (void)loadCityDataWithName:(NSString *)cityName
                     success:(void (^)(NSArray *array, NSError *error))successCompletion
                     failure:(void (^)(void))failureCompletion {
    
}


- (NSArray *) getLeadingObjects {
    return [self.leadingObjects copy];
}

- (NSArray *) getDistanceObjects {
    return [self.distanceObjects copy];
}

- (NSArray *) getCityObjects {
    return [self.cityObjects copy];
}

@end
