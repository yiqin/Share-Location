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
    [query whereKey:@"user" equalTo:objectId];
    [query addAscendingOrder:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"success    %lu", (unsigned long)objects.count);
            
            @synchronized(self.objects){
//                self.leadingObjects = [[NSMutableArray alloc] init];
//                for (PFObject *object in objects) {
//                    TestAnvilUser *testAnvilUser = [[TestAnvilUser alloc] initWithParseObject:object];
//                    [self.leadingObjects addObject:testAnvilUser];
//                }
//                successCompletion([self.leadingObjects copy], nil);
            }
        }
        else {
            failureCompletion();
        }
    }];
}


@end
