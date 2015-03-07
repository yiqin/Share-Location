//
//  TestAnvilImage.h
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface TestAnvilImage : NSObject

-(instancetype)initWithPFFile:(PFFile *)imageFile;
-(void)loadImage;
-(void)loadImageWithSuccess:(void (^)(UIImage *image, NSError *error))successCompletion
                    failure:(void (^)(void))failureCompletion;

@property(nonatomic, strong) NSString *fileUrl;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic) BOOL isDownloaded;

@end
