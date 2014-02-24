//
//  GamesTableVC.m
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "GamesTableVC.h"
#import "Game.h"
#import "GamesDetailVCViewController.h"

@interface GamesTableVC ()

@end

@implementation GamesTableVC

@synthesize searchBar,searchTerm,feedFetcher,urlString,gameResults;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self = [super initWithStyle:style]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Creates our search bar and add it to the current view
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,70,320,44)];
    searchBar.autocorrectionType = UITextAutocorrectionTypeYes;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    searchBar.keyboardType = UIKeyboardTypeAlphabet;
    searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    
}




-(void)feedFetcher:(FeedFetcher *)feedFetcher didLoadFeed:(NSMutableArray *)array {    

    gameResults = array;
    
    [self.tableView reloadData];
    
}




- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar resignFirstResponder];    
    
    // Get our search term
    searchTerm = self.searchBar.text;
    
    //Build our query
    NSString *urlStart = @"http://www.boardgamegeek.com/xmlapi/search?search=";
    urlString = [urlStart stringByAppendingString:searchTerm];
    
    // Create the fetchFeeder with the url
    feedFetcher = [[FeedFetcher alloc] initWithURL:urlString];
    
    feedFetcher.feedDelegate = self;
    
}


#pragma mark -
#pragma mark - Pareser methods



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
    return [gameResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSString *title = [[gameResults objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    
    cell.textLabel.text = title;
    
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
    NSString *name = [[gameResults objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    // Remove the whitespace and tab formattings that come back from the XML
    NSString *trimmedName = [name stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Go the the detailView for the game selected
    GamesDetailVCViewController *newGamesDetailVC = [[GamesDetailVCViewController alloc]init];
    newGamesDetailVC.title = trimmedName;
    newGamesDetailVC.gameName = trimmedName;
    
    //Just removes the dumb blue overlay when they click something.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:newGamesDetailVC animated:YES];
}

@end


