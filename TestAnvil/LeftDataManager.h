//
//  LeftDataManager.h
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface LeftDataManager : NSObject

+(id)sharedManager;

- (void)LoadLeadingDataWithSuccess:(void (^)(NSArray *array, NSError *error))successCompletion
                         failure:(void (^)(void))failureCompletion;

- (void)LoadDistanceDataWithCurrentGeoPoint:(PFGeoPoint *)currentGeoPoint
                                    success:(void (^)(NSArray *array, NSError *error))successCompletion
                                    failure:(void (^)(void))failureCompletion;

- (void)LoadCityDataWithName:(NSString *)cityName
                     success:(void (^)(NSArray *array, NSError *error))successCompletion
                     failure:(void (^)(void))failureCompletion;


- (NSArray *) getLeadingObjects;
- (NSArray *) getDistanceObjects;
- (NSArray *) getCityObjects;



@end
