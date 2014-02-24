//
//  Log.m
//  BGTracker
//
//  Created by Lance Laughlin on 5/8/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "Log.h"
#import "ViewLogVC.h"

@implementation Log

@synthesize gameName,players,notes,logName;

-(id)initWithName:(NSString *)name players:(NSMutableArray *)myPlayers notes:(NSString *)myNotes logName:(NSString *)myLogName{
    self = [super init];
    gameName = name;
    players = myPlayers;
    notes = myNotes;
    logName = myLogName;
    
    return self;
}


// Just to make accessing our docsDir a bit easier
-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}


-(BOOL)addLog{
    
    // BOOL that will help us determine if the log was added successfully
    BOOL added = NO;
    
    logsPath = [[self docsDir]stringByAppendingPathComponent:@"logs.plist"];
    
    if(![[NSFileManager defaultManager]fileExistsAtPath:logsPath]){
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"logs" ofType:@"plist"] toPath:logsPath error:nil];
        // if the files were added correctly then change the bool to yes.
        added = YES;
    }
    
    dict = [NSMutableArray arrayWithContentsOfFile:logsPath];
    
    NSLog(@"count: %i",[dict count]);
    
    
    
    /*NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"logs"]];
    
    NSMutableArray *log = [NSMutableArray arrayWithObjects:gameName,players,notes, nil];
    
    if(![array containsObject:log]){
        [array addObject:log];
        added = YES;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"logs"];
    NSLog(@"The user defaults are: %@", [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"logs"]]);
     */
    
    
    return added;

}


@end
