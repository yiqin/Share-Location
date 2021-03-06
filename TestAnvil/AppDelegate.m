//
//  AppDelegate.m
//  TestAnvil
//
//  Created by Yi Qin on 3/6/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <Colours.h>
#import <TestAnvil-Swift.h>

#import "MSDynamicsDrawerViewController.h"
#import "MSDynamicsDrawerStyler.h"

#import "MainNavigationController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

#import "LeftDataManager.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>

#import "QTouchposeApplication.h"


@interface AppDelegate () <MSDynamicsDrawerViewControllerDelegate>

@property (nonatomic, strong) UIImageView *windowBackground;
@property (nonatomic, strong) MainViewController *mainViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    QTouchposeApplication *touchposeApplication = (QTouchposeApplication *)application;
    touchposeApplication.alwaysShowTouches = NO;
#ifdef DEBUG
    touchposeApplication.alwaysShowTouches = YES;
#endif
    
    touchposeApplication.touchColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1];
    touchposeApplication.touchEndAnimationDuration = 0.3f;
    touchposeApplication.touchEndTransform = CATransform3DMakeScale(0.5, 0.5, 1);
    
    
    
    // Setting the navigation bar style
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorFromHexString:@"f0f0f0"]];
    // [[UITabBar appearance] setTintColor:[UIColor colorFromHexString:@"3d5fc4"]];
    // White or black
    // [UIColor colorFromHexString:@"4d4d4d"]
    [[UINavigationBar appearance] setTintColor:[UIColor colorFromHexString:@"4d4d4d"]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorFromHexString:@"4d4d4d"], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"OpenSans-Semibold" size:17.0],NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    // Parse.com
    [Parse setApplicationId:@"205P4oUq3V0ZwBkD7U12KP0WsHCX6Ev6Ijhab274"
                  clientKey:@"gKXhLghjgmQCzYoKdlZcOD5fQX8Qo5j6mGkIraTQ"];
    [PFFacebookUtils initializeFacebook];
    
    /*
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        
    } else {
        // show the signup or login screen
        [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
            if (error) {
                NSLog(@"Anonymous login failed.");
            } else {
                NSLog(@"Anonymous user logged in.");
                
            }
        }];
    }
    */
    
    
    [[TestAnvilLocationManager sharedInstance] startLocationManager];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedRequestToShowOtherUserPath:) name:@"dismissLeadingBoardScrollView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openLeftViewController:) name:@"openLeftViewController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openRightViewController:) name:@"openRightViewController" object:nil];

    
    return YES;
}

- (void)setupMainViewController {
    
    self.dynamicsDrawerViewController = [[MSDynamicsDrawerViewController alloc] initWithNibName:nil bundle:nil];
    self.dynamicsDrawerViewController.delegate = self;
    self.dynamicsDrawerViewController.gravityMagnitude = 10.0;
    self.dynamicsDrawerViewController.elasticity = 0.2;
    
    // Style settings
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerScaleStyler styler], [MSDynamicsDrawerFadeStyler styler]] forDirection:MSDynamicsDrawerDirectionLeft];
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerScaleStyler styler], [MSDynamicsDrawerFadeStyler styler]] forDirection:MSDynamicsDrawerDirectionRight];
    
    
    self.mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    
    MainNavigationController *mainNavigationController = [[MainNavigationController alloc] initWithRootViewController:self.mainViewController];
    
    self.dynamicsDrawerViewController.paneViewController = mainNavigationController;
    
    
    
    
    LeftViewController *leftViewController = [[LeftViewController alloc] initWithNibName:nil bundle:nil];
    [self.dynamicsDrawerViewController setDrawerViewController:leftViewController forDirection:MSDynamicsDrawerDirectionLeft];
    leftViewController.delegate = self.mainViewController;
    
    RightViewController *rightViewController = [[RightViewController alloc] initWithNibName:nil bundle:nil];
    [self.dynamicsDrawerViewController setDrawerViewController:rightViewController forDirection:MSDynamicsDrawerDirectionRight];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.dynamicsDrawerViewController;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor yellowColor];
    [self.window addSubview:self.windowBackground];
    [self.window sendSubviewToBack:self.windowBackground];
}

- (UIImageView *)windowBackground
{
    if (!_windowBackground) {
        _windowBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Window Background"]];
        CGFloat tempWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat tempHeight = [UIScreen mainScreen].bounds.size.height;
        _windowBackground.frame = CGRectMake(0, 0, tempWidth, tempHeight);
        _windowBackground.contentMode =UIViewContentModeScaleAspectFill;
    }
    return _windowBackground;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
    [self setupMainViewController];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "info.yiqin.TestAnvil" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TestAnvil" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TestAnvil.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


- (NSString *)descriptionForPaneState:(MSDynamicsDrawerPaneState)paneState
{
    switch (paneState) {
        case MSDynamicsDrawerPaneStateOpen:
            return @"MSDynamicsDrawerPaneStateOpen";
        case MSDynamicsDrawerPaneStateClosed:
            return @"MSDynamicsDrawerPaneStateClosed";
        case MSDynamicsDrawerPaneStateOpenWide:
            return @"MSDynamicsDrawerPaneStateOpenWide";
        default:
            return nil;
    }
}

- (NSString *)descriptionForDirection:(MSDynamicsDrawerDirection)direction
{
    switch (direction) {
        case MSDynamicsDrawerDirectionTop:
            return @"MSDynamicsDrawerDirectionTop";
        case MSDynamicsDrawerDirectionLeft:
            return @"MSDynamicsDrawerDirectionLeft";
        case MSDynamicsDrawerDirectionBottom:
            return @"MSDynamicsDrawerDirectionBottom";
        case MSDynamicsDrawerDirectionRight:
            return @"MSDynamicsDrawerDirectionRight";
        default:
            return nil;
    }
}

#pragma mark - MSDynamicsDrawerViewControllerDelegate

- (void)dynamicsDrawerViewController:(MSDynamicsDrawerViewController *)drawerViewController mayUpdateToPaneState:(MSDynamicsDrawerPaneState)paneState forDirection:(MSDynamicsDrawerDirection)direction
{
    NSLog(@"Drawer view controller may update to state `%@` for direction `%@`", [self descriptionForPaneState:paneState], [self descriptionForDirection:direction]);
}

- (void)dynamicsDrawerViewController:(MSDynamicsDrawerViewController *)drawerViewController didUpdateToPaneState:(MSDynamicsDrawerPaneState)paneState forDirection:(MSDynamicsDrawerDirection)direction
{
    NSLog(@"Drawer view controller did update to state `%@` for direction `%@`", [self descriptionForPaneState:paneState], [self descriptionForDirection:direction]);
}


- (void)receivedRequestToShowOtherUserPath:(NSNotification*)notification {
    
    
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *objectId = [userInfo objectForKey:@"message"];
    [[RequestUserPathDataManager sharedManager] loadLeadingDataWithUserObjectId:objectId success:^(NSArray *array, NSError *error) {
        
        if (array.count > 1) {
            
        }
        else {
            return;
        }
        
		for (CLLocation* loc in array){
			NSLog(@" Looc : %@ ", loc);
		}
		((AppDelegate*) [[UIApplication sharedApplication] delegate]).locationData = [array copy];
        [self.mainViewController updateUserPathDataArray:array];
        
        
        // array  - CLLocation-s
		[self.mainViewController presentViewController:[[LocationPeekViewController alloc]init] animated:YES completion:nil];
		
        
    } failure:^{
        
    }];
    
    
}

- (void)openLeftViewController:(NSNotification*)notification {
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionLeft animated:YES allowUserInterruption:YES completion:^{
        
    }];
    
}

- (void)openRightViewController:(NSNotification*)notification {
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionRight animated:YES allowUserInterruption:YES completion:^{
        
    }];
    
}


@end
