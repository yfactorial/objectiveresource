//
//  NSDictionary+KeyTranslation.m
//  active_resource
//
//  Created by James Burka on 1/15/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "NSDictionary+KeyTranslation.h"


@implementation NSDictionary(KeyTranslation)

+ (NSString *)translationForKey:(NSString *)key withTranslations:(NSDictionary *)keyTranslations {
	NSString *newKey = [keyTranslations objectForKey:key];
	return (newKey ? newKey : key);	
}

@end
