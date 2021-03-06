//
//  LeftViewController.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "LeftViewController.h"
#import <TestAnvil-Swift.h>

#import "LeadingBoardTableViewCell.h"
#import "DistanceBoardTableViewCell.h"
#import "CityBoardTableViewCell.h"

#import "LeftDataManager.h"
#import "TestAnvilUser.h"

#import <JT3DScrollView.h>
#import "RequestUserPathDataManager.h"

@interface LeftViewController ()

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *leadingObjects;

@property(nonatomic, strong) JT3DScrollView *leadingBoardScrollView;

@property(nonatomic, strong) UIButton *cancelButton;

@end

@implementation LeftViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self.view addSubview:_tableView];
        
        _leadingObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[LeftDataManager sharedManager] loadLeadingDataWithSuccess:^(NSArray *array, NSError *error) {
        @synchronized(self.leadingObjects){
            [self.leadingObjects addObjectsFromArray:array];
            
            NSLog(@"reload tableView");
            [self.tableView reloadData];
        }
        
    } failure:^{
        
    }];
    
    
    CGFloat topPadding = 44;
    CGFloat bottomPadding = 74;
    CGFloat xPadding = 20;
    
    self.leadingBoardScrollView = [[JT3DScrollView alloc] initWithFrame:CGRectMake(xPadding, topPadding, CGRectGetWidth(self.view.frame)-2*xPadding, CGRectGetHeight(self.view.frame)-topPadding-bottomPadding)];
    self.leadingBoardScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // self.leadingBoardScrollView.backgroundColor = [UIColor blackColor];
    self.leadingBoardScrollView.delegate = self;
    self.leadingBoardScrollView.effect = JT3DScrollViewEffectDepth;
    
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancelButton.frame = CGRectMake(xPadding, CGRectGetHeight(self.view.frame)-bottomPadding+10, CGRectGetWidth(self.view.frame)-2*xPadding, bottomPadding-20);
    self.cancelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.cancelButton addTarget:self action:@selector(pressedCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setBackgroundColor:[UIColor colorFromHexString:@"f0f0f0"]];
    self.cancelButton.layer.cornerRadius = 8;
    self.cancelButton.titleLabel.font=[UIFont fontWithName:@"OpenSans-Regular" size:17.0];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressedRequest:) name:@"dismissLeadingBoardScrollView" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.leadingObjects.count;
            break;
        case 1:
            return 5;
        default:
            return 3;
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [LeadingBoardTableViewCell cellHeight];
    }
    else if (indexPath.section == 1){
        return [DistanceBoardTableViewCell cellHeight];
    }
    else {
        return [CityBoardTableViewCell cellHeight];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 64)];
    tempView.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:0.9];
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, CGRectGetWidth(tempView.frame), 44)];
    tempLabel.text = @"Standings";
    tempLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:17.0];
    // tempLabel.textColor = [UIColor colorFromHexString:@"4d4d4d"];
    
    
    [tempView addSubview:tempLabel];
    return tempView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString *CellIdentifier = @"LeadingBoardCell";
        
        LeadingBoardTableViewCell *cell = (LeadingBoardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[LeadingBoardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        TestAnvilUser *user = [self.leadingObjects objectAtIndex:indexPath.row];
        
        if (user.profileImage.isDownloaded) {
            cell.profileImageView.image = user.profileImage.image;
        }
        else {
            cell.profileImageView.image = nil;
            [self downloadImageAndReloadCell:indexPath];
        }
        cell.screenNameLabel.text = user.screenName;
        cell.scoreLabel.text = user.rateString;
        
        // cell.textLabel.text = user.screenName;
        return cell;
    }
    else if (indexPath.section == 1) {
        NSString *CellIdentifier = @"DistanceBoardCell";
        
        DistanceBoardTableViewCell *cell = (DistanceBoardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[DistanceBoardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = @"DistanceBoard";
        return cell;
    }
    else {
        NSString *CellIdentifier = @"CityBoardBoardCell";
        
        CityBoardTableViewCell *cell = (CityBoardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[CityBoardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = @"City";
        return cell;
    }
}

- (void)downloadImageAndReloadCell:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TestAnvilUser *user = [self.leadingObjects objectAtIndex:indexPath.row];
        [user.profileImage loadImageWithSuccess:^(UIImage *image, NSError *error) {
            NSLog(@"load image here.");
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } failure:^{
            
        }];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // [self.delegate showLeadingBoardScrollView: indexPath.row];
    
    NSArray *viewsToRemove = [self.leadingBoardScrollView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    NSArray *tempArray = [[LeftDataManager sharedManager] getLeadingObjects];
    for (TestAnvilUser *user in tempArray) {
        [self createCardWithColor:user];
    }
    
    CGFloat width = CGRectGetWidth(self.leadingBoardScrollView.frame);
    [self.leadingBoardScrollView setContentOffset:CGPointMake(width*indexPath.row,0) animated:NO];
    [self showLeadingBoardScrollView];
}

- (void)showLeadingBoardScrollView {
    [self.leadingBoardScrollView setAlpha:0.0];
    [self.cancelButton setAlpha:0.0];
    [[[UIApplication sharedApplication] delegate].window addSubview:self.leadingBoardScrollView];
    [[[UIApplication sharedApplication] delegate].window addSubview:self.cancelButton];
    
    
    [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.leadingBoardScrollView setAlpha:1.f];
        [self.cancelButton setAlpha:1.f];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)createCardWithColor:(TestAnvilUser*)user
{
    CGFloat width = CGRectGetWidth(self.leadingBoardScrollView.frame);
    CGFloat height = CGRectGetHeight(self.leadingBoardScrollView.frame);
    
    CGFloat x = self.leadingBoardScrollView.subviews.count * width;
    
    ProfileCardView *view = [[ProfileCardView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    [view setupUser:user];
    [self.leadingBoardScrollView addSubview:view];
    self.leadingBoardScrollView.contentSize = CGSizeMake(x + width, height);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}


- (void)pressedRequest:(NSNotification *)notification {

    // NSDictionary *userInfo = notification.userInfo;
    // [RequestUserPathDataManager sharedManager]
    
    [self.leadingBoardScrollView removeFromSuperview];
    [self.cancelButton removeFromSuperview];
    
}

- (void)pressedCancel {
    
    [self.leadingBoardScrollView setAlpha:1.0];
    [self.cancelButton setAlpha:1.0];
    
    [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.leadingBoardScrollView setAlpha:.0f];
        [self.cancelButton setAlpha:.0f];
    } completion:^(BOOL finished) {
        [self.leadingBoardScrollView removeFromSuperview];
        [self.cancelButton removeFromSuperview];
    }];
}


@end
