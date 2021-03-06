//
//  BGTrackerAppDelegate.m
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "BGTrackerAppDelegate.h"

@implementation BGTrackerAppDelegate

@synthesize window = _window, tabBarController, viewLogVC, createLogVC, favoritesVC, gamesTableVC;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    
        
    
    
    
    
    // create tab bar
    self.tabBarController = [[UITabBarController alloc] init];
    
    
    // create favorites
    self.favoritesVC = [[FavoritesVC alloc] initWithNibName:nil bundle:nil];
    self.favoritesVC.title = @"Favorites";
    
    UINavigationController *favoritesNavController = [[UINavigationController alloc] initWithRootViewController:favoritesVC];
    
    
    //create New Log
    
    self.createLogVC = [[NewLogVC alloc] initWithNibName:nil bundle:nil];
    self.createLogVC.title = @"New Log";
    
    UINavigationController *newLogVC = [[UINavigationController alloc]initWithRootViewController:createLogVC];
    
    //create view log
    self.viewLogVC = [[ViewLogVC alloc] initWithNibName:nil bundle:nil];
    self.viewLogVC.title = @"View Logs";
    
    //viewLogs nav controller
    UINavigationController *logsNavController = [[UINavigationController alloc] initWithRootViewController:viewLogVC];
    
    
    
    // Tab bar items
    UITabBarItem *favoritesItem = [[UITabBarItem alloc] initWithTitle:@"Favorites" image:[UIImage imageNamed:@"heart.png"] tag:0];
    UITabBarItem *createItem = [[UITabBarItem alloc] initWithTitle:@"New Log" image:[UIImage imageNamed:@"plus.png"] tag:0];
     UITabBarItem *viewItem = [[UITabBarItem alloc] initWithTitle:@"View Logs" image:[UIImage imageNamed:@"page_empty.png"] tag:0];
    

    // set tab bar items
    self.favoritesVC.tabBarItem = favoritesItem;
    self.createLogVC.tabBarItem = createItem;
    self.viewLogVC.tabBarItem = viewItem;
    
    
    // Creates our tab bar controller VCs
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:favoritesNavController, newLogVC, logsNavController, nil];
    
    //Add them to the view
    [self.window addSubview:self.tabBarController.view];    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
