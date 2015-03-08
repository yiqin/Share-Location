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

@protocol LeftViewControllerDelegate <NSObject>

-(void)showLeadingBoardScrollView:(NSInteger) index;

@end


@interface LeftViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak) id<LeftViewControllerDelegate> delegate;
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

@end
