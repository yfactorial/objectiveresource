//
//  Connection.m
//  medaxion
//
//  Created by Ryan Daigle on 7/30/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "Connection.h"
#import "Response.h"

@implementation Connection

+ (void)logRequest:(NSURLRequest *)request to:(NSString *)url {
	NSLog(@"%@ -> %@", [request HTTPMethod], url);
	if([request HTTPBody]) {
		NSLog([[[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding] autorelease]);
	}
}

+ (void)logResponse:(NSHTTPURLResponse *)response withBody:(NSData *)body {
	NSLog(@"<= %@", [[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding] autorelease]);
}

+ (Response *)sendRequest:(NSMutableURLRequest *)request withUser:(NSString *)user andPassword:(NSString *)password {
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
	[self logResponse:response withBody:data];
	[escapedUser release];
	[escapedPassword release];
	return [Response responseFrom:response withBody:data];
}

+ (Response *)post:(NSString *)body to:(NSString *)url {
	return [self post:body to:url withUser:@"X" andPassword:@"X"];
}

+ (Response *)sendBy:(NSString *)method withBody:(NSString *)body to:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
	[request setHTTPMethod:method];
	[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	[request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
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
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
	[request setHTTPMethod:@"GET"];
	[request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
	return [self sendRequest:request withUser:user andPassword:password];
}

+ (Response *)delete:(NSString *)url withUser:(NSString *)user andPassword:(NSString *)password {
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
	[request setHTTPMethod:@"DELETE"];
	[request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
	return [self sendRequest:request withUser:user andPassword:password];
}

@end
