//
//  NSHTTPURLResponse+Error.m
//  iphone-harvest
//
//  Created by James Burka on 12/23/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import "NSHTTPURLResponse+Error.h"

@implementation NSHTTPURLResponse(Error)

+ (NSError *)buildResponseError:(int)statusCode{
	NSMutableDictionary *description = [NSMutableDictionary dictionary];
	[description setObject:[NSString stringWithFormat:@"%i Error",statusCode] forKey:NSLocalizedFailureReasonErrorKey];
	[description setObject:[[self class] localizedStringForStatusCode:statusCode] forKey:NSLocalizedDescriptionKey];	
	return [NSError errorWithDomain:@"com.yfactorial.objectiveresource" code:statusCode userInfo:description];
}

-(NSError *) error {
	if([self isSuccess]) {
		return nil;
	}
	else {
		return [[self class] buildResponseError:[self statusCode]];
	}
}

-(BOOL) isSuccess {
	return [self statusCode] >= 200 && [self statusCode] < 400;
}

@end
