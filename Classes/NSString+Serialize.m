//
//  NSString+Deserialize.m
//  active_resource
//
//  Created by James Burka on 1/19/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "NSString+Serialize.h"


@implementation NSString(Serialize)

+ (NSString *) deserialize:(id)value {
	return [NSString stringWithFormat:@"%@",value];
}


@end
