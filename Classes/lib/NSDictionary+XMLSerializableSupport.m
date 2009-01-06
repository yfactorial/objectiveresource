//
//  NSDictionary+XMLSerializableSupport.m
//  medaxion
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSObject+XMLSerializableSupport.h"

@implementation NSDictionary (XMLSerializableSupport)

+ (NSString *)xmlTranslationForKey:(NSString *)key withTranslations:(NSDictionary *)keyTranslations {
	NSString *newKey = [keyTranslations objectForKey:key];
	return (newKey ? newKey : key);	
}

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations {
	
	NSMutableString* elementValue = [NSMutableString string];
	id value;
	NSString *propertyRootName;
	for (NSString *key in self) {
		// Create XML if key not in exclusion list
		if(![exclusions containsObject:key]) {
			value = [self valueForKey:key];
			propertyRootName = [[self class] xmlTranslationForKey:key withTranslations:keyTranslations];
			[elementValue appendString:[value toXMLElementAs:propertyRootName]];
		}
	}
	return [[self class] buildXmlElementAs:rootName withInnerXml:elementValue];
}

@end
