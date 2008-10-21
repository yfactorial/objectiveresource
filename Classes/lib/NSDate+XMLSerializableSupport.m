//
//  NSDate+XMLSerializableSupport.m
//  medaxion
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSDate+XMLSerializableSupport.h"
#import "ObjectiveResourceDateFormatter.h"

@implementation NSDate (XMLSerializableSupport)

//FIXME we should have one formatter for the entire app

- (NSString *)toXMLValue {
	return [ ObjectiveResourceDateFormatter formatDate:self]; 
}

+ (NSDate *)fromXMLString:(NSString *)xmlString {
	return [ ObjectiveResourceDateFormatter parseDate:xmlString];
}



@end
