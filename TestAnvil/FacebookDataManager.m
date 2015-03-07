//
//  FacebookDataManager.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "FacebookDataManager.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <AFNetworking.h>

@implementation FacebookDataManager

+ (void)loadData {
    // If the user is already logged in, display any previously cached values before we get the latest from Facebook.
    
    // Send request to Facebook
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            
            NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
            
            if (facebookID) {
                userProfile[@"facebookId"] = facebookID;
            }
            
            NSString *name = userData[@"name"];
            if (name) {
                userProfile[@"name"] = name;
            }
            
            NSString *location = userData[@"location"][@"name"];
            if (location) {
                userProfile[@"location"] = location;
            }
            
            NSString *gender = userData[@"gender"];
            if (gender) {
                userProfile[@"gender"] = gender;
            }
            
            NSString *birthday = userData[@"birthday"];
            if (birthday) {
                userProfile[@"birthday"] = birthday;
            }
            
            NSString *relationshipStatus = userData[@"relationship_status"];
            if (relationshipStatus) {
                userProfile[@"relationship"] = relationshipStatus;
            }
            
            NSString *pictureURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID];
            userProfile[@"pictureURL"] = pictureURL;
            
            [FacebookDataManager postDataToOurParseBackendWithScreenName:name profileUrl:pictureURL userProfile:userProfile];
            
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
}


+ (void)postDataToOurParseBackendWithScreenName:(NSString *)screenName profileUrl:(NSString *)profileUrl userProfile:(NSDictionary *)userProfile {
    
    NSURL *url = [NSURL URLWithString:profileUrl];
    NSURLRequest *urlRquest  = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRquest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *imageData = UIImagePNGRepresentation(responseObject);
        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
        
        [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
        [PFUser currentUser][@"screenName"] = screenName;
        [PFUser currentUser][@"profileImage"] = imageFile;
        
        [[PFUser currentUser] saveInBackground];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error");
        
    }];
    [requestOperation start];
}

@end
