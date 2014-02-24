//
//  GamesDetailVCViewController.m
//  BGTracker
//
//  Created by Lance Laughlin on 5/12/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "GamesDetailVCViewController.h"
#import "NewLogVC.h"
#import "FavoritesVC.h"

@interface GamesDetailVCViewController ()

@end

@implementation GamesDetailVCViewController

@synthesize gameName,gameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//Button to add the favorite
-(IBAction)addFavorites{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingPathComponent:@"favorites.plist"];
    NSDictionary *dict;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSString *oldPath = [[NSBundle mainBundle] pathForResource:@"favorites" ofType:@"plist"];
        dict = [NSDictionary dictionaryWithContentsOfFile: oldPath];
    } else {
        dict = [NSDictionary dictionaryWithContentsOfFile: path];
    }
    /*
     // Load our plist into a dictionary
     NSString *path = [[NSBundle mainBundle] pathForResource: @"logs" ofType: @"plist"];
     NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
     */
    
    //getting Previous Array.....
    NSMutableArray *prevArray = [[NSMutableArray alloc]init];
    //Get the logs within Logs parent dir
    prevArray = [[dict valueForKey:@"Root"]valueForKey:@"Favorites"];
    //    prevArray = [[dict valueForKey:@"Root"]valueForKey:@"Logs"];
    
    // Add new stuff to old stuff.....
    NSDictionary *newObject = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:gameName, nil] forKeys:[NSArray arrayWithObjects:@"name", nil]]; //2
    
    //New array holds our new log item and then adds all of our old items
    NSMutableArray *newArray = [[NSMutableArray alloc]init];
    [newArray addObject:newObject];
    for (int i=0;i<[prevArray count];i++){
        [newArray addObject:[prevArray objectAtIndex:i]];
    }
    
    //set all values for Plist......
    NSMutableDictionary *allItemsDict = [[NSMutableDictionary alloc]init];
    NSMutableArray *Logs = [[NSMutableArray alloc]initWithArray:newArray];
    [allItemsDict setObject:Logs forKey:@"Favorites"];
    
    NSMutableDictionary *Root = [[NSMutableDictionary alloc]init];
    [Root setObject:allItemsDict forKey:@"Root"];
    
    // Now, write to the plist:
    [Root writeToFile:path atomically:YES];

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Added to Favorites"
                                                    message:@"This game has been added to your favorites!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
}

// Button to add the log
-(IBAction)addLog{
    
    NewLogVC *newLogVC = [[NewLogVC alloc]init];
    newLogVC.title = @"New Log";
    newLogVC.gamename = gameName;
        
    [self.navigationController pushViewController:newLogVC animated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@",gameName);
    gameLabel.text = gameName;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
