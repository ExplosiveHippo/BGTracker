//
//  FavoritesVC.h
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"
#import "NewLogVC.h"


@interface FavoritesVC : UITableViewController<UITableViewDelegate>


@property (nonatomic,strong) NSMutableArray *favorites;
@property (nonatomic, strong) NSMutableDictionary *favDict;



-(void)loadData;

@end
