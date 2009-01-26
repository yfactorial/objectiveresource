//
//  Response.h
//  
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//
#ifdef __OBJC__
//setup debug only logging
#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#else
#define debugLog(...)
#endif
#endif

@interface Response : NSObject {
	NSData *body;
	NSDictionary *headers;
	NSInteger statusCode;
	NSError *error;
}

@property (nonatomic, retain) NSData *body;
@property (nonatomic, retain) NSDictionary *headers;
@property (assign, nonatomic) NSInteger statusCode;
@property (nonatomic, retain) NSError *error;

+ (id)responseFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data andError:(NSError *)aError;
- (id)initFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data andError:(NSError *)aError;
- (BOOL)isSuccess;
- (BOOL)isError;
- (void)log;
@end
