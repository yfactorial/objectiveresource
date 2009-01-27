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
	[ObjectiveResource setSite:@"http://localhost:3000/"];
	[ObjectiveResource setResponseType:JSONResponse];
	//[ObjectiveResource setResponseType:XmlResponse];
}

-(void) testPersonDelete {
	int count = [[Person findAll]count];
  Person *person = [Person find:[NSString stringWithFormat:@"%i",PERSON_DESTROY]];
  STAssertTrue([person destroy], @"Should have been true");	
	NSArray *people = [Person findAll];
  STAssertTrue((count-1) == [people count], @"Should have %i people , %d found" ,count ,[people count]);
	
}

-(void) testPersonCreate {
	BOOL found = NO;
	Person *toCreate = [[Person alloc] init];
	toCreate.name = @"Daniel Waterhouse";
  STAssertTrue(	[toCreate create], @"Should have been true");	
  NSArray *people = [Person findAll];

	for(Person *person in people) {
		if([toCreate isEqual:person]) {
			found = YES;
		}
	}
  STAssertTrue(found, @"Did not find the new person : %@",toCreate.name);	
}

-(void) testPersonUpdate {
	BOOL found = NO;
  Person *toUpdate = [Person find:[NSString stringWithFormat:@"%i",PERSON]];
	toUpdate.name = @"America Shaftoe";
  STAssertTrue(	[toUpdate save], @"Should have been true");	
	NSArray *people = [Person findAll];
	for(Person *person in people) {
		if([toUpdate isEqual:person] && [toUpdate.name isEqualToString:person.name]) {
			found = YES;
		}
	}
  STAssertTrue(found, @"");	
}

-(void) testFindPerson {
  NSArray * people = [Person findAll];
	Person *toFind = (Person *)[people objectAtIndex:0];
	STAssertTrue([toFind isEqual:[Person find:toFind.personId]], @"Should of returned %@",toFind.name);	
}



@end
