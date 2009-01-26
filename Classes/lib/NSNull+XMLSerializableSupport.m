//
//  NSNull+XMLSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSNull+XMLSerializableSupport.h"

@implementation NSNull (XMLSerializableSupport)

- (NSString *)toXMLValue {
	return @"";
}

@end
