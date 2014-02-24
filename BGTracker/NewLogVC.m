//
//  NewLogVC.m
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "NewLogVC.h"
#import "GamesTableVC.h"
#import "ViewLogVC.h"


@interface NewLogVC ()

@end

@implementation NewLogVC

@synthesize logTitle,gameLabel,playerName1,playerName2,playerName3,playerName4,playerName5,notes,scrollView,players,log, gamename, myLogTitle, gameName, myNotes;

// Takes them to the tableView where they can search and select a game.
-(IBAction)selectGame:(id)sender{
    GamesTableVC *gamesVC = [[GamesTableVC alloc]initWithStyle:UITableViewStylePlain];
    gamesVC.title = @"Search Games";
    [self.navigationController pushViewController:gamesVC animated:YES];
    
}



-(IBAction)submitLog:(id)sender{
    
    myLogTitle = self.logTitle.text;

    gameName = self.gameLabel.text;
    myNotes = self.notes.text;
    
    //Create a players array to hold our strings
    players = [[NSMutableArray alloc]init];
    
    
    // This just checks to see if each field had something filled in. Only adds it's text value if it's not empty
    //Probably could have done this a better way.
    
    if([playerName1.text length] > 0){
        NSString *player1 = self.playerName1.text;
        [self.players addObject:player1];
    }
    if([playerName2.text length] > 0){
        NSString *player2 = self.playerName2.text;
        [self.players addObject:player2];
    }
    if([playerName3.text length] > 0){
        NSString *player3 = self.playerName3.text;
        [self.players addObject:player3];
    }
    if([playerName4.text length] > 0){
        NSString *player4 = self.playerName4.text;
        [self.players addObject:player4];
    }
    if([playerName5.text length] > 0){
        NSString *player5 = self.playerName5.text;
        [self.players addObject:player5];
    }
    
    
    if(gameName.length > 0){
        [self saveLog];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't Add Log"
                                                        message:@"Game name must have a value"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
}


-(void)saveLog{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingPathComponent:@"logs.plist"];
    NSDictionary *dict;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSString *oldPath = [[NSBundle mainBundle] pathForResource:@"logs" ofType:@"plist"];
        dict = [NSDictionary dictionaryWithContentsOfFile: oldPath];
    } else {
        dict = [NSDictionary dictionaryWithContentsOfFile: path];
    }
/*
    // Load our plist into a dictionary
    NSString *path = [[NSBundle mainBundle] pathForResource: @"logs" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
*/    
   // NSLog(@"dictbeforeAppending..%@",dict);
    
    //getting Previous Array.....
    NSMutableArray *prevArray = [[NSMutableArray alloc]init];
    //Get the logs within Logs parent dir
    prevArray = [[dict valueForKey:@"Root"]valueForKey:@"Logs"];
//    prevArray = [[dict valueForKey:@"Root"]valueForKey:@"Logs"];
   // NSLog(@"prevArray..%@",prevArray);
    
    // Add new stuff to old stuff.....
    NSDictionary *newObject = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:myLogTitle, gameName, players, myNotes, nil] forKeys:[NSArray arrayWithObjects:@"Log Title",@"Name",@"Players",@"Notes", nil]]; //2
    
    //New array holds our new log item and then adds all of our old items
    NSMutableArray *newArray = [[NSMutableArray alloc]init];
    [newArray addObject:newObject];
    for (int i=0;i<[prevArray count];i++){
        [newArray addObject:[prevArray objectAtIndex:i]];
    }
    
    //set all values for Plist......
    NSMutableDictionary *allItemsDict = [[NSMutableDictionary alloc]init];
    NSMutableArray *Logs = [[NSMutableArray alloc]initWithArray:newArray];
    [allItemsDict setObject:Logs forKey:@"Logs"];
    
    NSMutableDictionary *Root = [[NSMutableDictionary alloc]init];
    [Root setObject:allItemsDict forKey:@"Root"];
    
    // Now, write to the plist:
    [Root writeToFile:path atomically:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log Added"
                                                    message:@"Your game log has been created"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


// This stuff makes it so the scroll view isn't all messed up (The thing you helped me on)
-(void)viewWillAppear:(BOOL)animated {
    float total = self.logTitle.frame.size.height + self.gameLabel.frame.size.height + self.playerName1.frame.size.height + self.playerName2.frame.size.height + self.playerName3.frame.size.height + self.playerName4.frame.size.height + self.playerName5.frame.size.height + self.notes.frame.size.height + self.selectButton.frame.size.height + self.submitButton.frame.size.height;
    self.scrollView.contentSize= CGSizeMake(320, total+600);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the log title with the game name and date - will be default value for log title
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *newLogTitle = [[gamename stringByAppendingString:@" "] stringByAppendingString:[DateFormatter stringFromDate:[NSDate date]]];
    
    
    self.gameLabel.text = gamename;
    self.logTitle.text = newLogTitle;
    
    // Adds border to the notes textView
    self.notes.layer.borderWidth = 1.0f;
    self.notes.layer.borderColor = [[UIColor grayColor] CGColor];
    self.notes.layer.cornerRadius = 8;
    
    //For the BSKeyboardControls
    NSArray *fields = @[self.logTitle,
                        self.playerName1,self.playerName2,self.playerName3,self.playerName4, self.playerName5, self.notes];
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    
    
    // Do any additional setup after loading the view from its nib.
}



#pragma mark -
#pragma mark - BSKeyboarControls


///The functions are for the prev, next, done buttons on the bar above keyboard 

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [keyboardControls.activeField resignFirstResponder];
}

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
    
    CGRect rc = [keyboardControls.activeField bounds];
    rc = [keyboardControls.activeField convertRect:rc
                                            toView:self.scrollView];
    rc.origin.x = 0 ;
    rc.origin.y -= 50 ;
    rc.size.height = 450;

    [self.scrollView scrollRectToVisible:rc animated:YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.keyboardControls setActiveField:textView];
    [self animateTextView:textView up:YES];

}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextView:textView up:NO];
}


//Moves the view up when the notes textView is selected

// http://stackoverflow.com/questions/1126726/how-to-make-a-uitextfield-move-up-when-keyboard-is-present //
-(void)animateTextView:(UITextView*)textView up:(BOOL)up
{
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
