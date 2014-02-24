//
//  ViewLogDetailsVCViewController.m
//  BGTracker
//
//  Created by Lance Laughlin on 5/11/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "ViewLogDetailsVCViewController.h"

@interface ViewLogDetailsVCViewController ()

@end

@implementation ViewLogDetailsVCViewController

@synthesize logLabel,playersView,notes,gameLabel,logName,gameName,gameNotes,playersArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.logLabel.text = logName;
    self.gameLabel.text = gameName;
    self.notes.text = gameNotes;
    
    //Just build a string holding in the player names with 2 line breaks in between
    NSString * combinedStuff = [playersArray componentsJoinedByString:@"\n\n"];
    
    self.playersView.text = combinedStuff;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
