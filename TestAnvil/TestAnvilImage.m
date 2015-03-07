//
//  TestAnvilImage.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "TestAnvilImage.h"
#import "AFNetworking.h"

@implementation TestAnvilImage

-(instancetype)initWithPFFile:(PFFile *)imageFile {
    self = [super init];
    if (self) {
        _fileUrl = imageFile.url;
        _image = [[UIImage alloc] init];
        _isDownloaded = NO;
    }
    return self;
}

-(void)loadImage {
    [self loadImageWithSuccess:^(UIImage *image, NSError *error) {
        
    } failure:^{
        
    }];
}

-(void)loadImageWithSuccess:(void (^)(UIImage *image, NSError *error))successCompletion
                    failure:(void (^)(void))failureCompletion {
    
    NSURL *url = [NSURL URLWithString:self.fileUrl];
    NSURLRequest *urlRquest  = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRquest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.image = responseObject;
        self.isDownloaded = YES;
        successCompletion(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error");
        failureCompletion();
        
    }];
    [requestOperation start];
    
}


@end
