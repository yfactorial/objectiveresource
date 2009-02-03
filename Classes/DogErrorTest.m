//
//  DogErrorTest.m
//  active_resource
//
//  Created by James Burka on 12/29/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//Remote

#import "DogErrorTest.h"

@implementation DogError

+ (NSString *)getRemoteSite {
	return @"http://localhost:36313/";
}

@end

@implementation DogDoesNotExist

+ (NSString *)getRemoteSite {
	return @"http://badhost.localhost:9999/";
}

@end

@implementation DogErrorTest


- (void) test404Error {
	NSError *aError;
	[DogError findAllRemoteWithResponse:&aError];
  
  STAssertEquals([aError code], 404, @"Should have returned 404 error instead got %d " , 
                 [aError code]);
}

- (void) testCantFindServer {
	NSError *aError;
	[DogDoesNotExist findAllRemoteWithResponse:&aError];
  
  STAssertTrue([[aError domain] isEqualToString:NSURLErrorDomain], 
							 @"Should have returned NSURLErrorDomain error instead got %@ " , [aError domain]);
	STAssertEquals([aError code], NSURLErrorCannotFindHost, @"Should have returned NSURLErrorCannotFindHost(-1003) error instead got %d " , 
                 [aError code]);
	
}

@end
