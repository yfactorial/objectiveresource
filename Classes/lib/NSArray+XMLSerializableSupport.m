//
//  NSArray+XMLSerializableSupport.m
//  
//
//  Created by vickeryj on 9/29/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import "NSArray+XMLSerializableSupport.h"
#import "NSObject+XMLSerializableSupport.h"


@implementation NSArray (XMLSerializableSupport)

- (NSString *)toXMLValue {
	NSMutableString *result = [NSMutableString string];
	
	for (id element in self) {
		[result appendString:[element toXMLElement]];
	}
	
	return result;
}

@end
