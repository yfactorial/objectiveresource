//
//  NSObject+Properties.m
//  medaxion
//
//  Created by Ryan Daigle on 7/28/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "objc/runtime.h"
#import "NSObject+PropertySupport.h"

@implementation NSObject (PropertySupport)

+ (NSArray *)propertyNames {
	NSMutableArray *propertyNames = [NSMutableArray array];
	
	//include superclass properties
	Class currentClass = [self class];
	while (currentClass != nil) {
		// Get the raw list of properties
		unsigned int outCount;
		objc_property_t *propList = class_copyPropertyList(currentClass, &outCount);
		
		// Collect the property names
		int i;
		NSString *propName;
		for (i = 0; i < outCount; i++)
		{
			objc_property_t * prop = propList + i;
			propName = [NSString stringWithCString:property_getName(*prop) encoding:NSUTF8StringEncoding];
			[propertyNames addObject:propName];
		}
		
		free(propList);
		currentClass = [currentClass superclass];
	}
	return propertyNames;
}

- (NSDictionary *)properties {
	return [self dictionaryWithValuesForKeys:[[self class] propertyNames]];
}

- (void)setProperties:(NSDictionary *)overrideProperties {
	for (NSString *property in [overrideProperties allKeys]) {
		[self setValue:[overrideProperties objectForKey:property] forKey:property];
	}
}

@end
