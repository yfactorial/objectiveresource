//
//  DogTest.m
//  active_resource
//
//  Created by James Burka on 10/15/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import "DogTest.h"
#import "Dog.h"
#import "NSString+XMLSerializableSupport.h"

@implementation DogTest

NSUInteger shouldBe = 0;

-(void) setUp {
	[ActiveResource setSite:@"http://localhost:3000/"];
	[ActiveResource setResponseType:JSONResponse];
//	[ActiveResource setProtocolExtension:@".json"];
//	[ActiveResource setParseDataMethod:@selector(fromJSONData:)];
}

-(void) testDogProperties {
 
  Dog * aDog = [[Dog alloc] init];
  STAssertTrue([aDog respondsToSelector: @selector(dogId)],@"Didn't find dogId");
  [aDog release];
  
}

-(void) testDogCount {
 
  if(shouldBe == 0) {
    shouldBe = 100;
  }
  NSArray * dogs = [Dog findAll];
  
  STAssertEquals(shouldBe , [dogs count], @"Should have %d dogs , %d found" , 
                 shouldBe, [dogs count]);
  
}

- (void) testDogWithEscapableChars {
	Dog* aDog	 = [[Dog alloc] init];
	aDog.name = @"Helio's Coffee & friends";
  if(shouldBe == 0) {
		
    shouldBe = 100;
    
  }
  shouldBe += 1;
  [aDog save];
  NSArray * dogs = [Dog findAll];
  STAssertEquals(shouldBe , [dogs count], @"Should have %d dogs , %d found" , 
                 shouldBe, [dogs count]);
	STAssertTrue([[aDog.name toXMLValue] isEqualToString: @"Helio&apos;s Coffee &amp; friends"],@"Should be Helio&apos;s Coffee &amp; friends , got %@" , [aDog.name toXMLValue]);
	STAssertTrue([[NSString fromXmlString:aDog.name] isEqualToString: @"Helio's Coffee & friends"],@"Should be Helio's Coffee & friends , got %@" , [aDog.name toXMLValue]);

	
}

-(void) testDogSave{
  
  Dog * aDog = [[Dog alloc] init];
  
  aDog.name = @"Judge";
  
  if(shouldBe == 0) {
   
    shouldBe = 100;
    
  }
  shouldBe += 1;
  [aDog save];
  NSArray * dogs = [Dog findAll];
  STAssertEquals(shouldBe , [dogs count], @"Should have %d dogs , %d found" , 
                 shouldBe, [dogs count]);
  
  [aDog release];
}

-(void) testDogUpdate{
  
  NSArray * dogs = [Dog findAll];

  Dog * aDog = [dogs objectAtIndex:0];
  
  aDog.name = @"Judge";
  [aDog update];
  if(shouldBe == 0) {
    
    shouldBe = 100;
    
  }
  STAssertEquals(shouldBe , [dogs count], @"Should have %d dogs , %d found" , 
                 shouldBe, [dogs count]);
  
}

-(void) testDogDelete {
 
  NSArray * dogs = [Dog findAll];
  
  shouldBe = [dogs count] - 1;
  
  [(Dog *)[dogs objectAtIndex:0] destroy];
  
  dogs = [Dog findAll];
  STAssertEquals(shouldBe , [dogs count], @"Should have %d dogs , %d found" , 
                 shouldBe ,[dogs count]);
  
}

  
@end
  
