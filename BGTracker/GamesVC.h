//
//  GamesVC.h
//  BGTracker
//
//  Created by Lance Laughlin on 4/25/13.
//  Copyright (c) 2013 Lance Laughlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamesVC : UITableViewController{
    IBOutlet UITextView *textView;
    NSMutableData *responseData;
    NSString *urlString;
}

-(void)loadData;
-(void)parseData;

@end
