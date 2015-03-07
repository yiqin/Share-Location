//
//  MainViewController.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "ObjectiveC_MainViewController.h"

#import <Colours.h>
#import <TTTAttributedLabel.h>

@interface ObjectiveC_MainViewController ()

@end

@implementation ObjectiveC_MainViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *fontFamilies = [UIFont familyNames];
    
    for (int i = 0; i < [fontFamilies count]; i++)
    {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
    
    
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    NSMutableAttributedString *tempText = [[NSMutableAttributedString alloc] initWithString:@"LOCASHION"];
    [tempText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0] range:NSMakeRange(0, tempText.length)];
    
    [tempText addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"f2c100"] range:NSMakeRange(4, tempText.length-5)];
    [tempText addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"00a0e9"] range:NSMakeRange(0, 3)];
    
    CGFloat tempWidth = [UIScreen mainScreen].bounds.size.width;
    
    TTTAttributedLabel *tempLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, tempWidth, 44)];
    tempLabel.attributedText = tempText;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = tempLabel;
}

@end
