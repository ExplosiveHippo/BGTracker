//
//  ViewLogVC.m
//  BGTracker
//
//  Created by Lance Laughlin on 5/9/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "ViewLogVC.h"
#import "Log.h"
#import "ViewLogDetailsVCViewController.h"

@interface ViewLogVC ()

@end

@implementation ViewLogVC

#define LOG_TITLE @"Log Title"
#define LOG_GAME_NAME @"Name"
#define LOG_PLAYERS @"Players"
#define LOG_NOTES @"Notes"

@synthesize logs,logDict;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    
    // Load the plist data into the dictionary
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //get path for documents directory
    NSString *documentsPath = [paths objectAtIndex:0];
    //get the path for Data.plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"logs.plist"];
    
    //check to see if Data.plist exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        
        plistPath = [[NSBundle mainBundle] pathForResource:@"logs" ofType:@"plist"];
        //NSLog(@"plistPath: %@",plistPath);
    }
    
    //read property list into a dictionary object
    logDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSLog(@"logDict: %@",logDict);
    
    if (!logDict) {
        
        NSLog(@"Error reading plist");
    }else{
        // NSLog(@"Loaded OKAY");
    }
    
    self.logs = [NSMutableArray array];

    
    [self loadData];

    
}



-(void)loadData{
    
    // Load in data from the logs.plist
 /*
    NSString *path = [[NSBundle mainBundle] pathForResource:@"logs" ofType:@"plist"];
    NSDictionary *tempDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
*/
    //changed the following line to match what you saved it as
  NSArray *tempArray = [[logDict objectForKey:@"Root" ] objectForKey:@"Logs"];
    
    NSLog(@"tempArray: %@",tempArray);
        
    
    for (id dict in tempArray) {
        //NSLog(@"dict=%@",dict);
        
        NSString *title = [dict objectForKey:LOG_TITLE];
        NSLog(@"title: %@",title);
        
        NSString *name = [dict objectForKey:LOG_GAME_NAME];
        NSLog(@"name: %@",name);
                          
        NSMutableArray *players = [[NSMutableArray alloc]init];
                          
        players = [dict objectForKey:LOG_PLAYERS];
        NSLog(@"player: %@",players);

        
        NSString *notes = [dict objectForKey:LOG_NOTES];
        NSLog(@"notes: %@",notes);
        
        
        // Create NMADRestaurant objects
        
        Log *l = [[Log alloc] initWithName:name players:players notes:notes logName:title];
        
        
        
        // add to  self.logs array
        [self.logs addObject:l];
        
        [self.tableView reloadData];

    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [logs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    //NSString *tempString = [logs objectAtIndex:indexPath.row];
    
    Log *l = [self.logs objectAtIndex:indexPath.row];
    
    cell.textLabel.text = l.logName;
    
   // cell.textLabel.text = tempString;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    
    
   // NSLog(@"%@",logs);

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Get log object that we clicked on
    
    Log *l = [self.logs objectAtIndex:indexPath.row];
    NSString *logName = l.logName;
    NSString *gameName = l.gameName;
    NSString *notes = l.notes;
    NSMutableArray *players = l.players;
    
    //Assign the data to the next VC
    ViewLogDetailsVCViewController *newDetailLogVC = [[ViewLogDetailsVCViewController alloc]init];
    newDetailLogVC.title = logName;
    newDetailLogVC.logName = logName;
    newDetailLogVC.gameName = gameName;
    newDetailLogVC.gameNotes = notes;
    newDetailLogVC.playersArray = players;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:newDetailLogVC animated:YES];
    
}

@end
