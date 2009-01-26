//
//  ObjectiveResource+JSONSerialization.m
//  active_resource
//
//  Created by James Burka on 1/19/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "ObjectiveResource+JSONSerializableSupport.h"
#import "ObjectiveSupport.h"

@implementation ObjectiveResource(JSONSerializableSupport)
- (NSString *)toJSONAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations {
	return [[self properties] toJSONAs:rootName excludingInArray:exclusions withTranslations:keyTranslations];
}
@end
