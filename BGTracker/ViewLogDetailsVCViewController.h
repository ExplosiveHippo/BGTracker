//
//  ViewLogDetailsVCViewController.h
//  BGTracker
//
//  Created by Lance Laughlin on 5/11/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewLogDetailsVCViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *logLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameLabel;
@property (strong, nonatomic) IBOutlet UITextView *playersView;
@property (strong, nonatomic) IBOutlet UITextView *notes;

@property (strong, nonatomic) NSString *logName;
@property (strong, nonatomic) NSString *gameName;
@property (strong, nonatomic) NSMutableArray *playersArray;
@property (strong, nonatomic) NSString *gameNotes;

@end
