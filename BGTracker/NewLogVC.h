//
//  NewLogVC.h
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Log.h"
#import "BSKeyboardControls.h"
#import <QuartzCore/QuartzCore.h>

@interface NewLogVC : UIViewController<UITextFieldDelegate, UITextViewDelegate, BSKeyboardControlsDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *logTitle;
@property (strong, nonatomic) IBOutlet UILabel *gameLabel;
@property (strong, nonatomic) IBOutlet UITextField *playerName1;
@property (strong, nonatomic) IBOutlet UITextField *playerName2;
@property (strong, nonatomic) IBOutlet UITextField *playerName3;
@property (strong, nonatomic) IBOutlet UITextField *playerName4;
@property (strong, nonatomic) IBOutlet UITextField *playerName5;
@property (strong, nonatomic) IBOutlet UITextView *notes;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIButton *selectButton;

@property (strong, nonatomic) NSMutableArray *players;
@property (strong, nonatomic) NSString *myLogTitle;
@property (strong, nonatomic) NSString *gameName;
@property (strong, nonatomic) NSString *myNotes;

@property (strong, nonatomic) NSString *gamename;

@property(strong, nonatomic) Log *log;

@property (strong, nonatomic) BSKeyboardControls *keyboardControls;







-(IBAction)selectGame:(id)sender;

-(IBAction)submitLog:(id)sender;

-(void)saveLog;


@end
