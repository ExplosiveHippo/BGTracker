//
//  Favorite.m
//  BGTracker
//
//  Created by Lance Laughlin on 5/11/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import "Favorite.h"

@implementation Favorite
@synthesize gameName;



-(id)initWithName:(NSString *)name{
    gameName = name;
    
    return self;
}


-(BOOL)addFavorite{
    NSLog(@"Adding to Favorites");
    
    
    return YES;
}

@end
