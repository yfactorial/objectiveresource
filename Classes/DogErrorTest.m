//
//  DogErrorTest.m
//  active_resource
//
//  Created by James Burka on 12/29/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import "DogErrorTest.h"

@implementation DogError

static NSString *site = @"http://localhost:3000/";
+ (NSString *)getSite {
	return site;
}

@end



@implementation DogErrorTest


- (void) test404Error {
	NSError *aError;
	NSArray * dogs = [DogError findAllWithResponse:&aError];
  
  STAssertEquals([aError code], 404, @"Should have returned 404 error instead got %d " , 
                 [aError code]);
}

@end
