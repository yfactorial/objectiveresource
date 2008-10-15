//
//  DogTest.m
//  active_resource
//
//  Created by James Burka on 10/15/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import "DogTest.h"
#import "Dog.h"

@implementation DogTest

-(void) testDogProperties {
 
  Dog * aDog = [[Dog alloc] init];
  STAssertTrue([aDog respondsToSelector: @selector(dogId)],@"Din't find dogId");
  
}

@end
