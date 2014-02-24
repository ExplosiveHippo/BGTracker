//
//  Log.h
//  BGTracker
//
//  Created by Lance Laughlin on 5/8/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Log : NSObject{
    NSString *logsPath;
    NSMutableDictionary *dict;
}

@property (strong, nonatomic) NSString *logName;
@property (strong, nonatomic) NSString *gameName;
@property (strong, nonatomic) NSMutableArray *players;
@property (strong, nonatomic) NSString *notes;


-(id)initWithName:(NSString *)name players:(NSMutableArray *)myPlayers notes:(NSString *)myNotes logName:(NSString *)myLogName;

-(BOOL)addLog;

-(NSString *)docsDir;

@end
