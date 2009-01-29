//
//  PersonTest.m
//  objective_resource
//
//  Created by James Burka on 1/27/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "PersonTest.h"
#import "Person.h"
#import "ItemIds.h"


@implementation PersonTest

-(void) setUp {
	[ObjectiveResourceConfig setSite:@"http://localhost:36313/"];
	[ObjectiveResourceConfig setResponseType:JSONResponse];
	//[ObjectiveResourceConfig setResponseType:XmlResponse];
}

-(void) testPersonDelete {
	int count = [[Person findAllORS]count];
  Person *person = [Person findORS:[NSString stringWithFormat:@"%i",PERSON_DESTROY]];
  STAssertTrue([person destroyORS], @"Should have been true");	
	NSArray *people = [Person findAllORS];
  STAssertTrue((count-1) == [people count], @"Should have %i people , %d found" ,count ,[people count]);
	
}

-(void) testPersonCreate {
	BOOL found = NO;
	Person *toCreate = [[Person alloc] init];
	toCreate.name = @"Daniel Waterhouse";
  STAssertTrue(	[toCreate createORS], @"Should have been true");	
  NSArray *people = [Person findAllORS];

	for(Person *person in people) {
		if([toCreate isEqual:person]) {
			found = YES;
		}
	}
  STAssertTrue(found, @"Did not find the new person : %@",toCreate.name);	
}

-(void) testPersonUpdate {
	BOOL found = NO;
  Person *toUpdate = [Person findORS:[NSString stringWithFormat:@"%i",PERSON]];
	toUpdate.name = @"America Shaftoe";
  STAssertTrue(	[toUpdate saveORS], @"Should have been true");	
	NSArray *people = [Person findAllORS];
	for(Person *person in people) {
		if([toUpdate isEqual:person] && [toUpdate.name isEqualToString:person.name]) {
			found = YES;
		}
	}
  STAssertTrue(found, @"");	
}

-(void) testFindPerson {
  NSArray * people = [Person findAllORS];
	Person *toFind = (Person *)[people objectAtIndex:0];
	STAssertTrue([toFind isEqual:[Person findORS:toFind.personId]], @"Should of returned %@",toFind.name);	
}



@end
