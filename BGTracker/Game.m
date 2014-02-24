//
//  Game.m
//  BGTracker
//
//  Created by Lance Laughlin on 5/11/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize gameName;

-(id)initWithName:(NSString *)name{
    gameName = name;
    
    return self;
}

@end
