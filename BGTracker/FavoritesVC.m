//
//  FavoritesVC.m
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "FavoritesVC.h"


@interface FavoritesVC ()

@end

@implementation FavoritesVC

#define FAV_TITLE @"name"


@synthesize favorites,favDict;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    
    // Load the plist data into the dictionary
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //get path for documents directory
    NSString *documentsPath = [paths objectAtIndex:0];
    //get the path for Data.plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"favorites.plist"];
    
    //check to see if Data.plist exists
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        
        plistPath = [[NSBundle mainBundle] pathForResource:@"favorites" ofType:@"plist"];
        //NSLog(@"plistPath: %@",plistPath);
    }
    
    //read property list into a dictionary object
    favDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSLog(@"logDict: %@",favDict);
    
    if (!favDict) {
        
        NSLog(@"Error reading plist");
    }else{
        // NSLog(@"Loaded OKAY");
    }
    
    self.favorites = [NSMutableArray array];
    
    [self loadData];
    
}


-(void)loadData{ //Called from self viewDidLoad
    
    // Load in data from the logs.plist
    /*
     NSString *path = [[NSBundle mainBundle] pathForResource:@"logs" ofType:@"plist"];
     NSDictionary *tempDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
     */
    //changed the following line to match what you saved it as
    NSArray *tempArray = [[favDict objectForKey:@"Root" ] objectForKey:@"Favorites"];
    
    NSLog(@"tempArray: %@",tempArray);
    
    
    for (id dict in tempArray) {
        //NSLog(@"dict=%@",dict);
        
        NSString *title = [dict objectForKey:FAV_TITLE];
        NSLog(@"title: %@",title);
        
        
        // Create NMADRestaurant objects
        
        Favorite *f = [[Favorite alloc] initWithName:title];
        
        
        
        // add to  self.logs array
        [self.favorites addObject:f];
        
        [self.tableView reloadData];
        
    }
    
    
    
    
    
    /*
    //Load in our plist data for favorites
    NSString *path = [[NSBundle mainBundle] pathForResource:@"favorites" ofType:@"plist"];
    NSDictionary *tempDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *tempArray = [tempDictionary objectForKey:@"Favorites"];
    
    //Array that will hold our data from plist
    self.favorites = [NSMutableArray array];
    
    for (id dict in tempArray) {
        
        NSString *gameName = [dict objectForKey:@"name"];
        
        // Create favorite object
        Favorite *f = [[Favorite alloc] initWithName:gameName];
        
        // add to  self.favorites array
        [self.favorites addObject:f];
        
      */  


}



- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self loadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [favorites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    Favorite *f = [self.favorites objectAtIndex:indexPath.row];
    
    cell.textLabel.text = f.gameName;
    
    // cell.textLabel.text = tempString;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
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
    //Get our favorite object 
   Favorite *f = [self.favorites objectAtIndex:indexPath.row];
    NSString *name = f.gameName;
    NewLogVC *newLogVC = [[NewLogVC alloc]init];
    newLogVC.title = @"New Log";
    newLogVC.gamename = name;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self.navigationController pushViewController:newLogVC animated:YES];}

@end
