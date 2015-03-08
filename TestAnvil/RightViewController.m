//
//  RightViewController.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()
@property (nonatomic, strong) UISegmentedControl *visibilityControl;
@property (nonatomic, strong) UILabel	*visibilityDescriptionLabel;

@end

@implementation RightViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
        
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
	self.visibilityControl.frame = CGRectMake(120, 150, 250, 30);
	[self.view addSubview: self.visibilityControl ];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
