//
//  NSObject+JSONSerializableSupport.m
//  active_resource
//
//  Created by vickeryj on 1/8/09.
//  Copyright 2009 Joshua Vickery. All rights reserved.
//

#import "NSObject+JSONSerializableSupport.h"
#import "JSONFramework.h"
#import "ActiveResourceSupport.h"

@interface NSObject (JSONSerializableSupport_Private)
+ (id) deserializeJSON:(id)jsonObject;
@end

@implementation NSObject (JSONSerializableSupport)

+ (id)fromJSONData:(NSData *)data {
	NSString *jsonString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	id jsonObject = [jsonString JSONValue];
	return [self deserializeJSON:jsonObject];

}

+ (id) deserializeJSON:(id)jsonObject {
	id result = nil;
	if ([jsonObject isKindOfClass:[NSArray class]]) {
		//JSON array
		result = [NSMutableArray array];
		for (id childObject in jsonObject) {
			[result addObject:[self deserializeJSON:childObject]];
		}
	}
	else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
		//JSON object
		//this assumes we are dealing with JSON in the form rails provides:
		// {className : { property1 : value, property2 : {class2Name : {property 3 : value }}}}
		NSString *objectName = [[(NSDictionary *)jsonObject allKeys] objectAtIndex:0];
		
		Class objectClass = NSClassFromString([objectName toClassName]);
		if (objectClass != nil) {
			//classname matches, instantiate a new instance of the class and set it as the current parent object
			result = [[[objectClass alloc] init] autorelease];
		}
		
		NSDictionary *properties = (NSDictionary *)[[(NSDictionary *)jsonObject allValues] objectAtIndex:0];
		
		NSArray *objectPropertyNames = [objectClass propertyNames];
		
		for (NSString *property in [properties allKeys]) {
			NSString *propertyCamalized = [property camelize];
			if ([objectPropertyNames containsObject:propertyCamalized]) {
				[result setValue:[self deserializeJSON:[properties objectForKey:property]] forKey:propertyCamalized];
			}
		}
	}
	else {
		//JSON value
		result = jsonObject;
	}
	return result;
}

@end
