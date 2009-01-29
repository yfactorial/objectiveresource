//
//  Dog.m
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import "Dog.h"
#import "ObjectiveResource.h"

@interface Dog ()

-(NSString *) nestedPath;

@end



@implementation Dog

@synthesize name, dogId , createdAt , updatedAt , personId;

- (void) dealloc
{
  [createdAt release];
  [updatedAt release];
  [dogId release];
	[name release];
	[personId release];
	[super dealloc];
}

#pragma mark ObjectiveResource overrides to handle nestd resources

+ (NSString *)getORSCollectionName {
	return @"people";
}

- (BOOL)createORSWithResponse:(NSError **)aError {
	return [self createAtPath:[[self class] elementPath:[self nestedPath]] withResponse:aError];
}

- (BOOL)updateORSWithResponse:(NSError **)aError {
	return [self updateAtPath:[[self class] elementPath:[self nestedPath]] withResponse:aError];	
}

- (BOOL)destroyORSWithResponse:(NSError **)aError {
	return [self destroyAtPath:[[self class] elementPath:[self nestedPath]] withResponse:aError];
}


-(NSString *) nestedPath {
	NSString *path = [NSString stringWithFormat:@"%@/dogs",personId,nil];
	if(dogId) {
		path = [path stringByAppendingFormat:@"/%@",dogId,nil];
	}
	return path;
}

@end
