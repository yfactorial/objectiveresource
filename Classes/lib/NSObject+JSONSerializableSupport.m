//
//  NSObject+JSONSerializableSupport.m
//  active_resource
//
//  Created by vickeryj on 1/8/09.
//  Copyright 2009 Joshua Vickery. All rights reserved.
//

#import "NSObject+JSONSerializableSupport.h"
#import "NSDictionary+JSONSerializableSupport.h"
#import "Serialize.h"
#import "JSONFramework.h"
#import "ObjectiveSupport.h"

@interface NSObject (JSONSerializableSupport_Private)
+ (id) deserializeJSON:(id)jsonObject;
- (NSString *) convertProperty:(NSString *)propertyName;
- (NSString *) jsonClassName;
@end

@implementation NSObject (JSONSerializableSupport)

+ (id)fromJSONData:(NSData *)data {
	NSString *jsonString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	id jsonObject = [jsonString JSONValue];
	return [self deserializeJSON:jsonObject];

}

- (NSString *)toJSON {
	return [self toJSONAs:[self jsonClassName] excludingInArray:[NSArray array] withTranslations:[NSDictionary dictionary]];
}

- (NSString *)toJSONExcluding:(NSArray *)exclusions {
	return [self toJSONAs:[self jsonClassName] excludingInArray:exclusions withTranslations:[NSDictionary dictionary]];
}

- (NSString *)toJSONAs:(NSString *)rootName {
	return [self toJSONAs:rootName excludingInArray:[NSArray array] withTranslations:[NSDictionary dictionary]];	
}

- (NSString *)toJSONAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions {
	return [self toJSONAs:rootName excludingInArray:exclusions withTranslations:[NSDictionary dictionary]];		
}

- (NSString *)toJSONAs:(NSString *)rootName withTranslations:(NSDictionary *)keyTranslations {
	return [self toJSONAs:rootName excludingInArray:[NSArray array] withTranslations:keyTranslations];		
}

- (NSString *)toJSONAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations {
	
	return [[self properties] toJSONAs:rootName excludingInArray:exclusions withTranslations:keyTranslations];
	
}

+ (id) propertyClass:(NSString *)className {
	return NSClassFromString([className toClassName]);
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
		
		NSDictionary *objectPropertyNames = [objectClass propertyNamesAndTypes];
		
		for (NSString *property in [properties allKeys]) {
			NSString *propertyCamalized = [[self convertProperty:property] camelize];
			if ([[objectPropertyNames allKeys]containsObject:propertyCamalized]) {
				Class propertyClass = [self propertyClass:[objectPropertyNames objectForKey:propertyCamalized]];
				[result setValue:[self deserializeJSON:[propertyClass deserialize:[properties objectForKey:property]]] forKey:propertyCamalized];
			}
		}
	}
	else {
		//JSON value
		result = jsonObject;
	}
	return result;
}

- (NSString *) convertProperty:(NSString *)propertyName {
	if([propertyName isEqualToString:@"id"]) {
		propertyName = [NSString stringWithFormat:@"%@_id",[self jsonClassName]];
	}
	return propertyName;
}

- (NSString *)jsonClassName {
		NSString *className = NSStringFromClass([self class]);
		return [[className stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[className substringToIndex:1] lowercaseString]] underscore];
}

@end
