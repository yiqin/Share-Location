//
//  RequestUserPathDataManager.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "RequestUserPathDataManager.h"

@interface RequestUserPathDataManager()

@property(nonatomic, strong) NSMutableArray *objects;

@end

@implementation RequestUserPathDataManager

+(id)sharedManager {
    static RequestUserPathDataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _objects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadLeadingDataWithUserObjectId:(NSString *)objectId
                                success:(void (^)(NSArray *array, NSError *error))successCompletion
                                failure:(void (^)(void))failureCompletion {
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Location"];
    query.limit = 40;
    [query whereKey:@"userObjectId" equalTo:objectId];
    [query addDescendingOrder:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"success    %lu", (unsigned long)objects.count);
            
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            
            for (PFObject *object in objects) {
                CLLocation *location = [self parseFromPFObject:object];
                [temp addObject:location];
            }
            successCompletion([temp copy], nil);
            
        }
        else {
            failureCompletion();
        }
    }];
}

-(CLLocation *)parseFromPFObject:(PFObject *)object {
    
    PFGeoPoint *geoPoint = [object objectForKey:@"currentLocation"];
    double latitude = geoPoint.latitude;
    double longtitude = geoPoint.longitude;
    
    CLLocation *clLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
    
    return clLocation;
}


@end
