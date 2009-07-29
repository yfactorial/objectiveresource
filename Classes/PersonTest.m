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
#import "PrefixedPerson.h"

@implementation PersonTest

-(void) setUp {
	[ObjectiveResourceConfig setSite:@"http://localhost:36313/"];
	[ObjectiveResourceConfig setResponseType:JSONResponse];
	[ObjectiveResourceConfig setUser:nil];
	[ObjectiveResourceConfig setPassword:nil];
	//[ObjectiveResourceConfig setResponseType:XmlResponse];
}



-(void) testPersonDelete {
	int count = [[Person findAllRemote]count];
  Person *person = [Person findRemote:[NSString stringWithFormat:@"%i",PERSON_DESTROY]];
  STAssertTrue([person destroyRemote], @"Should have been true");	
	NSArray *people = [Person findAllRemote];
  STAssertTrue((count-1) == [people count], @"Should have %i people , %d found" ,count ,[people count]);
	
}

-(void) testPersonCreate {
	BOOL found = NO;
	Person *toCreate = [[Person alloc] init];
	toCreate.name = @"Daniel Waterhouse";
  STAssertTrue(	[toCreate createRemote], @"Should have been true");	
  NSArray *people = [Person findAllRemote];

	for(Person *person in people) {
		if([toCreate isEqualToRemote:person]) {
			found = YES;
		}
	}
  STAssertTrue(found, @"Did not find the new person : %@",toCreate.name);	
}

-(void) testPersonUpdate {
	BOOL found = NO;
  Person *toUpdate = [Person findRemote:[NSString stringWithFormat:@"%i",PERSON]];
	toUpdate.name = @"America Shaftoe";
  STAssertTrue(	[toUpdate saveRemote], @"Should have been true");	
	NSArray *people = [Person findAllRemote];
	for(Person *person in people) {
		if([toUpdate isEqualToRemote:person] && [toUpdate.name isEqualToString:person.name]) {
			found = YES;
		}
	}
  STAssertTrue(found, @"");	
}

-(void) testFindPerson {
  NSArray * people = [Person findAllRemote];
	Person *toFind = (Person *)[people objectAtIndex:0];
	STAssertTrue([toFind isEqualToRemote:[Person findRemote:toFind.personId]], @"Should of returned %@",toFind.name);	
}

- (void) testPrefixedPerson {
	NSArray *people = [Person findAllRemote];
	
	int shouldBe = [people count];
	[ObjectiveResourceConfig setLocalClassesPrefix:@"Prefixed"];
	people = [PrefixedPerson findAllRemote];
	
	STAssertTrue(shouldBe == [people count], @"Should have %i people , %d found" , 
				 shouldBe ,[people count]);
	[ObjectiveResourceConfig setLocalClassesPrefix:nil];
}


@end
