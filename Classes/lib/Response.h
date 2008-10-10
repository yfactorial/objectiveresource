//
//  Response.h
//  medaxion
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

@interface Response : NSObject {
	NSData *body;
	NSDictionary *headers;
	NSInteger statusCode;
}

@property (nonatomic, retain) NSData *body;
@property (nonatomic, retain) NSDictionary *headers;
@property (assign, nonatomic) NSInteger statusCode;

+ (id)responseFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data;
- (id)initFrom:(NSHTTPURLResponse *)response withBody:(NSData *)data;
- (BOOL)isSuccess;
@end
