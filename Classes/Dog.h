//
//  Dog.h
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import "ActiveResourceSupport.h"

@interface Dog : ActiveResource {
	
	NSString *name;
  NSString *dogId;
  NSDate   * updatedAt;
  NSDate   * createdAt;
  
}

@property (nonatomic , retain) NSDate * createdAt;
@property (nonatomic , retain) NSDate * updatedAt;
@property (nonatomic , retain) NSString  *dogId;
@property (nonatomic , retain) NSString *name;
@end
