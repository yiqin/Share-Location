//
//  LeftDataManager.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "LeftDataManager.h"
#import "PFGeoPoint.h"

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
        _leadingCount = 3;
        _distanceCount = 3;
        _cityCount = 10;
        
        _leadingObjects = [[NSMutableArray alloc] init];
        _distanceObjects = [[NSMutableArray alloc] init];
        _cityObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)LoadLeadingDataWithSuccess:(void (^)(NSArray *array, NSError *error))successCompletion
                           failure:(void (^)(void))failureCompletion {
    
}

- (void)LoadDistanceDataWithCurrentGeoPoint:(PFGeoPoint *)currentGeoPoint
                                    success:(void (^)(NSArray *array, NSError *error))successCompletion
                                    failure:(void (^)(void))failureCompletion {
    
}

- (void)LoadCityDataWithName:(NSString *)cityName
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
