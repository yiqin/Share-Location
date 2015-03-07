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

typedef NS_ENUM(NSUInteger, MSPaneViewControllerType) {
    MSPaneViewControllerTypeStylers,
    MSPaneViewControllerTypeDynamics,
    MSPaneViewControllerTypeBounce,
    MSPaneViewControllerTypeGestures,
    MSPaneViewControllerTypeControls,
    MSPaneViewControllerTypeMap,
    MSPaneViewControllerTypeEditableTable,
    MSPaneViewControllerTypeLongTable,
    MSPaneViewControllerTypeMonospace,
    MSPaneViewControllerTypeCount
};

@interface LeftViewController : UIViewController

@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

- (void)transitionToViewController:(MSPaneViewControllerType)paneViewControllerType;

@end
