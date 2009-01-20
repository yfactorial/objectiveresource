//
//  NSDictionary+JSONSerialization.h
//  active_resource
//
//  Created by James Burka on 1/15/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

@interface NSDictionary(JSONSerializableSupport)

- (NSString *)toJSONAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations;

@end
