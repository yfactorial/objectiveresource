//
//  Person.m
//  objective_resource
//
//  Created by James Burka on 1/26/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "Person.h"
#import "Dog.h"
#import "ObjectiveResource.h"

@implementation Person 
@synthesize createdAt , updatedAt , name , personId, someInteger, someDecimal;


// handle pluralization 
+ (NSString *)getRemoteCollectionName {
	return @"people";
}


// this will go to the url http://localhost:3000/people/<id>/dogs
// and return the array of dogs
-(NSArray *) findAllDogs {
	return [Dog findRemote:[NSString stringWithFormat:@"%@/%@",personId,@"dogs",nil]];
}

#pragma mark cleanup
- (void) dealloc
{
	[createdAt release];
	[updatedAt release];
	[name release];
	[someInteger release];
	[someDecimal release];
	[super dealloc];
}


@end
