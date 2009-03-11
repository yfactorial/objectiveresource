//
//  NSHTTPURLResponse+Error.m
//  iphone-harvest
//
//  Created by James Burka on 12/23/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import "NSHTTPURLResponse+Error.h"
#import "ObjectiveResourceConfig.h"

@implementation NSHTTPURLResponse(Error)

+ (NSError *)buildResponseError:(int)statusCode withBody:(NSData *)data{
	NSMutableDictionary *description = [NSMutableDictionary dictionary];
	[description setObject:[NSString stringWithFormat:@"%i Error",statusCode] forKey:NSLocalizedFailureReasonErrorKey];
	[description setObject:[[self class] localizedStringForStatusCode:statusCode] forKey:NSLocalizedDescriptionKey];
	[description setObject:[[self class] errorArrayForBody:data] forKey:NSLocalizedRecoveryOptionsErrorKey];
	return [NSError errorWithDomain:@"com.yfactorial.objectiveresource" code:statusCode userInfo:description];
}

+ (NSArray *)errorArrayForBody:(NSData *)data {
	NSMutableArray *returnStrings = [NSMutableArray array];
	NSArray *errorArrays = [[self class] performSelector:[ObjectiveResourceConfig getParseDataMethod] withObject:data];
	for (NSArray *error in errorArrays) [returnStrings addObject:[error componentsJoinedByString:@" "]];
	return returnStrings;
}

-(NSError *) errorWithBody:(NSData *)data {
	if([self isSuccess]) {
		return nil;
	}
	else {
		return [[self class] buildResponseError:[self statusCode] withBody:data];
	}
}

-(BOOL) isSuccess {
	return [self statusCode] >= 200 && [self statusCode] < 400;
}

@end
