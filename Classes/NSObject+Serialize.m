//
//  NSObject+Deserialize.m
//  active_resource
//
//  Created by James Burka on 1/19/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "NSObject+Serialize.h"


@implementation NSObject(Serialize)

+ (id)deserialize:(id)value {
	return value;
}

- (id) serialize {
	return self;
}

@end
