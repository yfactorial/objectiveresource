//
//  ConnectionDelegate.h
//  iphone-harvest
//
//  Created by vickeryj on 1/14/09.
//  Copyright 2009 Joshua Vickery. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ConnectionDelegate : NSObject {

	NSMutableData *data;
	NSURLResponse *response;
	BOOL done;
	NSError *error;
	NSURLConnection *connection;
	
}

- (BOOL) isDone;
- (void) cancel;

@property(nonatomic, retain) NSURLResponse *response;
@property(nonatomic, retain) NSMutableData *data;
@property(nonatomic, retain) NSError *error;
@property(nonatomic, retain) NSURLConnection *connection;

@end
