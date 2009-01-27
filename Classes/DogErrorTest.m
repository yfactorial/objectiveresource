//
//  DogErrorTest.m
//  active_resource
//
//  Created by James Burka on 12/29/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import "DogErrorTest.h"

@implementation DogError

+ (NSString *)getSite {
	return @"http://localhost:36313/";
}

@end

@implementation DogDoesNotExist

+ (NSString *)getSite {
	return @"http://badhost.localhost:9999/";
}

@end

@implementation DogErrorTest


- (void) test404Error {
	NSError *aError;
	[DogError findAllWithResponse:&aError];
  
  STAssertEquals([aError code], 404, @"Should have returned 404 error instead got %d " , 
                 [aError code]);
}

- (void) testCantFindServer {
	NSError *aError;
	[DogDoesNotExist findAllWithResponse:&aError];
  
  STAssertTrue([[aError domain] isEqualToString:NSURLErrorDomain], 
							 @"Should have returned NSURLErrorDomain error instead got %@ " , [aError domain]);
	STAssertEquals([aError code], NSURLErrorCannotFindHost, @"Should have returned NSURLErrorCannotFindHost(-1003) error instead got %d " , 
                 [aError code]);
	
}

@end
