//
//  LeftViewController.h
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MSDynamicsDrawerViewController.h>
#import <MSDynamicsDrawerStyler.h>


@interface LeftViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

@end
