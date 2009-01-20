//
//  NSDate+Deserialize.m
//  active_resource
//
//  Created by James Burka on 1/19/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "NSDate+Serialize.h"
#import "ObjectiveResourceDateFormatter.h"


@implementation NSDate(Serialize)

+ (NSDate *) deserialize:(id)value {
	return [ObjectiveResourceDateFormatter parseDateTime:value];
}

- (NSString *) serialize {
	return [ObjectiveResourceDateFormatter formatDate:self];
}

@end
