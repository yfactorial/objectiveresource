//
//  Dog.m
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import "Dog.h"


@implementation Dog

@synthesize name, dogId , createdAt , updatedAt;

static NSString *site = @"http://localhost:3000/";

+ (NSString *)getSite {
	return site;
}

- (void) dealloc
{
  [dogId release];
	[name release];
	[super dealloc];
}


@end
