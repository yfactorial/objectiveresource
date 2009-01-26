//
//  NSDictionary+JSONSerialization.m
//  active_resource
//
//  Created by James Burka on 1/15/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "JSONFramework.h"
#import "NSDictionary+KeyTranslation.h"
#import "NSDictionary+JSONSerializableSupport.h"
#import "ObjectiveSupport.h"
#import "Serialize.h"

@implementation NSDictionary(JSONSerializableSupport)

- (NSString *)toJSONAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations {
	
	NSMutableDictionary *props = [NSMutableDictionary dictionary];	
	for (NSString *key in self) {
		if(![exclusions containsObject:key]) {
			NSString *convertedKey = [[self class] translationForKey:key withTranslations:keyTranslations];
			[props setObject:[[self objectForKey:key] serialize] forKey:[convertedKey underscore]];
		}
	}
	return [[NSDictionary dictionaryWithObject:props forKey:rootName]JSONRepresentation];	
}

@end
