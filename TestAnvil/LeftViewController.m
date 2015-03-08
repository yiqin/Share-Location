//
//  LeftViewController.m
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "LeftViewController.h"
#import "LeadingBoardTableViewCell.h"
#import "DistanceBoardTableViewCell.h"
#import "CityBoardTableViewCell.h"

#import "LeftDataManager.h"
#import "TestAnvilUser.h"

@interface LeftViewController ()

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *leadingObjects;

@end

@implementation LeftViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor whiteColor];
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
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
    
    [self.delegate showLeadingBoardScrollView: indexPath.row];
    
    
}







@end
