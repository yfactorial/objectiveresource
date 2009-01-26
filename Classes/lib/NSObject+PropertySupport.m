//
//  NSObject+Properties.m
//  
//
//  Created by Ryan Daigle on 7/28/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "objc/runtime.h"
#import "NSObject+PropertySupport.h"

@interface NSObject()

+ (NSString *) getPropertyType:(NSString *)attributeString;

@end


@implementation NSObject (PropertySupport)
+ (NSArray *)propertyNames {
	return [[self propertyNamesAndTypes] allKeys];
}

+ (NSDictionary *)propertyNamesAndTypes {
	NSMutableDictionary *propertyNames = [NSMutableDictionary dictionary];
	
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
			NSString *type = [NSString stringWithCString:property_getAttributes(*prop) encoding:NSUTF8StringEncoding];
			propName = [NSString stringWithCString:property_getName(*prop) encoding:NSUTF8StringEncoding];
			[propertyNames setObject:[self getPropertyType:type] forKey:propName];
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

+ (NSString *) getPropertyType:(NSString *)attributeString {
	NSString *type = [NSString string];
	NSScanner *typeScanner = [NSScanner scannerWithString:attributeString];
	[typeScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"@"] intoString:NULL];
	
	// we are not dealing with an object
	if([typeScanner isAtEnd]) {
		return @"NULL";
	}
	[typeScanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"@"] intoString:NULL];
	// this gets the actual object type
	[typeScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&type];
	return type;
}

@end
