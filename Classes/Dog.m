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

+ (NSString *)getRemoteCollectionName {
	return @"people";
}

- (BOOL)createRemoteWithResponse:(NSError **)aError {
	return [self createRemoteAtPath:[[self class] getRemoteElementPath:[self nestedPath]] withResponse:aError];
}

- (BOOL)updateRemoteWithResponse:(NSError **)aError {
	return [self updateRemoteAtPath:[[self class] getRemoteElementPath:[self nestedPath]] withResponse:aError];	
}

- (BOOL)destroyRemoteWithResponse:(NSError **)aError {
	return [self destroyRemoteAtPath:[[self class] getRemoteElementPath:[self nestedPath]] withResponse:aError];
}


-(NSString *) nestedPath {
	NSString *path = [NSString stringWithFormat:@"%@/dogs",personId,nil];
	if(dogId) {
		path = [path stringByAppendingFormat:@"/%@",dogId,nil];
	}
	return path;
}

@end
