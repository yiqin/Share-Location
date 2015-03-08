//
//  RightViewController.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "RightViewController.h"
#import <Colours.h>
#import "UIViewController+DBPrivacyHelper.h"

@interface RightViewController ()
@property (nonatomic, strong) UISegmentedControl *visibilityControl;
@property (nonatomic, strong) UILabel	*visibilityDescriptionLabel;

@property (nonatomic, strong) UIButton *privacyHelpButton;
@property (nonatomic, strong) UIButton *changeSettingButton;

@end

@implementation RightViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	//make segment control
	self.visibilityDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 250, 155)];
	self.visibilityDescriptionLabel.text =  @"Who can see your location?";
	[self.view addSubview:self.visibilityDescriptionLabel];
	self.visibilityControl =  [[UISegmentedControl alloc]initWithItems:@[@"Friends",@"Universal"]];
	self.visibilityControl.frame = CGRectMake(120, 120, 250, 30);
    self.visibilityControl.selectedSegmentIndex = 0;
	[self.view addSubview: self.visibilityControl ];

    
    self.privacyHelpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.privacyHelpButton.frame = CGRectMake(130, CGRectGetHeight(self.view.frame)-54-44-10, CGRectGetWidth(self.view.frame)-140, 44);
    self.privacyHelpButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.privacyHelpButton addTarget:self action:@selector(pressedChangeSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.privacyHelpButton setBackgroundColor:[UIColor colorFromHexString:@"f0f0f0"]];
    self.privacyHelpButton.layer.cornerRadius = 8;
    self.privacyHelpButton.titleLabel.font=[UIFont fontWithName:@"OpenSans-Regular" size:17.0];
    [self.privacyHelpButton setTitle:@"About Privacy" forState:UIControlStateNormal];
    
    [self.view addSubview:self.privacyHelpButton];

    
    self.changeSettingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.changeSettingButton.frame = CGRectMake(130, CGRectGetHeight(self.view.frame)-54, CGRectGetWidth(self.view.frame)-140, 44);
    self.changeSettingButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.changeSettingButton addTarget:self action:@selector(pressedPrivacyHelpButtonl) forControlEvents:UIControlEventTouchUpInside];
    [self.changeSettingButton setBackgroundColor:[UIColor colorFromHexString:@"f0f0f0"]];
    self.changeSettingButton.layer.cornerRadius = 8;
    self.changeSettingButton.titleLabel.font=[UIFont fontWithName:@"OpenSans-Regular" size:17.0];
    [self.changeSettingButton setTitle:@"Change Privacy" forState:UIControlStateNormal];
    
    [self.view addSubview:self.changeSettingButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pressedPrivacyHelpButtonl {
    [self showPrivacyHelperForType:DBPrivacyTypeLocation];
}

- (void)pressedChangeSetting {
    [self showPrivacyHelperForType:DBPrivacyTypeLocation controller:^(DBPrivateHelperController *vc) {
        //customize the view controller to present
    } didPresent:^{
        //customize the completion block of presentViewController:animated:completion:
    } didDismiss:^{
        //customize the completion block of dismissViewControllerAnimated:completion:
    } useDefaultSettingPane:NO]; //If NO force to use DBPrivateHelperController instead of the default settings pane on iOS 8. Only for iOS 8. Default value is YES.
}


@end
