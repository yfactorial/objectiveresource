//
//  ConnectionManager.m
//
//  Created by Adam Alexander on 2/28/09.
//  Copyright 2009 yFactorial, LLC. All rights reserved.
//

#import "ConnectionManager.h"


@implementation ConnectionManager
@synthesize operationQueue;

- (void)cancelAllJobs {
	[operationQueue cancelAllOperations];
}

- (void) runJob:(SEL)selector onTarget:(id)target {
	[self runJob:selector onTarget:target withArgument:nil];
}

- (void) runJob:(SEL)selector onTarget:(id)target withArgument:(id)argument {
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:target selector:selector object:argument];
    [operationQueue addOperation:operation];
	[operation release];
}

- (id)init {
    if ( self = [super init] ) {
		self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
		[operationQueue setMaxConcurrentOperationCount:1];
		return self;
    } else {
		return nil;
	}
}

#pragma mark Standard Singleton Plumbing

static ConnectionManager *sharedConnectionManager = nil;

+ (ConnectionManager *)sharedInstance
{
    @synchronized(self) {
        if (sharedConnectionManager == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedConnectionManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedConnectionManager == nil) {
            sharedConnectionManager = [super allocWithZone:zone];
            return sharedConnectionManager;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}
@end
