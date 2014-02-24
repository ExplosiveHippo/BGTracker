//
//  BGTrackerAppDelegate.h
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoritesVC.h"
#import "GamesTableVC.h"
#import "NewLogVC.h"
#import "ViewLogVC.h"


@class BGTrackerViewController;

@interface BGTrackerAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

//View controller ivars

@property(nonatomic,strong)GamesTableVC *gamesTableVC;
@property(nonatomic,strong)NewLogVC *createLogVC;
@property(nonatomic,strong)ViewLogVC *viewLogVC;
@property(nonatomic,strong)FavoritesVC *favoritesVC;

@end
