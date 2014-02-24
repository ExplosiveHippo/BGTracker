//
//  ViewLogVC.h
//  BGTracker
//
//  Created by Lance Laughlin on 5/9/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewLogVC : UITableViewController<UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *logs;
@property (nonatomic, strong) NSMutableDictionary *logDict;


-(void)loadData;

@end
