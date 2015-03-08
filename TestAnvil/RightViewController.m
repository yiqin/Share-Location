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
#import <Parse/Parse.h>
#import <AFNetworking.h>
#import "RandomColorGenerator.h"

@interface RightViewController ()
@property (nonatomic, strong) UISegmentedControl *visibilityControl;
@property (nonatomic, strong) UILabel	*visibilityDescriptionLabel;

@property (nonatomic, strong) UIButton *privacyHelpButton;
@property (nonatomic, strong) UIButton *changeSettingButton;


@property (nonatomic) CGFloat profileBackgroundImageSize;
@property (nonatomic) CGFloat profileImageSize;
@property (nonatomic, strong) UIImageView* userProfileImageView;

@property (nonatomic, strong) UIView *tempView;

@property(nonatomic, strong) UILabel *screenNameLabel;


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
    
    
    
    self.visibilityControl =  [[UISegmentedControl alloc]initWithItems:@[@"Friends",@"Universal"]];
    self.visibilityControl.frame = CGRectMake(130, CGRectGetMinY(self.privacyHelpButton.frame)-30-60, CGRectGetWidth(self.view.frame)-140, 30);
    self.visibilityControl.selectedSegmentIndex = 0;
    [self.view addSubview: self.visibilityControl ];
    
    
    
    //make segment control
    self.visibilityDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, CGRectGetMinY(self.visibilityControl.frame)-30-5, 250, 30)];
    self.visibilityDescriptionLabel.text =  @"Who can see your location?";
    self.visibilityDescriptionLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:15.0];
    self.visibilityDescriptionLabel.textColor = [UIColor colorFromHexString:@"4d4d4d"];
    self.visibilityDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.visibilityDescriptionLabel];
    
    
    self.profileBackgroundImageSize = 140;
    self.profileImageSize = 134;
    
    CGFloat tempUserPostionX = ((CGRectGetWidth(self.view.frame)-120)-self.profileImageSize)*0.5+120;
    self.userProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(tempUserPostionX, 64, self.profileImageSize, self.profileImageSize)];
    // self.userProfileImageView.backgroundColor = [UIColor lightGrayColor];
    self.userProfileImageView.layer.cornerRadius = self.profileImageSize*0.5;
    self.userProfileImageView.clipsToBounds = true;
    self.userProfileImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.userProfileImageView];
    
    CGFloat tempUserPostionX2 = ((CGRectGetWidth(self.view.frame)-120)-self.profileBackgroundImageSize)*0.5+120;
    self.tempView = [[UIView alloc] initWithFrame:CGRectMake(tempUserPostionX2, CGRectGetMinY(self.userProfileImageView.frame)+(self.profileBackgroundImageSize-self.profileImageSize)*0.5, self.profileBackgroundImageSize, self.profileBackgroundImageSize)];
    self.tempView.center = self.userProfileImageView.center;
    // tempView.backgroundColor = [UIColor colorFromHexString:@"4d4d4d"];
    self.tempView.backgroundColor = [UIColor whiteColor];
    self.tempView.layer.cornerRadius = self.profileBackgroundImageSize*0.5;
    self.tempView.clipsToBounds = true;
    [self.view insertSubview:self.tempView belowSubview:self.userProfileImageView];
    
    
    self.screenNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, self.profileBackgroundImageSize+64+10, CGRectGetWidth(self.view.frame)-120, 33)];
    self.screenNameLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:20.0];
    self.screenNameLabel.textColor = [UIColor colorFromHexString:@"4d4d4d"];
    self.screenNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.screenNameLabel];
    
    
    [self loadCurrentUserProfile];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tempView.backgroundColor = [RandomColorGenerator getColor];
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

- (void)loadCurrentUserProfile {
    
    
    PFFile *file =  [PFUser currentUser][@"profileImage"];
    
    self.screenNameLabel.text = [PFUser currentUser][@"screenName"];

    
    NSURL *url = [NSURL URLWithString:file.url];
    NSURLRequest *urlRquest  = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRquest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.userProfileImageView.image = responseObject;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error");
        
    }];
    [requestOperation start];
    
}

@end
