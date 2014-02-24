//
//  GamesVC.m
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "GamesVC.h"

@interface GamesVC ()

@end

@implementation GamesVC


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self = [super initWithStyle:style]) {
        // Custom initialization
    }
    return self;
}



#pragma mark -
#pragma mark - Pareser methods


-(void)loadData{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection){
        responseData = [NSMutableData data];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
    }
    
    NSLog(@"connection=%@",connection);
}

#pragma mark NSURLConnection delegate methods
-(void)parseData{
    NSLog(@"parseData! data=%@",responseData);
    NSString *string = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    textView.text = string;
    
    NSString *applicationDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *fullPath = [applicationDocumentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    NSError *error;
    if([string writeToFile:fullPath atomically:YES encoding:NSUTF8StringEncoding error:&error]){
        NSLog(@"data.plist written to disk!");
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        NSLog(@"Here it is as a dictionary!\n dict=%@",dict);
    }else{
        NSLog(@"Problem writing data.plist file! error=%@",error);
    }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"didReceiveResponse response = %@",httpResponse);
    NSLog(@"Status Code: %d", [httpResponse statusCode]);
    NSLog(@"headers: %@", [httpResponse allHeaderFields]);
    NSString *lastModStr = [[httpResponse allHeaderFields] objectForKey:@"Last-Mod"];
    NSLog(@"last-mod: %@",[NSDate dateWithTimeIntervalSince1970:[lastModStr floatValue]]);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"didReceiveData: %@", data);
    NSString *string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"didRecieveData string: %@",string);
    [responseData appendData:data];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [spinner stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    NSLog(@"didFailWithError: %@",error);
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connectionDidFinishLoading");
    [spinner stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
    [self parseData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    urlString = @"http://www.boardgamegeek.com/xmlapi/search?search=Crossbows%20and%20Catapults";
    [self loadData];
    spinner.hidesWhenStopped = YES;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        
    }
    
    
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
    
}

@end
