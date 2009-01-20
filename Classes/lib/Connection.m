//
//  Connection.m
//  medaxion
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "Connection.h"
#import "Response.h"
#import "NSData+Additions.h"
#import "NSMutableURLRequest+ResponseType.h"


//#define debugLog(...) NSLog(__VA_ARGS__)
#ifndef debugLog(...)
	#define debugLog(...)
#endif

@implementation Connection

static float timeoutInterval = 5.0;

+ (void)setTimeout:(float)timeOut {
	timeoutInterval = timeOut;
}
+ (float)timeout {
	return timeoutInterval;
}

+ (void)logRequest:(NSURLRequest *)request to:(NSString *)url {
	debugLog(@"%@ -> %@", [request HTTPMethod], url);
	if([request HTTPBody]) {
		debugLog([[[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding] autorelease]);
	}
}

+ (Response *)sendRequest:(NSMutableURLRequest *)request withUser:(NSString *)user andPassword:(NSString *)password {
	
	//lots of servers fail to implement http basic authentication correctly, so we pass the credentials even if they are not asked for
	//TODO make this configurable?
	NSString *authString = [[[NSString stringWithFormat:@"%@:%@",user, password] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
	[request addValue:[NSString stringWithFormat:@"Basic %@", authString] forHTTPHeaderField:@"Authorization"]; 
	NSString *escapedUser = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
								(CFStringRef)user, NULL, (CFStringRef)@"@.:", kCFStringEncodingUTF8);
	NSString *escapedPassword = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
								(CFStringRef)password, NULL, (CFStringRef)@"@.:", kCFStringEncodingUTF8);
	NSURL *url = [request URL];
	NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@:%@@%@:%@%@?%@", [url scheme],escapedUser, escapedPassword, 
										   [url host], [url port], [url path], [url query]]];
	[request setURL:authURL];
	NSHTTPURLResponse *response;
	NSError *error;
	[self logRequest:request to:[authURL absoluteString]];
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	[escapedUser release];
	[escapedPassword release];
	Response *resp = [Response responseFrom:response withBody:data andError:error];
	[resp log];
	return resp;
}

+ (Response *)post:(NSString *)body to:(NSString *)url {
	return [self post:body to:url withUser:@"X" andPassword:@"X"];
}

+ (Response *)sendBy:(NSString *)method withBody:(NSString *)body to:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithUrl:[NSURL URLWithString:url] andMethod:method];
	[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	return [self sendRequest:request withUser:user andPassword:password];
}

+ (Response *)post:(NSString *)body to:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password{
	return [self sendBy:@"POST" withBody:body to:url withUser:user andPassword:password];
}

+ (Response *)put:(NSString *)body to:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password{
	return [self sendBy:@"PUT" withBody:body to:url withUser:user andPassword:password];
}

+ (Response *)get:(NSString *)url {
	return [self get:url withUser:@"X" andPassword:@"X"];
}

+ (Response *)get:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password {
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithUrl:[NSURL URLWithString:url] andMethod:@"GET"];
	return [self sendRequest:request withUser:user andPassword:password];
}

+ (Response *)delete:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password {
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithUrl:[NSURL URLWithString:url] andMethod:@"DELETE"];
	return [self sendRequest:request withUser:user andPassword:password];
}

@end
