//
//  Favorite.h
//  BGTracker
//
//  Created by Lance Laughlin on 5/11/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Favorite : NSObject

@property (strong,nonatomic) NSString * gameName;


-(id)initWithName:(NSString *)name;

-(BOOL)addFavorite;

@end
