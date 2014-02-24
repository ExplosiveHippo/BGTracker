//
//  GamesDetailVCViewController.h
//  BGTracker
//
//  Created by Lance Laughlin on 5/12/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamesDetailVCViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *gameLabel;
@property (strong, nonatomic) NSString *gameName;

-(IBAction)addFavorites;
-(IBAction)addLog;

@end
