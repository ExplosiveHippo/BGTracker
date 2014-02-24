//
//  GamesTableVC.h
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedFetcher.h"

@interface GamesTableVC : UITableViewController<UISearchBarDelegate,FeedFetcherDelegate>{
}

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSString *searchTerm;

@property (nonatomic,strong) FeedFetcher *feedFetcher;

@property (nonatomic, strong) NSString *urlString;

@property (nonatomic, strong) NSMutableArray *gameResults;



@end

