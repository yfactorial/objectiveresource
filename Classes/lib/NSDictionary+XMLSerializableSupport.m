//
//  NSDictionary+XMLSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSObject+XMLSerializableSupport.h"
#import "NSDictionary+KeyTranslation.h"

@implementation NSDictionary (XMLSerializableSupport)



- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations {
	
	NSMutableString* elementValue = [NSMutableString string];
	id value;
	NSString *propertyRootName;
	for (NSString *key in self) {
		// Create XML if key not in exclusion list
		if(![exclusions containsObject:key]) {
			value = [self valueForKey:key];
			propertyRootName = [[self class] translationForKey:key withTranslations:keyTranslations];
			[elementValue appendString:[value toXMLElementAs:propertyRootName]];
		}
	}
	return [[self class] buildXmlElementAs:rootName withInnerXml:elementValue];
}

@end
