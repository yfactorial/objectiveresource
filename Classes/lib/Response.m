//
//  Response.m
//  medaxion
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "Response.h"

@implementation Response

@synthesize body, headers, statusCode;

+ (id)responseFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data {
	return [[[self alloc] initFrom:response withBody:data] autorelease];
}

- (id)initFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data {
	[self init];
	self.body = data;
	self.statusCode = [response statusCode];
	self.headers = [response allHeaderFields];
	return self;
}

- (BOOL)isSuccess {
	return statusCode >= 200 && statusCode < 400;
}

- (void)log {
	if ([self isSuccess]) {
		NSLog(@"<= %@", [[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding] autorelease]);
	}
	else {
		NSLog(@"<= %@", [[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding] autorelease]);
	}
}

#pragma mark cleanup

- (void) dealloc
{
	[body release];
	[headers release];
	[super dealloc];
}


@end
