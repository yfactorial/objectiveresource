//
//  Dog.h
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import "ObjectiveResource.h"

@interface Dog : ObjectiveResource {
	
	NSString *name;
  NSString *dogId;
	NSString *personId;
  NSDate   * updatedAt;
  NSDate   * createdAt;
  
}

@property (nonatomic , retain) NSDate * createdAt;
@property (nonatomic , retain) NSDate * updatedAt;
@property (nonatomic , retain) NSString  *dogId;
@property (nonatomic , retain) NSString *name;
@property (nonatomic , retain) NSString *personId;
@end
