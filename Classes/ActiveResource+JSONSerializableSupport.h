//
//  ActiveResource+JSONSerialization.h
//  active_resource
//
//  Created by James Burka on 1/19/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//
#import "ActiveResource.h"

@interface ActiveResource(JSONSerializableSupport)
- (NSString *)toJSONAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations;
@end
