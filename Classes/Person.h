//
//  Person.h
//  objective_resource
//
//  Created by James Burka on 1/26/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "ObjectiveResource.h"

@interface Person : NSObject {
	
	NSString *name;
  NSString *personId;
  NSDate   *updatedAt;
  NSDate   *createdAt;
	NSNumber *someInteger;
	NSNumber *someDecimal;
  
}

@property (nonatomic , retain) NSDate * createdAt;
@property (nonatomic , retain) NSDate * updatedAt;
@property (nonatomic , retain) NSString  *personId;
@property (nonatomic , retain) NSString *name;
@property (nonatomic , retain) NSNumber *someInteger;
@property (nonatomic , retain) NSNumber *someDecimal;

-(NSArray *) findAllDogs;

@end
