//
//  DogTest.m
//  active_resource
//
//  Created by James Burka on 10/15/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import "DogTest.h"
#import "Dog.h"
#import "Person.h"
#import "NSString+XMLSerializableSupport.h"
#import "ItemIds.h"

@implementation DogTest

static Person *owner;

-(void) setUp {
	[ObjectiveResourceConfig setSite:@"http://localhost:36313/"];
	[ObjectiveResourceConfig setResponseType:JSONResponse];
	//[ObjectiveResource setResponseType:XmlResponse];
	[ObjectiveResourceConfig setUser:nil];
	[ObjectiveResourceConfig setPassword:nil];
	owner = [Person findRemote:[NSString stringWithFormat:@"%i",DOG_OWNER]];
}

-(void) testDogProperties {
 
  Dog * aDog = [[Dog alloc] init];
  STAssertTrue([aDog respondsToSelector: @selector(dogId)],@"Didn't find dogId");
  [aDog release];
  
}

-(void) testDogCount {
 
  NSArray * dogs = [owner findAllDogs];
  
  STAssertTrue(20 == [dogs count], @"Should have %i dogs , %d found" , 
							 20 ,[dogs count]);
  
}

- (void) testDogWithEscapableChars {
	int shouldBe  = [[owner findAllDogs] count] + 1;
	
	Dog* aDog	 = [[Dog alloc] init];
	aDog.personId = owner.personId;
	aDog.name = @"Helio's Coffee & Chairs";
  [aDog saveRemote];
  NSArray * dogs = [owner findAllDogs];

  
  STAssertTrue(shouldBe == [dogs count], @"Should have %i dogs , %d found" , 
							 shouldBe ,[dogs count]);
	STAssertTrue([[aDog.name toXMLValue] isEqualToString: @"Helio&apos;s Coffee &amp; Chairs"],@"Should be Helio&apos;s Coffee &amp; Chairs , got %@" , [aDog.name toXMLValue]);
	STAssertTrue([[NSString fromXmlString:aDog.name] isEqualToString: @"Helio's Coffee & Chairs"],@"Should be Helio's Coffee & Chairs , got %@" , [aDog.name toXMLValue]);

	
}

-(void) testDogSave{
	int shouldBe  = [[owner findAllDogs]count] + 1;
  
  Dog * aDog = [[Dog alloc] init];
  aDog.personId = owner.personId;
  aDog.name = @"Judge";

  [aDog saveRemote];
  NSArray * dogs = [owner findAllDogs];
  STAssertTrue(shouldBe == [dogs count], @"Should have %i dogs , %d found" , 
							 shouldBe ,[dogs count]);
  
  [aDog release];
}

-(void) testDogUpdate{
  NSArray * dogs = [owner findAllDogs];
  BOOL found = NO;
  Dog *aDog = [dogs objectAtIndex:0];
  aDog.name = @"Judge";
  [aDog updateRemote];

  aDog = [dogs objectAtIndex:0];
	
	for(Dog *dog in dogs) {
		if([dog isEqual:aDog]) {
			STAssertTrue([dog.name isEqualToString: aDog.name],@"Should be Judge , got %@" , aDog.name);
			found = YES;
		}
	}
	STAssertTrue(found,@"Should found the record");
	
  
}

-(void) testDogDelete {
 
	BOOL found = NO;
  NSArray * dogs = [owner findAllDogs];
  
  int shouldBe = [dogs count] - 1;
  Dog *toDelete = (Dog *)[dogs objectAtIndex:0];
  [toDelete destroyRemote];
  
  dogs = [owner findAllDogs];
  STAssertTrue(shouldBe == [dogs count], @"Should have %i dogs , %d found" , 
                 shouldBe ,[dogs count]);
	
	for(Dog *dog in dogs) {
		if([dog isEqual:toDelete]) {
			found = YES;
		}
	}
	STAssertFalse(found,@"Should not found the record");
  
}

  
@end
  
