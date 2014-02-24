//
//  FeedFetcher.h
//  Reader
//
//  Created by Tony Jefferson on 4/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//



///////// UPDATED FEEDFETCHER INFORMATION - currentName ////////////////



#import <Foundation/Foundation.h>
@class FeedFetcher;
@protocol FeedFetcherDelegate

@required
- (void)feedFetcher:(FeedFetcher *)feedFetcher didLoadFeed:(NSMutableArray *)array;

@end


@interface FeedFetcher : NSObject<NSXMLParserDelegate> {
	id <FeedFetcherDelegate>__weak feedDelegate;
	NSString *urlString;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
	//
	NSXMLParser *xmlParser;
	NSMutableArray *itemArray;
	// Temp dictionary to hold each item as we parse it
	NSMutableDictionary *currentItemDict;
	NSString *currentElement; 
	NSMutableString *currentName;
}

@property (nonatomic,strong) NSXMLParser *xmlParser;
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,copy) NSString *urlString;
@property (nonatomic,strong) NSMutableData *responseData;
@property (nonatomic,strong) NSURLConnection *urlConnection;
@property (nonatomic,weak) id <FeedFetcherDelegate>feedDelegate;
@property (nonatomic, strong) id <UIAlertViewDelegate>alertDelegate;
//
//
@property (nonatomic,strong) NSMutableDictionary *currentItemDict;
@property (nonatomic,copy) NSString * currentElement; 
@property (nonatomic,strong) NSMutableString * currentName;


- (id)initWithURL:(NSString *)value;
- (void)loadData;
- (void)parseData;
- (void)fetchFailed;
- (NSString *)flattenHTML:(NSString *)html;
@end
