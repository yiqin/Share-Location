//
//  RequestUserPathDataManager.h
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface RequestUserPathDataManager : NSObject

+(id)sharedManager;

- (void)loadLeadingDataWithUserObjectId:(NSString *)objectId
                                success:(void (^)(NSArray *array, NSError *error))successCompletion
                                failure:(void (^)(void))failureCompletion;

@end
